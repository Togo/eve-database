//
//  DatabaseMigration.h
//  Database
//
//  Created by Tobias Sommer on 10/30/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Migration.h"

@interface DatabaseMigration : NSObject <Migration>

@property (strong, nonatomic) NSMutableArray *migrationsToExecute;

- (void) executeMigrations :(NSString*) databasePath;
- (void) addMigrationObject :(id) migrationObject;

@end
