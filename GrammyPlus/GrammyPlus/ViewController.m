//
//  ViewController.m
//  GrammyPlus
//
//  Created by Eric on 2015-11-10.
//  Copyright © 2015 Eric. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoutButton.enabled = self.refreshButton.enabled = false;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.loginButton.enabled = false;
    self.logoutButton.enabled = self.refreshButton.enabled = true;
}

- (IBAction)logoutButtonPressed:(id)sender {
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray* accounts = [store accountsWithAccountType:@"Instagram"];
    
    for (id account in accounts) {
        [store removeAccount:account];
    }
    
    self.logoutButton.enabled = self.refreshButton.enabled = false;
    self.loginButton.enabled = true;
}

- (IBAction)refreshButtonPressed:(id)sender {
    NSArray* accounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    
    if ([accounts count] == 0) {
        NSLog(@"Warning: 0 Instagram account login ");
        return;
    }
    
    NXOAuth2Account* account = accounts[0];
    
    NSString* token= account.accessToken.accessToken;
    NSString* urlStr = [@"https://api.instagram.com/v1/users/self/feed?access_token=" stringByAppendingString:token];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLSession* session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:
            ^(NSData* _Nullable data, NSURLResponse* _Nullable response, NSError* err){
        
                // check for network error
                if(err){
                    NSLog(@"Error: Couldn't finish request: %@", err);
                    return;
                }
        
                // check for http error
                NSHTTPURLResponse* httpResquest = (NSHTTPURLResponse *)response;
                if(httpResquest.statusCode < 200 || httpResquest.statusCode >= 300){
                    NSLog(@"Error: Got status code %ld", httpResquest.statusCode);
                    return;
                }
        
                // check for JSON parse error
                NSError* parseErr;
                id pkg = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                              error:&parseErr];
                if (parseErr) {
                    NSLog(@"Error; Couldn't parse response %@", parseErr);
                    return;
                }
                
                NSString* imageURLStr = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
                NSURL* imageURL = [NSURL URLWithString:imageURLStr];
                
                [[session dataTaskWithURL:imageURL completionHandler:
                    ^(NSData* _Nullable data, NSURLResponse* _Nullable response, NSError* err){
                    
                        // check for network error
                        if(err){
                            NSLog(@"Error: Couldn't finish request: %@", err);
                            return;
                        }
                    
                        // check for http error
                        NSHTTPURLResponse* httpResquest = (NSHTTPURLResponse *)response;
                        if(httpResquest.statusCode < 200 || httpResquest.statusCode >= 300){
                            NSLog(@"Error: Got status code %ld", httpResquest.statusCode);
                            return;
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.imageView.image = [UIImage imageWithData:data];
                        });

                    }
                    ] resume];
                
            }

      ] resume];
    
}

@end
