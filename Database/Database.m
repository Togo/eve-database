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

@synthesize migration;

- (id) initWithNameAndPath :(NSString*) name :(NSString*) path {
  self = [super init];
  
  self.databaseName = name;
  
  if (![path hasSuffix:@"/"] ) {
    path = [NSString stringWithFormat:@"%@/", path ];
  }
  
  self.databasePath = [NSString stringWithFormat:@"%@%@", path, self.databaseName];
  
  [self createDatabaseConnection];
  
  self.migration = [[DatabaseMigration alloc] init];
  
  return self;
}

- (void) createDatabaseConnection {
  self.database = [FMDatabase databaseWithPath:[self databasePath]];
  self.queuedDatabase = [FMDatabaseQueue databaseQueueWithPath:[self databasePath]];
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
        [results addObject:[resultSet resultDictionary]];
      }
    }
    [db closeOpenResultSets];
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

- (void) addMigrationObject :(id) migrationObject {
  [migration addMigrationObject :migrationObject];
}

- (void) executeMigrations :(NSString*) path {
  [migration executeMigrations :path];
}

- (void) printErrorMessage {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

@end
