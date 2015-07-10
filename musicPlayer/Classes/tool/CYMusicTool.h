//
//  CYMusicTool.h
//  musicPlayer
//
//  Created by ccyy on 15/7/8.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "Singleton.h"
@class CYMusic;


@interface CYMusicTool : NSObject
singleton_interface(CYMusicTool)


@property (nonatomic,strong) AVAudioPlayer *player;

//准备播放
-(void)prepareToPlayMusic:(CYMusic *)music;
//播放
-(void)play;
//暂停
-(void)pause;
@end
