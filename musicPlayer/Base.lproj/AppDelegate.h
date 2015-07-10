//
//  AppDelegate.h
//  musicPlayer
//
//  Created by ccyy on 15/7/6.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义一个block，返回值为void，block变量为RemoteBlock，参数类型为UIEvent ＊；
typedef  void (^RemoteBlock) ( UIEvent *);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 * 一个回调远程事件的block
 */
@property (copy,nonatomic) RemoteBlock remoteBlock;


@end

