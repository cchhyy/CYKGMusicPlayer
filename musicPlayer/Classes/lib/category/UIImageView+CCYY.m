//
//  UIImageView+CCYY.m
//  musicPlayer
//
//  Created by ccyy on 15/7/8.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "UIImageView+CCYY.h"

@implementation UIImageView (CCYY)
-(void)circleWithBorderWidth:(CGFloat)borderWidth
{
    //使用UIView的属性layer做视图的改变
    //设置一个边框
    [self.layer  setBorderWidth:borderWidth];
    //设置边框颜色
    [self.layer setBorderColor:[UIColor clearColor].CGColor];
    //设置弧度半径
    [self.layer setCornerRadius:self.bounds.size.height/2];
    //切掉边框以外的视图
    [self.layer setMasksToBounds:YES];
}

//专辑封面转动,4秒一圈
-(void)continuousRotation
{
    self.transform = CGAffineTransformRotate(self.transform, M_PI/180);
}
@end
