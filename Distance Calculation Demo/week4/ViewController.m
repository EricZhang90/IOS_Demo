//
//  ViewController.m
//  week4
//
//  Created by Eric on 2015-09-22.
//  Copyright (c) 2015 Eric. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest* req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endDestinationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endDestinationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endDestinationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UITextField *endDestinationD;
@property (weak, nonatomic) IBOutlet UILabel *distanceD;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitController;

@end

@implementation ViewController

- (IBAction)calculateDistance:(id)sender {
    self.calculateButton.enabled = NO;
    
    self.req = [[DGDistanceRequest alloc]
                initWithLocationDescriptions:
                @[self.endDestinationA.text,
                  self.endDestinationB.text,
                  self.endDestinationC.text,
                  self.endDestinationD.text]
                sourceDescription:
                   self.startLocation.text];
    
    
    
    // this block rereives a distance (metre as default unit)
    // as a parameter,
    // then return a NSString message which includes appropriate
    // distance and unit.

    NSInteger index = [self.unitController selectedSegmentIndex];

    NSString* (^message)(double) = ^(double d){
        NSString* distance;
        switch (index) {
            case 0:
                distance = [NSString stringWithFormat:@"%.2lf m",d];
                break;
            case 1:
                distance = [NSString stringWithFormat:@"%.2lf km", d/1000.0];
                break;
            case 2:
                distance = [NSString stringWithFormat:@"%.2lf mile",d/1609.0];
                break;
        }
        return distance;
    };
    
    
    __weak ViewController *weakself = self;
    self.req.callback = ^void(NSArray *responses){
        
        ViewController *strongself = weakself;
        if(!strongself) return;
        
        NSNull *badresult = [NSNull null];
        
        if(responses[0] != badresult){
            NSString *distance = [NSString stringWithString:message([responses[0] doubleValue])];
            strongself.distanceA.text = distance;
        }
        else{
            strongself.distanceA.text = @"Enter a destination";
        }
        
        if(responses[1] != badresult){
            NSString *distance = [NSString stringWithString:message([responses[1] doubleValue])];
            strongself.distanceB.text = distance;
        }
        else{
            strongself.distanceB.text = @"Enter a destination";
        }
        
        if(responses[2] != badresult){
            NSString *distance = [NSString stringWithString:message([responses[2] doubleValue])];
            strongself.distanceC.text = distance;
        }
        else{
            strongself.distanceC.text = @"Enter a destination";
        }
        
        if(responses[3] != badresult){
            NSString *distance = [NSString stringWithString:message([responses[3] doubleValue])];
            strongself.distanceD.text = distance;
        }
        else{
            strongself.distanceD.text = @"Enter a destination";
        }
        
        strongself.req = nil;
        strongself.calculateButton.enabled = YES;
    };
    
    [self.req start];

}

@end








