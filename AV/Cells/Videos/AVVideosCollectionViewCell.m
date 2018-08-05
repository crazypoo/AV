//
//  AVVideosCollectionViewCell.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVVideosCollectionViewCell.h"

@implementation AVVideosCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
        self.backgroundColor = AppWhite;
    }
    return self;
}

-(void)confingSubViews
{
    CGFloat imageH = self.height/3*2;
    CGFloat bottomH = self.height - imageH;
    CGFloat labelH = bottomH/3;

    self.cellImage = [UIImageView new];
    [self.contentView addSubview:self.cellImage];
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.offset(imageH);
    }];
    
    self.cellHD = [UIImageView new];
    self.cellHD.image = kImageNamed(@"image_HD");
    [self.cellImage addSubview:self.cellHD];
    [self.cellHD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AppFontNormal_SIZE*2);
        make.right.equalTo(self.cellImage).offset(-ViewSpace);
        make.top.equalTo(self.cellImage).offset(ViewSpace);
    }];
    
    self.cellVideoPlayTimes = [UILabel new];
    self.cellVideoPlayTimes.backgroundColor = kRGBAColor(1, 1, 1, 0.6);
    self.cellVideoPlayTimes.font = AppFontNormal;
    self.cellVideoPlayTimes.textColor = AppWhite;
    self.cellVideoPlayTimes.textAlignment = NSTextAlignmentLeft;
    kViewBorderRadius(self.cellVideoPlayTimes, 5, 1, kClearColor);
    [self.cellImage addSubview:self.cellVideoPlayTimes];
    [self.cellVideoPlayTimes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.bottom.equalTo(self.cellImage).offset(-ViewSpace);
    }];

    UIView *bottomView = [UIView new];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.cellImage.mas_bottom);
    }];

    self.cellName = [UILabel new];
    self.cellName.font = AppFontNormal;
    self.cellName.textColor = AppBlack;
    self.cellName.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:self.cellName];
    [self.cellName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.left.top.right.equalTo(bottomView);
    }];
    
    self.cellAddTime = [UILabel new];
    self.cellAddTime.font = AppFontNormal;
    self.cellAddTime.textColor = AppBlack;
    self.cellAddTime.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:self.cellAddTime];
    [self.cellAddTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.equalTo(bottomView);
        make.left.equalTo(bottomView).offset(AppFontNormal_SIZE+BackBtnSpace);
        make.top.equalTo(self.cellName.mas_bottom);
    }];
    
    UIImageView *addTimeImage = [UIImageView new];
    addTimeImage.image = kImageNamed(@"image_upload_time");
    [bottomView addSubview:addTimeImage];
    [addTimeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AppFontNormal_SIZE);
        make.left.equalTo(bottomView);
        make.centerY.equalTo(self.cellAddTime);
    }];
    
    self.cellVideoPlayedNum = [UILabel new];
    self.cellVideoPlayedNum.font = AppFontNormal;
    self.cellVideoPlayedNum.textColor = AppBlack;
    self.cellVideoPlayedNum.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:self.cellVideoPlayedNum];
    [self.cellVideoPlayedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.left.equalTo(bottomView).offset(AppFontNormal_SIZE+BackBtnSpace);
        make.top.equalTo(self.cellAddTime.mas_bottom);
    }];
    
    UIImageView *playedImage = [UIImageView new];
    playedImage.image = kImageNamed(@"image_reviews");
    [bottomView addSubview:playedImage];
    [playedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AppFontNormal_SIZE);
        make.left.equalTo(bottomView);
        make.centerY.equalTo(self.cellVideoPlayedNum);
    }];
    
    self.cellLikes = [UILabel new];
    self.cellLikes.font = AppFontNormal;
    self.cellLikes.textColor = AppBlack;
    self.cellLikes.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:self.cellLikes];
    [self.cellLikes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.equalTo(bottomView);
        make.top.equalTo(self.cellAddTime.mas_bottom);
    }];
    
    UIImageView *likeImage = [UIImageView new];
    likeImage.image = kImageNamed(@"image_like_precent");
    [bottomView addSubview:likeImage];
    [likeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AppFontNormal_SIZE);
        make.right.equalTo(self.cellLikes.mas_left).offset(-BackBtnSpace);
        make.centerY.equalTo(self.cellLikes);
    }];

}

@end
