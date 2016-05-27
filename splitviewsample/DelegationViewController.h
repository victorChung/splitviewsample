//
//  DelegationViewController.h
//  splitViewSample
//
//  Created by Victor on 16/5/14.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "MyViewController.h"
#import "MyPresentationDelegate.h"


@interface DelegationViewController : MyViewController
// 委托代理人，代理一般需使用弱引用(weak)
//@property (weak, nonatomic) id delegate;
//或者如下面
@property(nonatomic,assign) NSObject<MyPresentationDelegate> *delegate;
@end
