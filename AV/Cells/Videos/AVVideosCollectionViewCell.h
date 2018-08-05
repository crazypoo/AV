//
//  AVVideosCollectionViewCell.h
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVVideosCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *cellImage;
@property (nonatomic, strong) UILabel *cellName;
@property (nonatomic, strong) UILabel *cellVideoPlayedNum;
@property (nonatomic, strong) UIImageView *cellHD;
@property (nonatomic, strong) UILabel *cellAddTime;
@property (nonatomic, strong) UILabel *cellVideoPlayTimes;
@property (nonatomic, strong) UILabel *cellLikes;

@end
