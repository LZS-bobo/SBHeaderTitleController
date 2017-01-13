//
//  UIView+Frame.h
//  01-BuDeJie
//
//  Created by 1 on 16/1/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

// @property只会生成get,set方法声明,不会生成实现和下划线成员属性
// 开发规范:自己的分类,尽量添加项目前缀
@interface UIView (Frame)

/**
 *  判断屏幕上的self是否和anotherView有重叠
 */
- (BOOL)lzs_intersectWithView:(UIView *)anotherView;

@property CGFloat lzs_width;
@property CGFloat lzs_height;
@property CGFloat lzs_x;
@property CGFloat lzs_y;
@property CGFloat lzs_centerX;
@property CGFloat lzs_centerY;
@property CGSize lzs_size;
@property CGPoint lzs_origin;

@end
