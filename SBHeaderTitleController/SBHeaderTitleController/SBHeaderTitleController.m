//
//  YJSShopController.m
//  YJS
//
//  Created by 罗壮燊 on 2016/12/12.
//  Copyright © 2016年 zbky. All rights reserved.
//

#import "SBHeaderTitleController.h"



@interface SBHeaderTitleController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;

///顶部容器View
@property (strong, nonatomic) UIView *topView;
///topView Pan
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
///标题容器
@property (strong, nonatomic) UIScrollView *titlesView;
///高度约束
@property (weak, nonatomic) NSLayoutConstraint *topViewConstraintH;
///顶部容器View的最大高度
@property (assign, nonatomic) CGFloat topViewHeight;
///下划线
@property (nonatomic, strong) UIView *underline;
///选中按钮
@property (nonatomic, weak) UIButton *selectedButton;
///当前显示
@property (nonatomic, strong) UIScrollView *showView;
///添加过得View
@property (nonatomic, strong) NSMutableArray *childScrollViews;
///是否是悬浮状态
@property (assign, nonatomic, getter = isHover) BOOL hover;
///记录上一次点
@property (assign, nonatomic) CGPoint lastPoint;
///是否正在拖拽
@property (assign, nonatomic) BOOL topViewDragging;
///记录headerView控制SBHeaderViewStyle的约束 样式改变时移除约束
@property (strong, nonatomic) NSArray *constraints;
///titleBtns
@property (strong, nonatomic) NSMutableArray *titleBtns;

@end

@implementation SBHeaderTitleController



#pragma mark - ----------Public-----------

- (void)layoutTitlesView
{
    [self setupTitlesButton];
}

/**
 移除index 的子控制器
 */
- (void)removeChildViewControllerWithIndex:(NSInteger)index
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        
        if (i == index) {
            
            UIViewController *vc = self.childViewControllers[i];
            [vc removeFromParentViewController];
            
            if (vc.view.superview) {
                [vc.view removeFromSuperview];
                [vc.view removeObserver:self forKeyPath:@"contentOffset"];
                [vc.view removeObserver:self forKeyPath:@"contentSize"];
                [vc.view removeObserver:self forKeyPath:@"contentInset"];
                [self.childScrollViews removeObject:vc.view];
            }
            
            [self.titleBtns[index] removeFromSuperview];
            [self.titleBtns removeObjectAtIndex:index];
            [self setupTitlesButton];
            self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width - LZSScreenW, 0);
            if (self.selectedButton.tag == i ) {
                
                if (self.titleBtns.count) {
                    [self clickTitleButton:self.titleBtns[0]];
                }
    
            } else {
                [self clickTitleButton:self.selectedButton];
            }
        }
    }
}


#pragma mark - ----------Lifecycle-----------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.titleButtonFont = [UIFont systemFontOfSize:16];
    self.selectTitleColor = [UIColor brownColor];
    self.normalTitleColor = [UIColor blackColor];
    self.titlesViewBackgroundColor = [UIColor whiteColor];
    self.underlineColor = self.selectTitleColor;
    
    [self addSubviews];
    [self addConstrains];
    [self.topView addGestureRecognizer:self.pan];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.childViewControllers.count && !self.childScrollViews.count) {
        //默认添加第一个视图
        [self addChildViewToScrollView:0];
        //添加标题栏
        [self setupTitlesView];
    }
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)dealloc
{
    for (UIScrollView *scrollView in self.childScrollViews) {
        [scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [scrollView removeObserver:self forKeyPath:@"contentSize"];
        [scrollView removeObserver:self forKeyPath:@"contentInset"];
        
    }
}



#pragma mark - ----------UI-----------
- (void)addSubviews
{
    //add
    [self.topView addSubview:self.titlesView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.topView];
    
}

- (void)addConstrains
{
    //constraints
    
    //self.topView
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTop relatedBy:0 toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:LZSNavMaxY];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:0 multiplier:1.0 constant:self.headerView.lzs_height + LZSTitlesViewHeight];
    
    
    NSArray *topViewConstraintsW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topView]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:NSDictionaryOfVariableBindings(_topView)];
    
    //self.titlesView
    NSLayoutConstraint *titlesViewHeight = [NSLayoutConstraint constraintWithItem:self.titlesView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:0 multiplier:1.0 constant:LZSTitlesViewHeight];
    
    NSLayoutConstraint *titlesViewBottom = [NSLayoutConstraint constraintWithItem:self.titlesView attribute:NSLayoutAttributeBottom relatedBy:0 toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *titlesViewConstraintsW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titlesView]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(_titlesView)];
    
    //self.scrollView
    NSArray *scrollViewConstraintsW = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(_scrollView)];
    NSArray *scrollViewConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(_scrollView)];
    
    
    self.topViewConstraintH = height;
    
    [self.topView addConstraint:titlesViewBottom];
    [self.topView addConstraint:titlesViewHeight];
    [self.topView addConstraints:titlesViewConstraintsW];
    
    [self.view addConstraints:topViewConstraintsW];
    [self.view addConstraint:top];
    [self.view addConstraint:height];
    
    [self.view addConstraints:scrollViewConstraintsH];
    [self.view addConstraints:scrollViewConstraintsW];
    
    [self.view layoutIfNeeded];
}



