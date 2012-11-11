//
//  DatabaseImplementation.m
//  Database
//
//  Created by Tobias Sommer on 10/27/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "CoreDatabase.h"

@implementation CoreDatabase

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
    
    if(![db open])
      [self printErrorMessage:@"Error open Database in executeQuery"];
    
    FMResultSet *resultSet = [db executeQuery:query];
    
    if ([db hadError]) {
      [self printErrorMessage :query];
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
    
    if(![db open])
      [self printErrorMessage:@"Error open Database in executeUpdate"];
    
    [db executeUpdate:query];
    if ([db hadError]) {
      error = TRUE;
      [self printErrorMessage :query];
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

- (void) printErrorMessage :(NSString*) query {
  [NSException raise:NSInternalInconsistencyException
              format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void) executeScript :(NSString*) script_name :(NSString*) fileType :(NSString*) dictionary_name {
  NSString *finalPath =  [[NSBundle mainBundle] pathForResource:script_name  ofType:fileType inDirectory:dictionary_name];
  NSData *myData = [NSData dataWithContentsOfFile:finalPath];
  
  if (myData) {
    NSString *sql = [NSString stringWithUTF8String:[myData bytes]];
    NSMutableArray * fileLines = [[NSMutableArray alloc] initWithArray:[sql componentsSeparatedByString:@";"] copyItems: YES];
    
    if ([fileLines count] == 0) {
      [self printErrorMessage:@"No Lines in SQL Script Array "];
    }
    
    [self.queuedDatabase inDatabase:^(FMDatabase *db) {
      
      if(![db open])
          [self printErrorMessage:@"Error open Database in executeUpdate"];
      
      for(NSString *query in fileLines)
        [db executeUpdate:query];
      
      [db close];
      }];
  } else {
    [self printErrorMessage:@"No Data in SQL Script"];
  }
}

@end
