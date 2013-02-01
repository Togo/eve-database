//
//  TableAndColumnNames.m
//  Database
//
//  Created by Tobias Sommer on 11/2/12.
//  Copyright (c) 2012 Tobias Sommer. All rights reserved.
//

#import "TableAndColumnNames.h"

// table
NSString * const GUI_ELEMENTS_TABLE = @"gui_elements";
NSString * const SHORTCUTS_TABLE = @"shortcuts";
NSString * const MENU_BAR_ITEMS_TABLE = @"menu_bar_items";
NSString * const APPLICATIONS_TABLE = @"applications";
NSString * const USER_DATA_TABLE = @"user_data";
NSString * const DISABLED_SHORTCUTS_TABLE = @"disabled_shortcuts";
NSString * const GUI_SUPPORT_TABLE = @"gui_supported_apps";
NSString * const DISPLAYED_SHORTCUTS_TABLE = @"displayed_shortcuts";
NSString * const MENU_BAR_SEARCH_TABLE = @"menu_bar_search";
NSString * const GLOB_DISABLED_SHORTCUTS_TABLE = @"global_disabled_shortcuts";
NSString * const APPLICATION_BLACKLIST_TABLE = @"application_blacklist";

// global columns
NSString * const ID_COL = @"id";
NSString * const APPLICATION_ID_COL = @"application_id";
NSString * const SHORTCUT_ID_COL = @"shortcut_id";
NSString * const USER_ID_COL = @"user_id";
NSString * const IDENTIFIER_COL = @"identifier";
NSString * const LANG_COL = @"lang";
NSString * const TIMESTAMP = @"timestamp";
NSString * const MODULE_ID_COL = @"module_id";


// shortcut table
NSString * const SHORTCUT_STRING_COL = @"shortcut_string";

// Application Table Columns
NSString * const APP_NAME_COL = @"app_name";
NSString * const BUNDLE_IDEN_COL = @"bundle_identifier";


// User Data Table Columns
NSString * const USER_NAME_COL = @"user_name";
NSString * const START_AT_LOGIN_COL = @"start_at_login";

// GUI Elements
NSString * const TITLE_COL = @"element_title";
NSString * const PARENT_TITLE_COL = @"parent_title";
NSString * const HELP_COL = @"element_help";
NSString * const COCOA_IDENTIFIER_COL = @"cocoa_identifier";

// dynamic table header
NSString * const DISABLED_SHORTCUT_DYN_COL = @"disabled_shortcut";
NSString * const GLOB_DISABLED_SHORTCUT_DYN_COL = @"global_disabled_shortcuts";