- (void)setupTitlesView
{
//    [self setupTitlesButton];
    [self setupUnderline];
}


/**
 * 添加标题按钮
 */
- (void)setupTitlesButton
{
    NSInteger count = self.childViewControllers.count;
    
    CGFloat titleButtonW = LZSScreenW / count;
    CGFloat contentSizeW = 0;
    
    UIButton *titleButton = nil;
    
    for (int i = 0; i < count; i++) {
        
        NSInteger titlesCount = self.titleBtns.count;
        if (titlesCount >= i + 1) {
            
            titleButton = self.titleBtns[i];
            
        } else {
            
            UIViewController *vc = self.childViewControllers[i];
            if ([vc.navigationItem.titleView isKindOfClass:[UIButton class]]) {
                
                titleButton = (UIButton *)vc.navigationItem.titleView;
                
                
            } else {
                titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [titleButton setTitle:vc.title forState:UIControlStateNormal];
            }
            [titleButton setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
            [titleButton setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
            
            titleButton.titleLabel.font = self.titleButtonFont;
            [titleButton addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.titleBtns addObject:titleButton];
        }
        
        titleButton.tag = i;
        [titleButton sizeToFit];
        
        if (self.titlesViewCanScroll) {
            titleButton.lzs_x = contentSizeW + LZSTitleButtonMargin;

        } else {
            titleButton.lzs_x = titleButtonW * i;
            titleButton.lzs_width = titleButtonW;
        }
        
        titleButton.lzs_height = LZSTitlesViewHeight;
        [self.titlesView addSubview:titleButton];
        
        contentSizeW += titleButton.lzs_width + LZSTitleButtonMargin;
        
        
        
    }
    
    
    if (self.titlesViewCanScroll) {
        //设置标题栏的滚动范围
        contentSizeW += LZSTitleButtonMargin;
        self.titlesView.contentSize = CGSizeMake(contentSizeW, 0);
    }
}

/**
 * 设置下划线
 */
- (void)setupUnderline
{
    //取出第一个按钮
    UIButton *firstButton = self.titleBtns[0];
    
    [self.titlesView addSubview:self.underline];
    
    
    //初始化第一个按钮的状态
    firstButton.selected = YES;
    self.selectedButton = firstButton;
    //强制第一个按钮的文字计算自己的宽度
    [firstButton.titleLabel sizeToFit];
    
    //设置下划线的frame
    self.underline.lzs_height = 2;
    self.underline.lzs_width = firstButton.titleLabel.lzs_width + firstButton.imageView.lzs_width + LZSMargin;
    self.underline.lzs_centerX = firstButton.lzs_centerX;
    self.underline.lzs_y = LZSTitlesViewHeight - self.underline.lzs_height;
}

#pragma mark - ----------Private-----------

/**
 * 添加角标index的view到scrollview
 */
- (void)addChildViewToScrollView:(NSInteger)index
{
    
    UIViewController *vc = self.childViewControllers[index];
    self.topViewHeight = self.headerView.lzs_height + LZSTitlesViewHeight;
    UIScrollView *scrollView = (UIScrollView *)vc.view;
    
    
    
    if (!scrollView.superview) { //添加子视图
        
       
        
        UIEdgeInsets inset = scrollView.contentInset;
        inset.top += self.topViewHeight + LZSNavMaxY;
        scrollView.contentInset = inset;
        
        [self.scrollView addSubview:scrollView];
        
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
        [self.childScrollViews addObject:scrollView];
        
    }
    scrollView.frame = CGRectMake(index * LZSScreenW, 0, LZSScreenW, LZSScreenH);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat hoverHeight = LZSTitlesViewHeight + LZSNavMaxY;
    
    if (self.isHover) { //悬停状态
        
        if (offsetY <= -hoverHeight) {
            offsetY = -hoverHeight;
        }
        
    } else { //非悬停状态
        offsetY = -(self.topViewConstraintH.constant + LZSNavMaxY);
    }
    
    scrollView.contentOffset = CGPointMake(0, offsetY);
    //当前屏幕上显示的View
    _showView = scrollView;
    
}


/**
 更新scrollView 子View 的 contentInset
 */
- (void)updateChildViewContentInsetWithNewTop:(CGFloat)top
{
    UIEdgeInsets inset = UIEdgeInsetsZero;
    for (UIScrollView *scrollView in self.childScrollViews) {
        inset = scrollView.contentInset;
        inset.top -= self.headerView.lzs_height;
        inset.top += top;
        scrollView.contentInset = inset;
    }
}

- (void)scrollTitleScrollViewOffsetXWithIndex:(NSInteger)index
{
    UIButton *btn = self.titleBtns[index];
    //设置标题栏的偏移量
    CGFloat offsetX = btn.center.x - (LZSScreenW ) * 0.5;
    CGFloat offsetMax = self.titlesView.contentSize.width - (LZSScreenW);
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    if (offsetMax >=0 && offsetX > offsetMax) {
        offsetX = offsetMax;
    }
    [self.titlesView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - ----------Override-----------
- (void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    self.scrollView.contentSize = CGSizeMake(LZSScreenW * self.childViewControllers.count, 0);
    [self setupTitlesButton];
}



#pragma mark - ----------KVO-----------
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView *)scrollView change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView != _showView) return;
    if (self.topViewDragging) return;
    
    if (scrollView.contentSize.height < (LZSScreenH - LZSTitlesViewHeight - LZSNavMaxY)) {
        scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, (LZSScreenH - LZSTitlesViewHeight - LZSNavMaxY));
    }
    
    scrollView.scrollIndicatorInsets = scrollView.contentInset;
    [self.topView addGestureRecognizer:self.pan];
    
    CGFloat constant = self.topViewConstraintH.constant;
    CGFloat insetTop = scrollView.contentInset.top;

    
    if (offsetY > -insetTop && offsetY < 0) {
        constant -= constant - fabs(offsetY) + LZSNavMaxY;
        self.hover = NO;
        
    } else if (offsetY <= -insetTop) {
        constant = self.topViewHeight;
        self.hover = NO;
    }
    
    
    if (constant <= LZSTitlesViewHeight) {
        constant = LZSTitlesViewHeight;
        self.hover = YES;
        [self.topView removeGestureRecognizer:self.pan];
    }
    
    if ([self.delegate respondsToSelector:@selector(headerViewHeightDidChange:)]) {
        [self.delegate headerViewHeightDidChange:constant - LZSTitlesViewHeight];
    }
    
    self.topViewConstraintH.constant = constant;
    
}



