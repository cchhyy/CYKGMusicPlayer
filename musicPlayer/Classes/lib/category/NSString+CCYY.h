//
//  NSString+CCYY.h
//  musicPlayer
//
//  Created by ccyy on 15/7/10.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCYY)
/**
 *  返回分与秒的字符串 如:01:60
 */
+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time;

@end
