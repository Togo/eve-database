//
//  TableAndColumnNames.h
//  Database
//
//  Created by Tobias Sommer on 11/2/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//


#import <Foundation/Foundation.h>

// Name Table
extern NSString * const GUI_ELEMENTS_TABLE;
extern NSString * const SHORTCUTS_TABLE;
extern NSString * const MENU_BAR_ITEMS_TABLE;
extern NSString * const APPLICATIONS_TABLE;
extern NSString * const USER_DATA_TABLE;
extern NSString * const DISABLED_SHORTCUTS_TABLE;
extern NSString * const GUI_SUPPORT_TABLE;
extern NSString * const DISPLAYED_SHORTCUTS_TABLE;
extern NSString * const MENU_BAR_SEARCH_TABLE;
extern NSString * const GLOB_DISABLED_SHORTCUTS_TABLE;
extern NSString * const APPLICATION_BLACKLIST_TABLE;

// global Columns
extern NSString * const ID_COL;
extern NSString * const APPLICATION_ID_COL;
extern NSString * const SHORTCUT_ID_COL;
extern NSString * const USER_ID_COL;
extern NSString * const IDENTIFIER_COL;
extern NSString * const LANG_COL;
extern NSString * const TIMESTAMP;
extern NSString * const MODULE_ID_COL;

// Shortcut Table Columns
extern NSString * const SHORTCUT_STRING_COL;

// Application Table Columns
extern NSString * const APP_NAME_COL;
extern NSString * const BUNDLE_IDEN_COL;
extern NSString * const GUI_SUPPORT_COL;
extern NSString * const MENU_BAR_SUPPORT_COL;

// User Data Table Columns
extern NSString * const USER_NAME_COL;
extern NSString * const START_AT_LOGIN_COL;

// GUI Elements
extern NSString * const TITLE_COL;
extern NSString * const PARENT_TITLE_COL;
extern NSString * const HELP_COL;
extern NSString * const COCOA_IDENTIFIER_COL;

// dynamic table header
extern NSString * const DISABLED_SHORTCUT_DYN_COL;
extern NSString * const GLOB_DISABLED_SHORTCUT_DYN_COL;

