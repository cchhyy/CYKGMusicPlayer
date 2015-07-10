//
//  PlayerToolBarView.m
//  musicPlayer
//
//  Created by ccyy on 15/7/6.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "PlayerToolBarView.h"
#import "UIImageView+CCYY.h"
#import "CYMusic.h"
#import "UIButton+CCYY.h"
#import "CYMusicTool.h"
#import "NSString+CCYY.h"


@interface  PlayerToolBarView ()
@property (weak, nonatomic) IBOutlet UIImageView *songIcon;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;//当前时间
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;//进度条
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;//总时间

@property (strong,nonatomic) CADisplayLink *link;//定时器
@property (assign,nonatomic) BOOL dragging;//是否在拖拽，默认为NO

@end

@implementation PlayerToolBarView
#pragma -mark UISlider事件
//按下之后
- (IBAction)stopPlay:(id)sender {
    self.dragging = YES;
    [[CYMusicTool sharedCYMusicTool]pause];
}

//松手之后
- (IBAction)replay:(id)sender {
    self.dragging = NO;
    if (self.playing) {
        [[CYMusicTool sharedCYMusicTool] play];
    }
}

//value改变
- (IBAction)changeValue:( UISlider *)sender {
    //更新当前播放进度
   [CYMusicTool sharedCYMusicTool].player.currentTime = sender.value;
    //更新工具条当前时间
    if (!self.playing) {
        self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:sender.value];
    }
}

#pragma -mark 定时器懒加载
-(CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

-(void)awakeFromNib
{
    //  开启定时器
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
    //设置进度条圆点的图片
    [self.timeSlider setThumbImage:[UIImage imageNamed:@"playbar_slider_thumb"] forState:UIControlStateNormal];
}

-(void)dealloc
{
    //关闭定时器
    [self.link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}
#pragma -mark 更新 
-(void)update{
    if (self.playing && (self.dragging == NO)) {
        //专辑封面转动,4秒一圈
        self.songIcon.transform = CGAffineTransformRotate(self.songIcon.transform, M_PI/180);
        //更新音乐当前时间
        double currentTime = [CYMusicTool sharedCYMusicTool].player.currentTime;
        self.currentTimeLabel.text = [NSString getMinuteSecondWithSecond:currentTime];
       //更新进度条
        self.timeSlider.value = currentTime;
    }
}

#pragma -mark 播放，暂停，上一曲，下一曲
//上一曲
- (IBAction)previousSong:(id)sender {
    
    [self notifyDelegateWithButtonType:btnClickTypePrevious];
   
}
//播放、暂停
- (IBAction)playBtnClick:( UIButton *)button {
    self.playing = !self.playing;
    //播放
    if (self.playing) {
        NSLog(@"播放音乐");
        [button setNBg:@"playbar_pausebtn_nomal.png"  hBg:@"playbar_pausebtn_click.png"];
        [self  notifyDelegateWithButtonType:btnClickTypePlay];
          //暂停
    }else{
        NSLog(@"暂停音乐");
        [button setNBg:@"playbar_playbtn_nomal.png"  hBg:@"playbar_playbtn_click.png"];
        [self notifyDelegateWithButtonType:btnClickTypePause];
    }
}
//下一曲
- (IBAction)nextSong:(id)sender {
    [self notifyDelegateWithButtonType:btnClickTypeNext];
}


#pragma -mark 设置正在播放的音乐
-(void)setPlayingMusic:(CYMusic *)music
{
    _playingMusic = music;
    
    [self.songIcon circleWithBorderWidth:1];
    self.songIcon.image = [UIImage imageNamed:music.icon];
    self.songNameLabel.text = music.name;
    self.singerNameLabel.text  = music.singer;
    //设置转盘归位
    self.songIcon.transform =  CGAffineTransformIdentity;
    //设置总时间
    double duration = [CYMusicTool sharedCYMusicTool].player.duration;
    self.totalTimeLabel.text = [NSString  getMinuteSecondWithSecond:duration];
    //设置进度条最大值
    self.timeSlider.maximumValue = duration;
    
}


//通知代理
-(void)notifyDelegateWithButtonType:(BtnClickType )buttonClickType
{
    if ([self.delegate respondsToSelector:@selector(playToolBar:buttonClickWithType:)] && self.delegate != nil) {
        [self.delegate playToolBar:self buttonClickWithType:buttonClickType];
    }
}


+(instancetype)playerToolBar
{
    return [[[NSBundle mainBundle]loadNibNamed:@"PlayerToolBarView" owner:nil options:nil] lastObject];
}





@end
