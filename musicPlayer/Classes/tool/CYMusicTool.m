//
//  CYMusicTool.m
//  musicPlayer
//
//  Created by ccyy on 15/7/8.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "CYMusicTool.h"
#import "CYMusic.h"
#import <MediaPlayer/MediaPlayer.h>
@interface CYMusicTool ()


@end

@implementation CYMusicTool
singleton_implementation(CYMusicTool)
//准备播放
-(void)prepareToPlayMusic:(CYMusic *)music
{
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:music.filename withExtension:nil];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    [self.player prepareToPlay];
    NSLog(@"已经准备好播放音乐，音乐名称是%@",music.filename);
    //设置锁屏时的信息展示
    [self setupLockInfoWithMP3Info:music];
    
}

//播放音乐
-(void)play
{
    [self.player play];
}

//暂停
-(void)pause{
    [self.player pause];
}

-(void)setupLockInfoWithMP3Info:(CYMusic *)music{
    //锁屏信息设置
    NSMutableDictionary *Info = [NSMutableDictionary dictionary];
    
    //1.专辑名称
    Info[MPMediaItemPropertyAlbumTitle] = @"中文十大金曲";
    
    //2.歌曲
    Info[MPMediaItemPropertyTitle] = music.name;
    
    //3.歌手名称
    Info[MPMediaItemPropertyTitle] = music.singer;
    
    //4.专辑图片
    if(music.icon){
        UIImage *artWorkImage = [UIImage imageNamed:music.icon];
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:artWorkImage];
        Info[MPMediaItemPropertyArtwork] = artwork;
    }
    
    //5.锁屏音乐总时间
    Info[MPMediaItemPropertyPlaybackDuration] = @(self.player.duration);
    
    //设置锁屏时的播放信息
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = Info;

}
@end
