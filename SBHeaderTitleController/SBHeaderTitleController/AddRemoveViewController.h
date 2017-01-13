//
//  AddRemoveViewController.h
//  demo
//
//  Created by 罗壮燊 on 2017/1/12.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRemoveViewController : UIViewController


@property (copy, nonatomic) void(^removeBolck)(NSString *);
@property (copy, nonatomic) void(^addBolck)(NSString *);

@end
