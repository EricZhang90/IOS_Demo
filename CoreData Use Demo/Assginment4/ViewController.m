//
//  ViewController.m
//  Assginment4
//
//  Created by Eric on 2015-11-25.
//  Copyright © 2015 Eric. All rights reserved.
//

#import "ViewController.h"
#import "List.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;

@property (weak, nonatomic) IBOutlet UITextField *locationField;

@property (weak, nonatomic) IBOutlet UITextField *descField;

@property (weak, nonatomic) IBOutlet UILabel *totalField;

@property (weak, nonatomic) IBOutlet UILabel *eventField;

@property AppDelegate *appdelegate;

-(void)updateEvent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appdelegate = [[UIApplication sharedApplication] delegate];
    [self updateEvent];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) updateEvent{
    NSError *err;
    NSArray *result = [self.appdelegate.managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"List"] error:&err];
    if (!result) {
        NSLog(@"Fail to fetch List Object%@\n%@", [err localizedDescription], [err userInfo]);
        abort();
    }
    else{
        int i = 0;
        NSMutableString *buffer = [NSMutableString stringWithString:@""];
        for (List* list in result) {
            i++;
            [buffer appendFormat:@"%@: %@ in %@\n", list.title, list.desc, list.location];
        }
        self.eventField.text = buffer;
        self.totalField.text = [NSString stringWithFormat:@"%d",i];
    }
}

- (IBAction)addTrapped:(id)sender {
    List *list = [self.appdelegate createListMO];
    list.title = self.titleField.text;
    list.location = self.locationField.text;
    list.desc = self.descField.text;
    [self.appdelegate saveContext];
    [self updateEvent];
    self.titleField.text = nil;
    self.locationField.text = nil;
    self.descField.text = nil;
}

- (IBAction)deletedTrapped:(id)sender {
    NSError *err;
    NSArray *result = [self.appdelegate.managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"List"] error:&err];
    if (!result) {
        NSLog(@"Fail to fetch List Object%@\n%@", [err localizedDescription], [err userInfo]);
        abort();
    }
    else{
        for (List* list in result) {
            [self.appdelegate.managedObjectContext deleteObject:list];
        }
        [self.appdelegate saveContext];
        [self updateEvent];
    }
    
}

@end








