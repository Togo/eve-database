//
//  MigrationTests.m
//  Database
//
//  Created by Tobias Sommer on 10/30/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "MigrationTests.h"
#import "DatabaseMigration.h"

@implementation MigrationTests

- (void)setUp
{
  [super setUp];
  
  // Set-up code here.
}

- (void)tearDown
{
  // Tear-down code here.
  
  [super tearDown];
}

- (void)testInit
{
  DatabaseMigration *migrationManager = [[DatabaseMigration alloc] init];
  STAssertNotNil(migrationManager, @"migration Manager is nil");
  STAssertNotNil(migrationManager.migrationsToExecute, @"Array is nil");
}

- (void) testAddMigration {
  DatabaseMigration *migrationManager = [[DatabaseMigration alloc] init];
  [migrationManager addMigrationObject :[NSString string]];
  
  STAssertTrue([[migrationManager migrationsToExecute] count] == 1, @"Count in array wrong");
}

@end
