//
//  DatabaseMigration.m
//  Database
//
//  Created by Tobias Sommer on 10/30/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "DatabaseMigration.h"

@implementation DatabaseMigration

@synthesize migrationsToExecute;

- (id) init {
  self = [super init];
  
  if (self) {
    migrationsToExecute = [NSMutableArray array];
  }
  
  return self;
}

- (void) executeMigrations :(NSString*) databasePath {
  [FmdbMigrationManager executeForDatabasePath:databasePath withMigrations:migrationsToExecute];
}

- (void) addMigrationObject :(id) migrationObject {
  [migrationsToExecute addObject: migrationObject];
}

@end
