//
//  AVVideosCollectionViewController.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVVideosCollectionViewController.h"
#import "AVVideoInfoViewController.h"
#import "AVSearchCollectionViewController.h"

#import "AVVideosModels.h"

#import "AVVideosCollectionViewCell.h"

@interface AVVideosCollectionViewController ()
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) NSString *hasMore;
@property (nonatomic ,assign) NSInteger currentPage;
@property (nonatomic ,assign) AVViewType showViewType;
@property (nonatomic ,strong) NSString *keyWord;

@end

@implementation AVVideosCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout withViewShowType:(AVViewType)type withKeyWord:(NSString *)kw
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.showViewType = type;
        self.keyWord = kw;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self addRightBarButtonWithFirstImage:kImageNamed(@"image_search") action:@selector(gotoSearch:)];

    // Register cell classes
    [self.collectionView registerClass:[AVVideosCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjRefreshFoot)];
    
    self.currentPage = 0;
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    
    switch (self.showViewType) {
        case AVViewTypeNormal:
        {
            self.title = @"Videos";
            [self getDataWithPage:self.currentPage];
            [CGLoadingHub showLoadingHub];
        }
            break;
        default:
        {
            self.title = self.keyWord;
            [self getDataWithPage:self.currentPage withKeyWord:self.keyWord];
            [CGLoadingHub showLoadingHub];
        }
            break;
    }
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
        switch (self.showViewType) {
            case AVViewTypeNormal:
            {
                [self getDataWithPage:self.currentPage];
            }
                break;
            default:
            {
                [self getDataWithPage:self.currentPage withKeyWord:self.keyWord];
            }
                break;
        }
        
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
   
    AVVideosModels *model = self.dataArr[indexPath.row];
    
    AVVideosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:model.preview_url] placeholderImage:kImageNamed(@"") options:SDWebImageRetryFailed];
    cell.cellHD.hidden = [AVGobalTools isHD:model.hd];
    cell.cellAddTime.text = [AVGobalTools unixTimeToLifeTime:model.addtime];
    cell.cellName.text = model.title;
    cell.cellVideoPlayedNum.text = model.viewnumber;
    cell.cellLikes.text = [AVGobalTools likes:model.likes unLike:model.dislikes];
    cell.cellVideoPlayTimes.text = [AVGobalTools getHHMMSSFromSS:model.duration];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AVVideosModels *model = self.dataArr[indexPath.row];

    AVVideoInfoViewController *view = [[AVVideoInfoViewController alloc] initWithViewModel:model];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [CGLoadingHub showLoadingHub];
    switch (self.showViewType) {
        case AVViewTypeNormal:
        {
            [self getDataWithPage:self.currentPage];
        }
            break;
        default:
        {
            [self getDataWithPage:self.currentPage withKeyWord:self.keyWord];
        }
            break;
    }
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

                    NSArray *jobList = infoDict[@"response"][@"videos"];
                    if (jobList && [jobList isKindOfClass:[NSArray class]]) {
                        [weakself.dataArr addObjectsFromArray:[AVVideosModels mj_objectArrayWithKeyValuesArray:jobList]];
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
    
    NSString *apiString = [NSString stringWithFormat:@"%@/%ld?limit=24",Videos_API,(long)pageString];
    
    [HTTPClient GETApi:apiString
            parameters:nil
             parserKey:pkIGTestParserApp
               success:[IGRespBlockGenerator taskSuccessBlockWithDictionaryBlock:dBlock]
               failure:[IGRespBlockGenerator taskFailureBlockWithDictionaryBlock:dBlock]];
}

-(void)getDataWithPage:(NSInteger)pageString withKeyWord:(NSString *)kw
{
    kWeakSelf(self);
    RespDictionaryBlock dBlock = ^(NSMutableDictionary *infoDict, NSError *error) {
        if (!error) {
            if (infoDict && [infoDict isKindOfClass:[NSMutableDictionary class]]) {
                PNSLog(@"%@",infoDict);
                if (infoDict[@"success"])
                {
                    self.hasMore = infoDict[@"has_more"];
                    
                    NSArray *jobList = infoDict[@"response"][@"videos"];
                    if (jobList && [jobList isKindOfClass:[NSArray class]]) {
                        [weakself.dataArr addObjectsFromArray:[AVVideosModels mj_objectArrayWithKeyValuesArray:jobList]];
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
    
    NSString *apiString = [NSString stringWithFormat:@"%@/%@/%ld?limit=24",Search_API,[kw stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],(long)pageString];
    
    [HTTPClient GETApi:apiString
            parameters:nil
             parserKey:pkIGTestParserApp
               success:[IGRespBlockGenerator taskSuccessBlockWithDictionaryBlock:dBlock]
               failure:[IGRespBlockGenerator taskFailureBlockWithDictionaryBlock:dBlock]];
}

@end
