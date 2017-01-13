//
//  DemoViewController.m
//  demo
//
//  Created by 罗壮燊 on 2017/1/6.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "JianshuDemoViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"

#import "SBHeaderView.h"
#import "SBTitleView.h"

@interface JianshuDemoViewController ()<SBHeaderTitleDelegate>

@end

@implementation JianshuDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的控制器
    [self setupAllChildVc];
    [self setupNav];
    
    //设置头部视图的布局方式
    self.headerViewStyle = SBHeaderViewStyleBottom;
    
    SBHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"SBHeaderView" owner:nil options:nil].firstObject;
    self.headerView = header;
    //设置代理
    self.delegate = self;
    
}

#pragma mark - ----------SBHeaderTitleDelegate-----------
- (void)headerViewHeightDidChange:(CGFloat)height
{
    CGFloat scale = height / self.headerView.lzs_height;
    SBTitleView *titleView = (SBTitleView *)self.navigationItem.titleView;
    if (scale < 0.5) {
        scale = 0.5;
    }
    titleView.iconView.transform = CGAffineTransformMakeScale(scale, scale);
    NSLog(@"%f", height / self.headerView.lzs_height);
}

- (void)setupAllChildVc
{
    //全部
    UIViewController *first = [[FirstTableViewController alloc] init];
    first.title = @"动态";
    [self addChildViewController:first];
    //待发货
    UIViewController *second = [[SecondTableViewController alloc] init];
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"anlysis_cold"] forState:UIControlStateNormal];
    [btn setTitle:@"文章" forState:UIControlStateNormal];
    second.navigationItem.titleView = btn;
    [self addChildViewController:second];
    
    //待收货
    UIViewController *third = [[ThirdTableViewController alloc] init];
    third.title = @"更多";
    [self addChildViewController:third];
    
}

- (void)setupNav
{
    SBTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:@"SBTitleView" owner:nil options:nil].firstObject;
    titleView.frame = CGRectMake(0, 0, 40, 200);
    
    
    self.navigationItem.titleView = titleView;
}





@end
