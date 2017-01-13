//
//  SBTitleView.m
//  demo
//
//  Created by 罗壮燊 on 2017/1/11.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "SBTitleView.h"

@interface SBTitleView ()

@end

@implementation SBTitleView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconView.layer.anchorPoint = CGPointMake(0.5, 0);
}

@end
