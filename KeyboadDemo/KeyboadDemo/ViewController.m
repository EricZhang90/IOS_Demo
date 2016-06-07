//
//  ViewController.m
//  KeyboadDemo
//
//  Created by Eric on 2016-01-30.
//  Copyright © 2016 Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonLayoutConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *ctr = [NSNotificationCenter defaultCenter];
    
    [ctr addObserver:self
         selector:@selector(moveKeyboardInResponseToWillShowNotification:)
         name:UIKeyboardWillShowNotification
         object:nil];

    [ctr addObserver:self
         selector:@selector(moveKeyboardInResponseToWillHideNotification:)
         name:UIKeyboardWillHideNotification
         object:nil];
    
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)resignButton:(id)sender {
    [self.textfield resignFirstResponder];
}

- (void)moveKeyboardInResponseToWillShowNotification: (NSNotification *) notification{
    NSDictionary *info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    [self adjustView:info :kbRect];
}

- (void)moveKeyboardInResponseToWillHideNotification: (NSNotification *) notification{
    
    NSDictionary *info = [notification userInfo];
    CGRect buttonRect = CGRectZero;
    [self adjustView:info :buttonRect];
}

-(void)adjustView: (NSDictionary *)info :(CGRect)rect{
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [self.view layoutSubviews];
    
    //Animate:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.buttonLayoutConstraint.constant = rect.size.height;
    [self.view layoutSubviews];
    [UIView commitAnimations];
}

@end