#pragma mark - ----------UIScrollViewDelegate-----------
/**
 * 停止滚动的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算滚动到第几页
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / LZSScreenW;
    //取出对应页码的按钮
    UIButton *button = [self.titleBtns objectAtIndex:page];
    //调用按钮点击事件
    [self clickTitleButton:button];
}


#pragma mark - ----------getter&&setter-----------
- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
        _topView.clipsToBounds = YES;
        _topView.backgroundColor = [UIColor purpleColor];
        
        
    }
    return _topView;
}

- (UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    }
    return _pan;
}

- (UIView *)titlesView
{
    if (!_titlesView) {
        _titlesView = [[UIScrollView alloc] init];
        _titlesView.backgroundColor = self.titlesViewBackgroundColor;
        _titlesView.showsVerticalScrollIndicator = NO;
        _titlesView.showsHorizontalScrollIndicator = NO;
        _titlesView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titlesView;
}

- (UIView *)underline
{
    if (!_underline) {
        //创建下划线
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = self.underlineColor;
    }
    return _underline;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (NSMutableArray *)childScrollViews
{
    if (!_childScrollViews) {
        _childScrollViews = [NSMutableArray array];
    }
    return _childScrollViews;
}

- (NSMutableArray *)titleBtns

{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (void)setHeaderView:(UIView *)headerView
{
    if (_headerView == headerView) return;
    
    //更新scrollView 子View 的 contentInset
    [self updateChildViewContentInsetWithNewTop:headerView.lzs_height];
    
    //移除之前的View
    [_headerView removeFromSuperview];
    
    _headerView = headerView;
    
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topView insertSubview:headerView atIndex:0];
    
    //左右
    [self.topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|"
                                            options:0
                                            metrics:nil
                                              views:NSDictionaryOfVariableBindings(headerView)]];
    //高
    [self.topView addConstraint:[NSLayoutConstraint constraintWithItem:headerView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:headerView.lzs_height]];
    
    if (self.headerViewStyle == SBHeaderViewStyleCenter) {
        //水平垂直居中
        [self topViewAddCenterContraints];
    } else {
        //底部对齐
        [self topViewAddBottomContraints];
    }

    self.topViewHeight = headerView.lzs_height + LZSTitlesViewHeight;
    self.topViewConstraintH.constant = self.topViewHeight;
}

- (void)topViewAddCenterContraints
{
    //居中X
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeCenterX relatedBy:0 toItem:self.topView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.topView addConstraint:centerX];
    
    //居中Y
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self.topView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-LZSTitlesViewHeight / 2.0];
    [self.topView addConstraint:centerY];
    self.constraints = @[centerY,centerX];
}

- (void)topViewAddBottomContraints
{
    //底部对齐
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_headerView attribute:NSLayoutAttributeBottom relatedBy:0 toItem:self.topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-LZSTitlesViewHeight];
    [self.topView addConstraint:bottom];
    self.constraints = @[bottom];
}

- (void)setHeaderViewStyle:(SBHeaderViewStyle)headerViewStyle
{
    if (!_headerView) { //没有头部视图
    _headerViewStyle = headerViewStyle;
    } else { //有头部视图
        if (_headerViewStyle != headerViewStyle) {
            _headerViewStyle = headerViewStyle;
            [self.topView removeConstraints:self.constraints];
            if (headerViewStyle == SBHeaderViewStyleCenter) {
                //水平垂直居中
                [self topViewAddCenterContraints];
            } else {
                //底部对齐
                [self topViewAddBottomContraints];
            }
        }
    }
    
}

- (void)setTitlesViewCanScroll:(BOOL)titlesViewCanScroll
{
    _titlesViewCanScroll = titlesViewCanScroll;
    [self setupTitlesButton];
}

- (void)setTopViewHeight:(CGFloat)topViewHeight
{
    _topViewHeight = topViewHeight;
}


#pragma mark - ----------事件处理--------------
/**
 * 点击标题按钮
 */
