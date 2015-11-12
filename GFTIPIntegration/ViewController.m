//
//  ViewController.m
//  GFTIPIntegration
//
//  Created by sreenivasulareddy on 25/09/15.
//  Copyright (c) 2015 sreenivasulareddy. All rights reserved.
//

#import "ViewController.h"
#import "SECViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface ViewController ()<FBSDKLoginButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    
        
NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@",tileDirectory);
    
//    [FBSession openActiveSessionWithReadPermissions:@[@"email",@"user_location",@"user_birthday",@"user_hometown"]
//                                       allowLoginUI:YES
//                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
//                                      
//                                      switch (state) {
//                                          case FBSessionStateOpen:
//                                              [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
//                                                  if (error) {
//                                                      NSLog(@"error:%@",error);
//                                                  }
//                                                  else
//                                                  {
//                                                      // retrive user's details at here as shown below
//                                                      NSLog(@"FB user first name:%@",user.first_name);
//                                                      NSLog(@"FB user last name:%@",user.last_name);
//                                                      NSLog(@"FB user birthday:%@",user.birthday);
//                                                      NSLog(@"FB user location:%@",user.location);
//                                                      NSLog(@"FB user username:%@",user.username);
//                                                      NSLog(@"FB user gender:%@",[user objectForKey:@"gender"]);
//                                                      NSLog(@"email id:%@",[user objectForKey:@"email"]);
//                                                      NSLog(@"location:%@", [NSString stringWithFormat:@"Location: %@\n\n",
//                                                                             user.location[@"name"]]);
//                                                      
//                                                  }
//                                              }];
//                                              break;
//                                              
//                                          case FBSessionStateClosed:
//                                          case FBSessionStateClosedLoginFailed:
//                                              [FBSession.activeSession closeAndClearTokenInformation];
//                                              break;
//                                              
//                                          default:
//                                              break;
//                                      }
//                                      
//                                  } ];
//    
    
}


- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name,bio,friends"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", result);
                 NSLog(@"%@",result[@"email"]);
             }
    }];
    }

    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"789751611137124"
parameters:@{@"fields":@"email,name,first_name,about,age_range,birthday,gender,currency,devices,education,hometown,languages,public_key,cover,website,work"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,id result,NSError *error) {
        NSLog(@"fetched user:%@", result);

    }];
    
    SECViewController *SEC = [[SECViewController alloc]initWithNibName:@"SECViewController" bundle:nil];
    [self.navigationController pushViewController:SEC animated:YES];
        [[FBSDKLoginManager new] logOut];


}
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"successfully logout" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"you successfully logout");
}



@end
