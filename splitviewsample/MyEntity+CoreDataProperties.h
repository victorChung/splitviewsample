//
//  MyEntity+CoreDataProperties.h
//  splitViewSample
//
//  Created by Victor on 16/5/31.
//  Copyright © 2016年 NilCode. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MyEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
