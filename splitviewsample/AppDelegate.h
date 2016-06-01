//
//  AppDelegate.h
//  splitViewSample
//
//  Created by Victor on 16/5/12.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext; // 托管对象上下文
@property ( strong, nonatomic) NSManagedObjectModel *managedObjectModel;     // 托管对象模型
@property ( strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; // 持久性存储区

- (void)saveContext; // 保存上下文
- (NSURL *)applicationDocumentsDirectory; // 获取程序数据存放文档的路径

@end

