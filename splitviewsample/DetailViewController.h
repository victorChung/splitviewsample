//
//  DetailViewController.h
//  splitViewSample
//
//  Created by Victor on 16/5/12.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

