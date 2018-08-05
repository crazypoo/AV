//
//  ViewController.m
//  AV
//
//  Created by 邓杰豪 on 2018/8/4.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "ViewController.h"
#import "AVVideosCollectionViewController.h"
#import "AVSearchCollectionViewController.h"

#import "AVMainCollectionViewCell.h"

#import "AVCategoriesModels.h"

static NSString * const ViewCell = @"ViewCell";

@interface ViewController ()
@property (nonatomic ,strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Categories";
    
    [self.collectionView registerClass:[AVMainCollectionViewCell class] forCellWithReuseIdentifier:ViewCell];
    
    [self addRightBarButtonWithFirstImage:kImageNamed(@"image_search") action:@selector(gotoSearch:)];

    self.dataArr = [NSMutableArray array];
    [CGLoadingHub showLoadingHub];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoSearch:(UIButton *)sender
{
    CGFloat mainCellW = (kSCREEN_WIDTH-40)/2;
    
    AVSearchCollectionViewController *viewVideos = [[AVSearchCollectionViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical]];
    viewVideos.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewVideos animated:YES];

}

#pragma mark ---------------> UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //#warning Incomplete method implementation -- Return the number of sections
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //#warning Incomplete method implementation -- Return the number of items in the section
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AVCategoriesModels *model = self.dataArr[indexPath.row];
    AVMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ViewCell forIndexPath:indexPath];

    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:kImageNamed(@"") options:SDWebImageRetryFailed];
    cell.cellName.text = model.shortname;
    [cell.cellVideoNum setTitle:model.total_videos forState:UIControlStateNormal];
    
    return cell;
}

#pragma mark ---------------> UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mainCellW = (kSCREEN_WIDTH-40)/2;

    AVCategoriesModels *model = self.dataArr[indexPath.row];

    AVVideosCollectionViewController *viewVideos = [[AVVideosCollectionViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical] withViewShowType:AVViewTypeCategories withKeyWord:model.slug];
    viewVideos.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewVideos animated:YES];
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [CGLoadingHub showLoadingHub];
    [self getData];
}

#pragma mark ---------------> API
-(void)getData
{
    kWeakSelf(self);
    RespDictionaryBlock dBlock = ^(NSMutableDictionary *infoDict, NSError *error) {
        if (!error) {
            if (infoDict && [infoDict isKindOfClass:[NSMutableDictionary class]]) {
                if (infoDict[@"success"])
                {
                    NSArray *jobList = infoDict[@"response"][@"categories"];
                    if (jobList && [jobList isKindOfClass:[NSArray class]]) {
                        [weakself.dataArr addObjectsFromArray:[AVCategoriesModels mj_objectArrayWithKeyValuesArray:jobList]];
                    }
                    [self.collectionView reloadData];
                }
                else
                {
                    
                }
            }
        }
        else
        {
        }
        [WMHub hide];
    };
    
    [HTTPClient GETApi:Categories
            parameters:nil
             parserKey:pkIGTestParserApp
               success:[IGRespBlockGenerator taskSuccessBlockWithDictionaryBlock:dBlock]
               failure:[IGRespBlockGenerator taskFailureBlockWithDictionaryBlock:dBlock]];
}
@end
