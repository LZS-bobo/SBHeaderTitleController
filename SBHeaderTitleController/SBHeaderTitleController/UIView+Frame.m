//
//  UIView+Frame.m
//  01-BuDeJie
//
//  Created by 1 on 16/1/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


- (BOOL)lzs_intersectWithView:(UIView *)anotherView
{
    if (anotherView == nil) {
        anotherView = [UIApplication sharedApplication].keyWindow;
    }
    
    //转换为同一坐标系
    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [anotherView convertRect:anotherView.bounds toView:nil];
    
    return CGRectContainsRect(rect1, rect2);
}

- (void)setLzs_centerX:(CGFloat)lzs_centerX
{
    CGPoint point = self.center;
    point.x = lzs_centerX;
    self.center = point;
}

- (CGFloat)lzs_centerX
{
    return self.center.x;
}

- (void)setLzs_centerY:(CGFloat)lzs_centerY
{
    CGPoint point = self.center;
    point.y = lzs_centerY;
    self.center = point;
}

- (CGFloat)lzs_centerY
{
    return self.center.y;
}

- (void)setLzs_width:(CGFloat)lzs_width{
    CGRect frame = self.frame;
    frame.size.width = lzs_width;
    self.frame = frame;
}

- (CGFloat)lzs_width
{
    return self.frame.size.width;
}

- (void)setLzs_height:(CGFloat)lzs_height
{
    CGRect frame = self.frame;
    frame.size.height = lzs_height;
    self.frame = frame;
}
- (CGFloat)lzs_height
{
     return self.frame.size.height;
}

- (void)setLzs_x:(CGFloat)lzs_x
{
    CGRect frame = self.frame;
    frame.origin.x = lzs_x;
    self.frame = frame;
}

- (CGFloat)lzs_x
{
    return self.frame.origin.x;
}

- (void)setLzs_y:(CGFloat)lzs_y
{
    CGRect frame = self.frame;
    frame.origin.y = lzs_y;
    self.frame = frame;
}

- (CGFloat)lzs_y
{
    return self.frame.origin.y;
}

- (void)setLzs_origin:(CGPoint)lzs_origin
{
    CGRect frame = self.frame;
    frame.origin = lzs_origin;
    self.frame = frame;
}

- (CGPoint)lzs_origin
{
    return self.frame.origin;
}

- (void)setLzs_size:(CGSize)lzs_size
{
    CGRect frame = self.frame;
    frame.size = lzs_size;
    self.frame = frame;
}

- (CGSize)lzs_size
{
    return self.frame.size;
}



@end
