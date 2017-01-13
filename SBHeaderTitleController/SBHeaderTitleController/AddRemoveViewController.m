//
//  AddRemoveViewController.m
//  demo
//
//  Created by 罗壮燊 on 2017/1/12.
//  Copyright © 2017年 罗壮燊. All rights reserved.
//

#import "AddRemoveViewController.h"


@interface AddRemoveViewController ()
@property (weak, nonatomic) IBOutlet UITextField *removeTF;
@property (weak, nonatomic) IBOutlet UITextField *addTF;

@end

@implementation AddRemoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)remove:(id)sender {
    
    self.view.userInteractionEnabled = NO;
    self.removeBolck(self.removeTF.text);
    [self performSelector:@selector(pop) withObject:nil afterDelay:1.0];
}
- (IBAction)add:(id)sender {
    
    self.view.userInteractionEnabled = NO;
    self.addBolck(self.addTF.text);
    [self performSelector:@selector(pop) withObject:nil afterDelay:1.0];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
