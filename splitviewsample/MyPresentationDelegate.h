//
//  MyPresentationDelegate.h
//  splitViewSample
//
//  Created by Victor on 16/5/14.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyPresentationDelegate <NSObject>

@required
-(void)passValue:(id)value;

@end
