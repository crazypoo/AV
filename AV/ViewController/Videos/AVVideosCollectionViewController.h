//
//  AVVideosCollectionViewController.h
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "BaseCollectionViewController.h"

typedef NS_ENUM(NSUInteger, AVViewType) {
    AVViewTypeNormal = 0,
    AVViewTypeCollections,
    AVViewTypeCategories
};

@interface AVVideosCollectionViewController : BaseCollectionViewController
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout withViewShowType:(AVViewType)type withKeyWord:(NSString *)kw;
@end
