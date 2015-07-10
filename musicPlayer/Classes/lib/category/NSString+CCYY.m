


//
//  NSString+CCYY.m
//  musicPlayer
//
//  Created by ccyy on 15/7/10.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "NSString+CCYY.h"

@implementation NSString (CCYY)

+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time{
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    
    if (second > 9) {
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    
    
    return [NSString stringWithFormat:@"%d:0%d",minute,second];
}
@end
