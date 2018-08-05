//
//  AVCollectionsCollectionViewController.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVCollectionsCollectionViewController.h"
#import "AVVideosCollectionViewController.h"
#import "AVSearchCollectionViewController.h"

#import "AVCollectionsModels.h"

#import "AVCollectionsCollectionViewCell.h"


@interface AVCollectionsCollectionViewController ()
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) NSString *hasMore;
@property (nonatomic ,assign) NSInteger currentPage;

@end

@implementation AVCollectionsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"Collections";
    
    [self addRightBarButtonWithFirstImage:kImageNamed(@"image_search") action:@selector(gotoSearch:)];

    // Register cell classes
    [self.collectionView registerClass:[AVCollectionsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjRefreshFoot)];

    self.currentPage = 0;
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    [self getDataWithPage:self.currentPage];
    [CGLoadingHub showLoadingHub];
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

- (void)mjRefreshFoot
{
    if ([self.hasMore isEqualToString:@"0"])
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    else
    {
        self.currentPage++;
        [self getDataWithPage:self.currentPage];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AVCollectionsModels *model = self.dataArr[indexPath.row];
    
    AVCollectionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.cellReviewCount setTitle:model.total_views forState:UIControlStateNormal];
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:model.cover_url] placeholderImage:kImageNamed(@"") options:SDWebImageRetryFailed];
    cell.cellName.text = model.title;
    [cell.cellVideoNum setTitle:model.video_count forState:UIControlStateNormal];

    // Configure the cell
    
    return cell;
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [CGLoadingHub showLoadingHub];
    [self getDataWithPage:self.currentPage];
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mainCellW = (kSCREEN_WIDTH-40)/2;
    
    AVCollectionsModels *model = self.dataArr[indexPath.row];

    AVVideosCollectionViewController *viewVideos = [[AVVideosCollectionViewController alloc] initWithCollectionViewLayout:[CGLayout createLayoutItemW:mainCellW itemH:mainCellW paddingY:10 paddingX:10 scrollDirection:UICollectionViewScrollDirectionVertical] withViewShowType:AVViewTypeCollections withKeyWord:model.keyword];
    viewVideos.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewVideos animated:YES];

}

#pragma mark ---------------> API
-(void)getDataWithPage:(NSInteger)pageString
{
    kWeakSelf(self);
    RespDictionaryBlock dBlock = ^(NSMutableDictionary *infoDict, NSError *error) {
        if (!error) {
            if (infoDict && [infoDict isKindOfClass:[NSMutableDictionary class]]) {
                PNSLog(@"%@",infoDict);
                if (infoDict[@"success"])
                {
                    self.hasMore = infoDict[@"has_more"];

                    NSArray *jobList = infoDict[@"response"][@"collections"];
                    if (jobList && [jobList isKindOfClass:[NSArray class]]) {
                        [weakself.dataArr addObjectsFromArray:[AVCollectionsModels mj_objectArrayWithKeyValuesArray:jobList]];
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
        [self.collectionView.mj_footer endRefreshing];
        [WMHub hide];
    };
    
    NSString *apiString = [NSString stringWithFormat:@"%@/%ld?limit=24",Collections_API,(long)pageString];
    
    [HTTPClient GETApi:apiString
            parameters:nil
             parserKey:pkIGTestParserApp
               success:[IGRespBlockGenerator taskSuccessBlockWithDictionaryBlock:dBlock]
               failure:[IGRespBlockGenerator taskFailureBlockWithDictionaryBlock:dBlock]];
}

@end
