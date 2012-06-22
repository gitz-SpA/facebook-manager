//
//  ViewController.m
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import "LoginViewController.h"
#import "FacebookManager.h"

@interface LoginViewController ()

- (void)pushToHome;

@end

@implementation LoginViewController

@synthesize facebookButton = _facebookButton;

- (void)viewDidLoad
{
    DebugLog(@"Logged In?");
    
    if (![[[FacebookManager sharedManager] facebook] isSessionValid]) {
        DebugLog(@"Session is not Valid");
    }
    else {
        DebugLog(@"Session is Valid");
        [self pushToHome];
    }
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)facebookButtonPressed:(UIButton *)button
{
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
    [[FacebookManager sharedManager] loginWithDelegate:self andPermissions:permissions];
}

- (void)facebookLoginDidSucceed
{
    NSLog(@"ACCESS TOKEN: %@", [[[FacebookManager sharedManager] facebook] accessToken]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"ACCESS TOKEN2: %@", [defaults objectForKey:kFBAccessTokenKey]);
}

- (void)pushToHome
{
    [self performSegueWithIdentifier:@"pushToHomeFromLogin" sender:self];
    self.navigationController.navigationBar.hidden = NO;
}

@end
