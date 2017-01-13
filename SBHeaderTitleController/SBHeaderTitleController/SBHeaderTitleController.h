//
//  YJSShopController.h
//  YJS
//
//  Created by 罗壮燊 on 2016/12/12.
//  Copyright © 2016年 zbky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"


#define LZSMargin 10
#define LZSTitlesViewHeight 40
#define LZSNavMaxY 64
#define LZSTitleButtonMargin 40

#define LZSScreenW [UIScreen mainScreen].bounds.size.width
#define LZSScreenH [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, SBHeaderViewStyle) {
    SBHeaderViewStyleCenter,
    SBHeaderViewStyleBottom
};

@protocol SBHeaderTitleDelegate <NSObject>

@optional
- (void)headerViewHeightDidChange:(CGFloat)height;

@end

@interface SBHeaderTitleController : UIViewController

///顶部视图
@property (strong, nonatomic) UIView *headerView;
///顶部视图布局类型
@property (assign, nonatomic) SBHeaderViewStyle headerViewStyle;
///标题栏背景颜色
@property (strong, nonatomic) UIColor *titlesViewBackgroundColor;
///选中按钮的颜色
@property (strong, nonatomic) UIColor *selectTitleColor;
///默认按钮颜色
@property (strong, nonatomic) UIColor *normalTitleColor;
///标题按钮字体
@property (strong, nonatomic) UIFont *titleButtonFont;
///选中下划线颜色
@property (strong, nonatomic) UIColor *underlineColor;
///是否有导航栏
@property (assign, nonatomic) BOOL hasNavigationBar;
///代理
@property (weak, nonatomic) id<SBHeaderTitleDelegate> delegate;

///<#des#>
@property (assign, nonatomic) BOOL titlesViewCanScroll;

- (void)setupTitlesButton;
- (void)removeChildViewControllerWithIndex:(NSInteger)index;



@end

