//
//  UIImageView+CCYY.h
//  musicPlayer
//
//  Created by ccyy on 15/7/8.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CCYY)
//宽高相等时，才为圆形，默认边框颜色为透明
-(void)circleWithBorderWidth:(CGFloat )borderWidth;

//连续转动，4秒一圈（M_PI／180）
-(void)continuousRotation;


@end
