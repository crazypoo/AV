//
//  AVSearchCollectionViewController.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVSearchCollectionViewController.h"
#import "AVVideoInfoViewController.h"

#import <PooTools/PooSearchBar.h>

#import "AVVideosModels.h"

#import "AVVideosCollectionViewCell.h"

@interface AVSearchCollectionViewController ()<UISearchBarDelegate>
{
}
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) PooSearchBar *searchBar;

@end

@implementation AVSearchCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.dataArr = [NSMutableArray array];
    // Register cell classes
    [self.collectionView registerClass:[AVVideosCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.searchBar = [[PooSearchBar alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH-200, 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.searchPlaceholder = @"点击此处查找地市名字";
    self.searchBar.searchPlaceholderColor = AppBlack;
    self.searchBar.searchPlaceholderFont = AppFontNormal;
    self.searchBar.searchTextColor = AppBlack;
    self.searchBar.searchTextFieldBackgroundColor = AppWhite;
    self.searchBar.searchBarOutViewColor = kClearColor;
    self.searchBar.searchBarTextFieldCornerRadius = 15;
    self.searchBar.searchBarImage = kImageNamed(@"image_search");
    self.navigationItem.titleView = self.searchBar;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.dataArr removeAllObjects];
    [CGLoadingHub showLoadingHub];
    [self getDataWithKeyWord:searchBar.text];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AVVideosModels *model = self.dataArr[indexPath.row];
    
    AVVideosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:model.preview_url] placeholderImage:kImageNamed(@"") options:SDWebImageRetryFailed];
    cell.cellHD.hidden = [AVGobalTools isHD:model.hd];
    cell.cellAddTime.text = [AVGobalTools unixTimeToLifeTime:model.addtime];
    cell.cellName.text = model.title;
    cell.cellVideoPlayedNum.text = model.viewnumber;
    cell.cellLikes.text = [AVGobalTools likes:model.likes unLike:model.dislikes];
    cell.cellVideoPlayTimes.text = [AVGobalTools getHHMMSSFromSS:model.duration];

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

#pragma mark ---------------> API
-(void)getDataWithKeyWord:(NSString *)kw
{
    kWeakSelf(self);
    RespDictionaryBlock dBlock = ^(NSMutableDictionary *infoDict, NSError *error) {
        if (!error) {
            if (infoDict && [infoDict isKindOfClass:[NSMutableDictionary class]]) {
                PNSLog(@"%@",infoDict);
                if (infoDict[@"success"])
                {
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
        [WMHub hide];
        [weakself.searchBar resignFirstResponder];
    };
    
    NSString *apiString = [NSString stringWithFormat:@"%@/%@/0?limit=24",Jav_API,[kw stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    [HTTPClient GETApi:apiString
            parameters:nil
             parserKey:pkIGTestParserApp
               success:[IGRespBlockGenerator taskSuccessBlockWithDictionaryBlock:dBlock]
               failure:[IGRespBlockGenerator taskFailureBlockWithDictionaryBlock:dBlock]];
}


@end
