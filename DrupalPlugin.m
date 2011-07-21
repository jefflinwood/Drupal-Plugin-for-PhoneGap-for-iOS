//
//  DrupalPlugin.m
//
//  Copyright 2011 Jeff Linwood.
//  MIT License


#import "DrupalPlugin.h"
#import "DIOSNode.h"
#import "DIOSViews.h"


@implementation DrupalPlugin


@synthesize currentUser;
@synthesize currentSession;

#pragma mark -
#pragma mark Private Methods


#pragma mark -
#pragma mark Public Methods



- (void) openAnonymousSession:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString* callbackId = [arguments objectAtIndex:0];
    
	self.currentSession = [[[DIOSConnect alloc] init] autorelease];
    self.currentUser = nil;
    
    if ([self.currentSession connResult]) {
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[self.currentSession connResult]];
        [super writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];        
    } else {
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[self.currentSession connResult]];
        [super writeJavascript:[pluginResult toErrorCallbackString:callbackId]];        
    }
}



- (void) login:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString* callbackId = [arguments objectAtIndex:0];

	self.currentSession = [[[DIOSConnect alloc] init] autorelease];
    DIOSUser *user = [[DIOSUser alloc] initWithSession:self.currentSession];
    [user loginWithUsername:[options objectForKey:@"username"] andPassword:[options objectForKey:@"password"]];
    
    //if the login was successful (we can check for a uid on the connection result user), set the current user on the Drupal plugin
    if ([[[user connResult] objectForKey:@"user"] objectForKey:@"uid"]) {
        self.currentUser = user;
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[user connResult]];
        [super writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];        
    } else {
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[user connResult]];
        [super writeJavascript:[pluginResult toErrorCallbackString:callbackId]];        
    }
    [user release]; 
}

- (void) logout:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString* callbackId = [arguments objectAtIndex:0];
    
	self.currentSession = [[[DIOSConnect alloc] init] autorelease];
    DIOSUser *user = [[DIOSUser alloc] initWithSession:self.currentSession];
    [user logout];
    
    if ([user connResult]) {
        self.currentUser = user;
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[user connResult]];
        [super writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];        
    } else {
        PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:[user connResult]];
        [super writeJavascript:[pluginResult toErrorCallbackString:callbackId]];        
    }
    [user release]; 
}

- (void) nodeGet:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString* callbackId = [arguments objectAtIndex:0];
    
    DIOSNode *diosNode = [[DIOSNode alloc] initWithSession:self.currentSession];
    NSDictionary* node = [diosNode nodeGet:[options objectForKey:@"nid"]];
    
    PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:node];
    [super writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];        
    [node release];
}


- (void) viewGet:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options {
    NSString* callbackId = [arguments objectAtIndex:0];
    
    DIOSViews *diosViews = [[DIOSViews alloc] initWithSession:self.currentSession];
    NSArray* view = (NSArray*) [diosViews viewsGet:[options objectForKey:@"viewName"]];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:view,@"view", nil];
    PluginResult *pluginResult = [PluginResult resultWithStatus:PGCommandStatus_OK messageAsDictionary:dict];
    [super writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];        
    [dict release];
    [view release];
}

@end
