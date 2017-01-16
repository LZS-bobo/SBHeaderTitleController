# SBHeaderTitleController
快速创建类似某宝店铺详情页

最近项目需要一个类似淘宝店铺详情页的界面，实现完需求闲着没事就简单封装一下[SBHeaderTitleController](https://github.com/LZS-bobo/SBHeaderTitleController)

用法 继承SBHeaderTitleController 用法和系统的UITabBarController 差不多
* 拥有有headerView 的情况

```
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的控制器
    [self setupAllChildVc];
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
```
![某宝.gif](http://upload-images.jianshu.io/upload_images/1899979-82d988e79bc993be.gif?imageMogr2/auto-orient/strip)

* 模仿简书
![简书.gif](http://upload-images.jianshu.io/upload_images/1899979-b0afca0226221b83.gif?imageMogr2/auto-orient/strip)

* 模仿熊猫TV 
标题按钮栏可以滚动 能够快速添加和删除
![熊猫TV.gif](http://upload-images.jianshu.io/upload_images/1899979-09a2152b77ee1f65.gif?imageMogr2/auto-orient/strip)gif?imageMogr2/auto-orient/strip)
