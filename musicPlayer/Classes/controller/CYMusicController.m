//
//  CYMusicController.m
//  musicPlayer
//
//  Created by ccyy on 15/7/7.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "CYMusicController.h"
#import "PlayerToolBarView.h"
#import "CYMusic.h"
#import "MJExtension.h"
#import "CYMusicCell.h"
#import "CYMusicTool.h"
#import "AppDelegate.h"

@interface CYMusicController ()<UITableViewDataSource,UITableViewDelegate,ToolBarDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *musics;//音乐对象数组
@property (weak,nonatomic) PlayerToolBarView *toolBar;//正在播放的音乐
@property (assign,nonatomic) NSInteger indexMusic;// toolBar上播放的音乐是第几首

@end

@implementation CYMusicController

-(NSArray *)musics
{
    if (!_musics) {
        _musics = [CYMusic objectArrayWithFilename:@"songs.plist"];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];

   //1.添加播放工具条
    PlayerToolBarView *playToolBar = [PlayerToolBarView playerToolBar];
    [self.bottomView addSubview:playToolBar];
    //设置toolBar的尺寸
    playToolBar.bounds = self.bottomView.bounds;

    //设置代理
    playToolBar.delegate = self;
    //赋给属性
    self.toolBar = playToolBar;

    //2.设置背景颜色为透明
    self.tableView.backgroundColor = [UIColor clearColor];
    
////    //3.准备播放音乐
//    [[CYMusicTool sharedCYMusicTool] prepareToPlayMusic:self.musics[self.indexMusic]];
//    
//    //toolBar的模型初始化
//    playToolBar.playingMusic = self.musics[self.indexMusic];
    [self playMusic];
    
    //Block
    [self remote];
}

#pragma -mark 设置接收远程操作
-(void)remote{
    AppDelegate *appDelegate =( AppDelegate *) [UIApplication sharedApplication].delegate;
    appDelegate.remoteBlock = ^(UIEvent *event ){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlNextTrack:
                [self next];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self previous];
                break;
            case UIEventSubtypeRemoteControlPause:
               [ [CYMusicTool  sharedCYMusicTool]pause];
                break;
            case UIEventSubtypeRemoteControlPlay:
                [ [CYMusicTool  sharedCYMusicTool]play];
                break;
                default:
                break;
        }
    };
}
#pragma -mark  tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYMusicCell *cell = [CYMusicCell cellWithTableView:tableView];
    CYMusic *music =  self.musics[indexPath.row];
    cell.music = music;
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexMusic = indexPath.row;
    [self playMusic];
}



#pragma -mark toolBar的代理方法
-(void)playToolBar:(PlayerToolBarView *)playToolBar buttonClickWithType:(BtnClickType)btnClickType
{
    switch (btnClickType) {
        case btnClickTypePlay:
           [ [CYMusicTool sharedCYMusicTool]play];
            break;
        case btnClickTypePause:
           [ [CYMusicTool sharedCYMusicTool]pause];
            break;
        case btnClickTypePrevious:
            NSLog(@"上一首");
            [self previous];
            break;
        case btnClickTypeNext:
            NSLog(@"下一首");
            [self next];
            break;
            
        default:
            break;
    }
}

#pragma -mark 下一首
-(void)next
{
    //    判断是否最后一首
    if (self.indexMusic == self.musics.count-1) {
        self.indexMusic = 0;
    }else{
        self.indexMusic++;
    }

    
        [self playMusic];
    
}

#pragma -mark 上一首
-(void)previous
{
    if (self.indexMusic == 0) {
        self.indexMusic = self.musics.count-1;
    }else{
        self.indexMusic--;
    }

    [self playMusic];
}
//播放音乐
-(void)playMusic
{
    //1.重新初始化一个“播放器”，这个要放在更改“工具条”之前进行，因为设置工具条的方法内部有用到播放器的总时间，如果不先初始化播放器，工具条上的音乐总时间就不会正常显示，而是会滞后一首
    [[CYMusicTool sharedCYMusicTool] prepareToPlayMusic:self.musics[self.indexMusic]];
    [CYMusicTool sharedCYMusicTool].player.delegate = self;
    
    //2.toolBar上正在播放的音乐需要变成下一首
    self.toolBar.playingMusic = self.musics[self.indexMusic];
    
    //3.如果状态是播放，才播放
    if (self.toolBar.playing) {
        [[CYMusicTool sharedCYMusicTool] play];
    }
    
}

#pragma -mark 自动播放下一首
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self next];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