- (void)clickTitleButton:(UIButton *)button animation:(BOOL)animation
{
    self.selectedButton.selected = NO;
    button.selected = YES;

    if (self.selectedButton == button) {
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:UIButtonDidRepeatClickNotification object:nil];
    }
    self.selectedButton = button;
    
    NSTimeInterval duration = animation?0.25:0;
    [UIView animateWithDuration:duration animations:^{
        //下划线移动到对应按钮的下方，设置下划线的frame
        self.underline.lzs_width = button.titleLabel.lzs_width + button.imageView.lzs_width + LZSMargin;
        self.underline.lzs_centerX = button.lzs_centerX;
        self.underline.lzs_y = LZSTitlesViewHeight - self.underline.lzs_height;
        self.underline.lzs_height = 2;
        //滚动到对应控制器View的位置
        self.scrollView.contentOffset = CGPointMake(button.tag * self.scrollView.lzs_width, self.scrollView.contentOffset.y);
        
    }];
    //添加控制器的View
    [self addChildViewToScrollView:button.tag];
    
    if (self.titlesViewCanScroll) {
        [self scrollTitleScrollViewOffsetXWithIndex:button.tag];
    }
}

- (void)clickTitleButton:(UIButton *)button
{
    [self clickTitleButton:button animation:YES];
}


/**
 topView panGestureRecognizer
 */

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:pan.view];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.topViewDragging = YES;
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGFloat distance  = location.y - self.lastPoint.y;
        CGFloat height = self.topViewConstraintH.constant + distance;
        CGPoint offset = self.showView.contentOffset;
        
        if (height >= self.topViewHeight) {
            height = self.topViewHeight;
            
            offset.y = -self.showView.contentInset.top;
            distance = 0;
            self.showView.contentOffset = offset;
        }
        if (height <= LZSTitlesViewHeight) {
            height = LZSTitlesViewHeight;
            distance = 0;
            offset.y = -(LZSNavMaxY + LZSTitlesViewHeight);
        }
        
        if ([self.delegate respondsToSelector:@selector(headerViewHeightDidChange:)]) {
            [self.delegate headerViewHeightDidChange:height - LZSTitlesViewHeight];
        }
        self.topViewConstraintH.constant = height;
        offset.y -= distance;
        self.showView.contentOffset = offset;
        
    } else {
        self.topViewDragging = NO;
    }
    
    self.lastPoint = location;
    
}



@end



