//
//  DatabaseTests.m
//  DatabaseTests
//
//  Created by Tobias Sommer on 10/27/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "DatabaseTests.h"
#import "CoreDatabase.h"

@implementation DatabaseTests

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

- (void)testCreateQueuedConnection
{
  CoreDatabase *db = [[CoreDatabase alloc] initWithNameAndPath:@"test.db" :@"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests/"];
  
  STAssertNotNil(db, @"Database object is nil");
  STAssertNotNil([db queuedDatabase], @"Database object is nil");
  STAssertNotNil([db migration], @"Database object is nil");
  STAssertTrue([[db database] open],@"");
  
  STAssertEqualObjects(db.databaseName, @"test.db", @"");
  STAssertEqualObjects(db.databasePath, @"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests/test.db", @"");
  
   db = [[CoreDatabase alloc] initWithNameAndPath:@"test.db" :@"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests"];
  STAssertEqualObjects(db.databasePath, @"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests/test.db", @"");
}

- (void) testCreateConnection {
  CoreDatabase *database = [[CoreDatabase alloc] initWithNameAndPath:@"test.db" :@"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests/"];

  [[database queuedDatabase] inDatabase:^(FMDatabase *db) {
    [db open];
    NSError *err;
    [db update:@"blah blah blah" withErrorAndBindings:&err];
    STAssertTrue([db hadError], @"error");
  }];
}

- (void) testExecuteUpdate {
  NSString *query = @"CREATE TABLE \"test_table\" ( \"applications\" string); ";
//  STAssertFalse([database executeUpdate:query], @"");
  
//  STAssertTrue([database executeUpdate:query], @"Should throw NSInternalInconsistencyException");
  
  query = @"DROP TABLE test_table;";
//  STAssertFalse([database executeUpdate:query], @"");
}

- (void) testexecuteQuery {
  CoreDatabase *database = [[CoreDatabase alloc] initWithNameAndPath:@"test.db" :@"/Users/Togo/dev/cocoa_librarys/Database/DatabaseTests/"];
  NSString *query = @"CREATE TABLE \"test_table\" ( \"applications\" string); ";
  STAssertFalse([database executeUpdate:query], @"");
  
  query = @"INSERT INTO \"test_table\" VALUES ( 'test' ); ";
  STAssertFalse([database executeUpdate:query], @"");
  query = @"INSERT INTO \"test_table\" VALUES ( 'test2' ); ";
  STAssertFalse([database executeUpdate:query], @"");

  query = @"SELECT * FROM test_table;";
  STAssertNotNil([database executeQuery:query], @"Result Set is nil");
  NSArray *results = [database executeQuery:query];
  STAssertTrue([results count] == 2, @"");
  
  STAssertEqualObjects([[results objectAtIndex:0] valueForKey:@"applications"], @"test", @"");
  
  query = @"DROP TABLE test_table;";
  STAssertFalse([database executeUpdate:query], @"");
}

@end
