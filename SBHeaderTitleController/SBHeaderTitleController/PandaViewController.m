//
//  PandaViewController.m
//  demo
//
//  Created by 罗壮燊 on 2017/1/11.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "PandaViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"
#import "ThirdTableViewController.h"
#import "AddRemoveViewController.h"

@interface PandaViewController ()

@end

@implementation PandaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildVc];
    
    //设置为可以滚动的标题
    self.titlesViewCanScroll = YES;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    self.navigationItem.rightBarButtonItems = @[item1];
    
   
}


- (void)push
{
    AddRemoveViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddRemoveViewController"];
    vc.removeBolck = ^(NSString *title){
        [self remove:title];
    };
    
    vc.addBolck = ^(NSString *title){
        [self add:title];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)add:(NSString *)title
{
    UIViewController *first = [[FirstTableViewController alloc] init];
    first.navigationItem.titleView = [self buttonWithImage:title title:nil];
    [self addChildViewController:first];
}


- (void)remove:(NSString *)title
{
    //删除下标index的控制器
    [self removeChildViewControllerWithIndex:title.integerValue];
}

- (void)setupAllChildVc
{
    
    UIViewController *first = [[FirstTableViewController alloc] init];
    first.navigationItem.titleView = [self buttonWithImage:@"个人" title:@"个人详情"];
    [self addChildViewController:first];
    
    UIViewController *second = [[SecondTableViewController alloc] init];
    second.navigationItem.titleView = [self buttonWithImage:@"电池" title:@"电池电量"];
    [self addChildViewController:second];
    
    UIViewController *third = [[ThirdTableViewController alloc] init];
    third.navigationItem.titleView = [self buttonWithImage:@"编辑" title:@"编辑信息"];
    [self addChildViewController:third];
    
}

- (UIButton *)buttonWithImage:(NSString *)imageName title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    if (title == nil) {
        title = imageName;
    }
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}


@end
