//
//  AVVideoInfoViewController.m
//  AV
//
//  Created by H-L on 2018/8/5.
//  Copyright © 2018年 邓杰豪. All rights reserved.
//

#import "AVVideoInfoViewController.h"
#import "AVWebViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

#import <PooTools/PooTagsLabel.h>

@interface AVVideoInfoViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) MPMoviePlayerController *player;
@property (nonatomic, strong) AVVideosModels *viewModel;
@property (nonatomic, strong) NSMutableArray *tagArrs;

@end

@implementation AVVideoInfoViewController

-(instancetype)initWithViewModel:(AVVideosModels *)models
{
    self = [super init];
    if (self) {
        self.viewModel = models;
        self.tagArrs = [NSMutableArray array];
    }
    return self;
}

-(PooTagsLabelConfig *)tagConfig
{
    PooTagsLabelConfig *config = [[PooTagsLabelConfig alloc] init];
    config.itemHeight = 20;
    config.itemHerMargin = 5;
    config.itemVerMargin = 5;
    config.hasBorder = YES;
    config.topBottomSpace = 5.0;
    config.itemContentEdgs = 5;
    config.isCanSelected = NO;
    config.isCanCancelSelected = NO;
    config.isMulti = YES;
    config.selectedDefaultTags = self.tagArrs;
    config.selectedTitleColor = AppBlack;
    config.borderColor = AppBlack;
    config.borderWidth = 1;
    return config;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = AppWhite;
    
    UILabel *titleViews = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleViews.numberOfLines = 0;
    titleViews.lineBreakMode = NSLineBreakByCharWrapping;
    titleViews.textAlignment = NSTextAlignmentCenter;
    titleViews.font = AppFontNormal;
    titleViews.textColor = AppBlack;
    titleViews.text = self.viewModel.title;
    self.navigationItem.titleView = titleViews;
    
    NSArray *arr = [self.viewModel.keyword componentsSeparatedByString:@" "];
    [self.tagArrs addObjectsFromArray:arr];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.viewModel.preview_video_url]];
    self.player.controlStyle = MPMovieControlStyleNone;
    self.player.shouldAutoplay = YES;
    self.player.repeatMode = MPMovieRepeatModeOne;
    [self.player setFullscreen:YES animated:YES];
    self.player.scalingMode = MPMovieScalingModeAspectFit;
    [self.player prepareToPlay];
    [self.view addSubview:self.player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.offset(HEIGHT_NAVBAR);
        make.height.offset(150);
    }];
    [self.player play];
    
    CGFloat labelH = 25;
    
    UIView *infoView = [UIView new];
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.player.view.mas_bottom);
        make.height.offset(60);
    }];
    
    UIButton *cellPlayTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellPlayTime setTitleColor:AppBlack forState:UIControlStateNormal];
    cellPlayTime.titleLabel.font = AppFontNormal;
    [cellPlayTime setImage:kImageNamed(@"image_playtime") forState:UIControlStateNormal];
    [cellPlayTime setTitle:[AVGobalTools getHHMMSSFromSS:self.viewModel.duration] forState:UIControlStateNormal];
    [cellPlayTime layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [self.view addSubview:cellPlayTime];
    [cellPlayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.left.equalTo(infoView);
        make.top.equalTo(infoView).offset(2.5);
    }];

    UIButton *cellLike = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellLike setTitleColor:AppBlack forState:UIControlStateNormal];
    cellLike.titleLabel.font = AppFontNormal;
    [cellLike setImage:kImageNamed(@"image_like") forState:UIControlStateNormal];
    [cellLike setTitle:self.viewModel.likes forState:UIControlStateNormal];
    [cellLike layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [infoView addSubview:cellLike];
    [cellLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.equalTo(infoView);
        make.top.equalTo(cellPlayTime);
    }];
    
    UIButton *cellDisLike = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellDisLike setTitleColor:AppBlack forState:UIControlStateNormal];
    cellDisLike.titleLabel.font = AppFontNormal;
    [cellDisLike setImage:kImageNamed(@"image_dislike") forState:UIControlStateNormal];
    [cellDisLike setTitle:self.viewModel.dislikes forState:UIControlStateNormal];
    [cellDisLike layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [infoView addSubview:cellDisLike];
    [cellDisLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.equalTo(cellLike.mas_left);
        make.top.equalTo(cellPlayTime);
    }];
    
    UIImageView *cellHD = [UIImageView new];
    cellHD.image = kImageNamed(@"image_HD");
    [infoView addSubview:cellHD];
    [cellHD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.right.equalTo(infoView.mas_centerX).offset(-ViewSpace);
        make.top.equalTo(cellPlayTime);
    }];
    cellHD.hidden = [AVGobalTools isHD:self.viewModel.hd];
    
    
    UIButton *cellFPS = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellFPS setTitleColor:AppBlack forState:UIControlStateNormal];
    cellFPS.titleLabel.font = AppFontNormal;
    [cellFPS setImage:kImageNamed(@"image_framerate") forState:UIControlStateNormal];
    [cellFPS setTitle:self.viewModel.framerate forState:UIControlStateNormal];
    [cellFPS layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [infoView addSubview:cellFPS];
    [cellFPS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.left.equalTo(infoView.mas_centerX).offset(ViewSpace);
        make.top.equalTo(cellPlayTime);
    }];
    
    UIButton *cellAddTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellAddTime setTitleColor:AppBlack forState:UIControlStateNormal];
    cellAddTime.titleLabel.font = AppFontNormal;
    [cellAddTime setImage:kImageNamed(@"image_upload_time") forState:UIControlStateNormal];
    [cellAddTime setTitle:[AVGobalTools unixTimeToLifeTime:self.viewModel.addtime] forState:UIControlStateNormal];
    [cellAddTime layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:0];
    [infoView addSubview:cellAddTime];
    [cellAddTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(labelH);
        make.left.right.equalTo(infoView);
        make.top.equalTo(infoView.mas_centerY).offset(2.5);
    }];
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.backgroundColor = AppBlack;
    [playBtn setTitleColor:AppWhite forState:UIControlStateNormal];
    [playBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(ButtonH);
        make.bottom.equalTo(self.view);
    }];
    
    PooTagsLabel *tagV = [[PooTagsLabel alloc] initWithTagsArray:self.tagArrs config:[self tagConfig] wihtSection:0];
    [self.view addSubview:tagV];
    [tagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(infoView.mas_bottom);
        make.bottom.equalTo(playBtn.mas_top);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playVideoAction:(UIButton *)sender
{
    AVWebViewController *view = [[AVWebViewController alloc] initWithURLString:self.viewModel.embedded_url];
    view.hidesBottomBarWhenPushed = YES;
    view.webView.scrollView.bounces = NO;
    [view.webView setMediaPlaybackRequiresUserAction:NO];
    [self.navigationController pushViewController:view animated:YES];
}
@end
