//
//  FacebookManager.m
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import "FacebookManager.h"
#import "AppDelegate.h"

static FacebookManager *facebookManager;

@interface FacebookManager()
- (void)setupFacebookManager;
@end

@implementation FacebookManager

@synthesize facebook    = _facebook;
@synthesize openedURL   = _openedURL;
@synthesize delegate    = _delegate;

/*
 * Singleton de la clase FacebookManager, se deberá utilizar este metodo para crear
 * instancias de la clase.
 */
+ (FacebookManager *)sharedManager
{
    if (facebookManager == nil) {
        facebookManager = [[super allocWithZone:NULL] init];
        [facebookManager setupFacebookManager];
    }
    
    return facebookManager;
}

/*
 * Configura el FacebookManager
 */
- (void)setupFacebookManager
{
    DebugLog(@"Setup Facebook Manager");
    
    // Inicializar la instancia de facebook
    _facebook = [[Facebook alloc] initWithAppId:kFBAppId andDelegate:self];
    
    DebugLog(@"FBAppId: %@", kFBAppId);
    
    // Comprobar si el token de acceso de facebook ha sido almacenada en el equipo
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kFBAccessTokenKey] && [defaults objectForKey:kFBExpirationDateKey]) {
        DebugLog(@"Found Token in User Defaults");
        
        // Setear el token de acceso
        _facebook.accessToken = [defaults objectForKey:kFBAccessTokenKey];
        _facebook.expirationDate = [defaults objectForKey:kFBExpirationDateKey];
    }
}

#pragma mark - Delegate methods que llaman los View Controllers

- (void)loginWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate
{
    DebugLog(@"Login with Delegate");
    
    self.delegate = delegate;

    [_facebook authorize:nil];
}

- (void)loginWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate andPermissions:(NSArray *)permissions
{
    DebugLog(@"Login With Delegate and Persmissions");
    self.delegate = delegate;
    
    [_facebook authorize:permissions];
}

- (void)logoutWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate
{
    DebugLog(@"Logout with Delegate");
    self.delegate = delegate;
    [_facebook logout];
}

- (void)sendRequest
{
    DebugLog(@"Send Request");
    SBJSON *jsonWriter = [SBJSON new];
    NSDictionary *gift = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"5", @"social_karma",
                          @"1", @"badge_of_awesomeness",
                          nil];
    
    NSString *giftStr = [jsonWriter stringWithObject:gift];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Learn how to make your iOS apps social.",  @"message",
                                   @"Check this out", @"notification_text",
                                   giftStr, @"data",
                                   nil];
    
    [_facebook dialog:@"apprequests"
           andParams:params
         andDelegate:self];
}

#pragma mark - Helper methods

/**
 * Metodo para parsear los parametros de un url
 */
- (NSDictionary*)parseURLParams:(NSString *)query {
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	
    for (NSString *pair in pairs) {
		NSArray *kv = [pair componentsSeparatedByString:@"="];
		NSString *val =
        [[kv objectAtIndex:1]
         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
		[params setObject:val forKey:[kv objectAtIndex:0]];
	}
    return params;
}

- (void)sendInvites:(NSString *)message {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   message,  @"message",
                                   nil];
    
    [_facebook dialog:@"apprequests"
           andParams:params
         andDelegate:self];
}

#pragma mark - FBSession Delegate methods

- (void)fbDidLogin
{
    DebugLog(@"fbDidLogin");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    DebugLog(@"AccessToken: %@ - ExpirationDate: %@", [_facebook accessToken], [_facebook expirationDate]);
    
    [defaults setObject:[_facebook accessToken] forKey:kFBAccessTokenKey];
    [defaults setObject:[_facebook expirationDate] forKey:kFBExpirationDateKey];
    [defaults synchronize];
    
    if ([self.delegate respondsToSelector:@selector(facebookLoginDidSucceed)]) {
        DebugLog(@"Call to Login did Succeed");
        [self.delegate facebookLoginDidSucceed];
    }
}

- (void)fbDidLogout
{
    DebugLog(@"fbDidLogout");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kFBAccessTokenKey]) {
        [defaults removeObjectForKey:kFBAccessTokenKey];
        [defaults removeObjectForKey:kFBExpirationDateKey];
        [defaults synchronize];
    }
    
    if ([self.delegate respondsToSelector:@selector(facebookLogoutDidSucceed)]) {
        [self.delegate facebookLogoutDidSucceed];
    }
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
    DebugLog(@"fbDidNotLogin");
}

- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    DebugLog(@"fbDidExtendToken");
}

- (void)fbSessionInvalidated
{
    DebugLog(@"fbSessionInvalidated");
}

#pragma mark - FBDialog Delegate methods

/**
 * Called when a UIServer Dialog successfully return. Using this callback
 * instead of dialogDidComplete: to properly handle successful shares/sends
 * that return ID data back.
 */
- (void)dialogCompleteWithUrl:(NSURL *)url {
    if (![url query]) {
        NSLog(@"User canceled dialog or there was an error");
        return;
    }
    
    NSDictionary *params = [self parseURLParams:[url query]];
    if ([params objectForKey:@"request"]) {
        // Successful requests are returned in the form:
        // request=1001316103543&to[0]=100003086810435&to[1]=100001482211095
        NSLog(@"Request ID: %@", [params objectForKey:@"request"]);
    }
}

#pragma mark - FBRequest Delegate methods

- (void)request:(FBRequest *)request didLoad:(id)result
{
    DebugLog(@"Request did load");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    DebugLog(@"Request did fail with error");
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    DebugLog(@"Request did Receive Response");
}

@end
