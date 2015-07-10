//
//  CYMusicCell.h
//  musicPlayer
//
//  Created by ccyy on 15/7/7.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYMusic;

@interface CYMusicCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic,strong)CYMusic *music;

@end
