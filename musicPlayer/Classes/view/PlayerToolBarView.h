//
//  PlayerToolBarView.h
//  musicPlayer
//
//  Created by ccyy on 15/7/6.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    btnClickTypePlay,
    btnClickTypePause,
    btnClickTypePrevious,
    btnClickTypeNext
}BtnClickType;

@class  CYMusic,PlayerToolBarView;

//协议
@protocol ToolBarDelegate <NSObject>

-(void)playToolBar:(PlayerToolBarView *)playToolBar  buttonClickWithType:( BtnClickType )btnClickType;

@end

@interface PlayerToolBarView : UIView
@property (nonatomic,strong) CYMusic *playingMusic;
@property (nonatomic,weak)  id<ToolBarDelegate > delegate;

//播放状态,默认为NO
@property (nonatomic,assign) BOOL playing;

//创建实例对象
+(instancetype)playerToolBar;

@end
