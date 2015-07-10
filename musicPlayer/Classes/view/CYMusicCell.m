//
//  CYMusicCell.m
//  musicPlayer
//
//  Created by ccyy on 15/7/7.
//  Copyright (c) 2015年 111. All rights reserved.
//

#import "CYMusicCell.h"
#import "CYMusic.h"

@implementation CYMusicCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIndentifier = @"musicCell";
    CYMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    return cell;
}

-(void)setMusic:(CYMusic *)music
{
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
}













- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
