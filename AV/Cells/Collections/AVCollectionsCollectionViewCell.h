//
//  AVCollectionsCollectionViewCell.h
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVCollectionsCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *cellImage;
@property (nonatomic, strong) UILabel *cellName;
@property (nonatomic, strong) UIButton *cellVideoNum;
@property (nonatomic, strong) UIButton *cellReviewCount;

@end
