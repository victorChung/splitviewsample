//
//  MasterViewController.h
//  splitViewSample
//
//  Created by Victor on 16/5/12.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecognizerViewController.h"
#import "UISViewController.h"
#import "PresentationViewController.h"
#import "DataIOViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong,nonatomic) NSMutableDictionary *dictItem;
@property (strong,nonatomic) NSArray *arrItem;
@property (strong, nonatomic) DetailViewController *detailViewController;


@end

