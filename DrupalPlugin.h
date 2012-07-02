//
//  DrupalPlugin.h
//
//  Copyright 2011 Jeff Linwood.
//  MIT License

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#ifdef CORDOVA_FRAMEWORK
#import <CORDOVA/CDVPlugin.h>
#else
#import "CDVPlugin.h"
#endif

#import "DIOSUser.h"
#import "DIOSConnect.h"



@interface DrupalPlugin : CDVPlugin {
    DIOSUser *currentUser;
    DIOSConnect *currentSession;
    
}

@property(nonatomic,retain) DIOSUser *currentUser;
@property(nonatomic,retain) DIOSConnect *currentSession;

//user/system connect methods
- (void) openAnonymousSession:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) login:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) logout:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//node methods
- (void) nodeGet:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) nodeSave:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) nodeDelete:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) nodeGetIndex:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//file methods
- (void) fileSave:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

//view methods
- (void) viewGet:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
