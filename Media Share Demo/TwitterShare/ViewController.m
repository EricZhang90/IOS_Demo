//
//  ViewController.m
//  TwitterShare
//
//  Created by Eric on 2015-10-31.
//  Copyright © 2015 Eric. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *TwitterText;

-(void) configureTwitterTextView;

-(void) showMessage: (NSString*) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTwitterTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showMessage:(NSString *)myMessage{
    UIAlertController *showMessage = [UIAlertController alertControllerWithTitle:@"Tweet share" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [showMessage addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
     
     [self presentViewController:showMessage animated:YES completion:nil];
}

- (IBAction)showShare:(id)sender {
    if([self.TwitterText isFirstResponder]){
        [self.TwitterText resignFirstResponder];
    }
    
    UIActivityViewController *moreShare = [[UIActivityViewController alloc]
                                           initWithActivityItems:@[self.TwitterText.text]
                                           applicationActivities:nil];
                                           
    [self presentViewController:moreShare animated:YES completion:nil];
    
    /*
    UIAlertController *actionController = [UIAlertController
                                           alertControllerWithTitle:@"Message sharing"
                                           message:@"share your note"
                                           preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *tweet = [UIAlertAction actionWithTitle:@"Post to Tweet" style:UIAlertActionStyleDefault handler:
                                ^(UIAlertAction* action){
                                    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
                                        SLComposeViewController *TwitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                        if([self.TwitterText.text length] < 140){
                                            [TwitterVC setInitialText:self.TwitterText.text];
                                        }
                                        else{
                                            NSString *shortText = [self.TwitterText.text substringToIndex:140];
                                            [TwitterVC setInitialText:shortText];
                                        }
                                        [self presentViewController:TwitterVC animated:YES completion:nil];
                                    }
                                    else{
                                        [self showMessage:@"Sorry, please log in your Twitter account"];
                                    }
                                }
                            ];
    
    UIAlertAction* facebook = [UIAlertAction actionWithTitle:@"Post to FaceBook" style:UIAlertActionStyleDefault handler:
                                ^(UIAlertAction *action){
                                    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
                                        SLComposeViewController* facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                                        if([self.TwitterText.text length] < 140){
                                            [facebookVC setInitialText:self.TwitterText.text];
                                        }
                                        else{
                                            NSString *shortText = [self.TwitterText.text substringToIndex:140];
                                            [facebookVC setInitialText:shortText];
                                        }
                                        [self presentViewController:facebookVC animated:YES completion:nil];
                                    }
                                    else{
                                        [self showMessage:@"Sorry, please log in your FaceBook accout"];
                                    }
                                }
                               ];
    
    [actionController addAction:tweet];
    [actionController addAction:facebook];
    [actionController addAction:cancel];
    
    
    [self presentViewController:actionController
                        animated:YES
                        completion:nil];
     */
    
}

-(void) configureTwitterTextView{
    self.TwitterText.layer.backgroundColor = [UIColor colorWithRed:1.0
                                                             green:1.0
                                                              blue:0.9
                                                             alpha:1].CGColor;
    self.TwitterText.layer.cornerRadius = 15.0;
    self.TwitterText.layer.borderColor = [UIColor colorWithWhite:0
                                                           alpha:0.5].CGColor;
    self.TwitterText.layer.borderWidth = 3.0;
    
}

@end
