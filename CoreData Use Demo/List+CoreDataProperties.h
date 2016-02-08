//
//  List+CoreDataProperties.h
//  Assginment4
//
//  Created by Eric on 2015-11-25.
//  Copyright © 2015 Eric. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface List (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSNumber *cout;

@end

NS_ASSUME_NONNULL_END
