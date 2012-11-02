//
//  Database.h
//  Database
//
//  Created by Tobias Sommer on 10/27/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "DatabaseMigration.h"

@protocol QueuedDatabase <NSObject>

@property (strong, nonatomic) DatabaseMigration     *migration;
@property (strong, nonatomic) FMDatabaseQueue       *queuedDatabase;
@property (strong, nonatomic) FMDatabase            *database;
@property (strong, nonatomic) NSString              *databaseName;
@property (strong, nonatomic) NSString              *databasePath;

- (id) initWithNameAndPath :(NSString*) name :(NSString*) path;
- (void) createDatabaseConnection;
- (BOOL) openConnection;
- (BOOL) closeConnection;

- (NSArray*) executeQuery :(NSString*) query;
- (BOOL) executeUpdate :(NSString*) query;

- (void) printErrorMessage;

@end
