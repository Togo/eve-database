//
//  DatabaseImplementation.h
//  Database
//
//  Created by Tobias Sommer on 10/27/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueuedDatabase.h"
#import "Migration.h"

@interface CoreDatabase : NSObject <QueuedDatabase, Migration>

@end
