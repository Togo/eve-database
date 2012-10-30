//
//  DatabaseImplementation.m
//  Database
//
//  Created by Tobias Sommer on 10/27/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "Database.h"

@implementation Database

@synthesize database;
@synthesize queuedDatabase;
@synthesize databaseName;
@synthesize databasePath;

@synthesize migrationManager;

- (id) initWithNameAndPath :(NSString*) name :(NSString*) path {
  self = [super init];
  
  self.databaseName = name;
  self.databasePath = path;
  
  [self createDatabaseConnection];
  [self executeMigrations];
  
  return self;
}

- (void) createDatabaseConnection {
  NSString *finalPath = [NSString stringWithFormat:@"%@%@", self.databasePath, self.databaseName];
  self.database = [FMDatabase databaseWithPath:finalPath];
  self.queuedDatabase = [FMDatabaseQueue databaseQueueWithPath:finalPath];
  [self.database logsErrors];
}

- (BOOL) openConnection {
  return [self.database open];
}

- (BOOL) closeConnection {
  return [self.database close];
}

- (NSArray*) executeQuery :(NSString*) query {
  __block NSMutableArray *results = [NSMutableArray array];
  [self.queuedDatabase inDatabase:^(FMDatabase *db) {
    [db open];
    
    FMResultSet *resultSet = [db executeQuery:query];
    if ([db hadError]) {
      //      [self printErrorMessage];
    } else {
      while ([resultSet next]) {
        [results addObject:[resultSet resultDictionary] ];
      }
    }
    
    [db close];
  }];
  
  return results;
}

- (BOOL) executeUpdate :(NSString*) query {
  __block BOOL error;
  [self.queuedDatabase inDatabase:^(FMDatabase *db) {
    [db open];
    
    [db executeUpdate:query];
    if ([db hadError]) {
      error = TRUE;
//      [self printErrorMessage];
    } else {
      error = FALSE;
    }
    
    [db close];
  }];
  
  return error;
}

- (BOOL) executeMigrations {
  
}

- (void) printErrorMessage {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
