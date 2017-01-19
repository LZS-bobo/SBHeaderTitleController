//
//  TaobaoShopViewController.m
//  demo
//
//  Created by 罗壮燊 on 2017/1/11.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "TaobaoShopViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"

@interface TaobaoShopViewController ()

@end

@implementation TaobaoShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的控制器
    [self setupAllChildVc];
    [self setupNav];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"taobao"];
    
    self.headerView = imageView;
    self.headerViewStyle = SBHeaderViewStyleBottom;
}

- (void)setupAllChildVc
{
    
    UIViewController *first = [[FirstTableViewController alloc] init];
    first.title = @"首页";
    [self addChildViewController:first];

    UIViewController *second = [[SecondTableViewController alloc] init];
    second.title = @"全部商品";
    [self addChildViewController:second];
    
    UIViewController *third = [[ThirdTableViewController alloc] init];
    third.title = @"上新";
    [self addChildViewController:third];
    
    UIViewController *fourth = [[ThirdTableViewController alloc] init];
    fourth.title = @"全部商品";
    [self addChildViewController:fourth];
    
}

- (void)setupNav
{
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, LZSScreenW - 155, 40)];
    search.placeholder = @"搜索店铺内商品";
    
    UITextField *textfield = [search valueForKey:@"_searchField"];
    [textfield setValue:[UIColor lightGrayColor] forKeyPath:@"placeholderLabel.textColor"];
    
    
    UIBarButtonItem *fenlei = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_classify"] style:UIBarButtonItemStylePlain target:self action:@selector(fenlei)];
    UIBarButtonItem *more = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_imformation"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:search];
    
    
    self.navigationItem.rightBarButtonItems = @[more, fenlei, item];
}

- (void)fenlei
{
    NSLog(@"fenlei");
    
    
}
- (void)more
{
    NSLog(@"more");
    self.headerViewStyle = SBHeaderViewStyleCenter;
}



@end
