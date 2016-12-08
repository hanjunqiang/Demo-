//
//  ViewController.m
//
//  Created by lisilong on 15/9/21 QQ:876996667.
//

#import "ViewController.h"
#import "LSLStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)success:(id)sender {
//    [LSLStatusBarHUD showImage:[UIImage imageNamed:@"xxx"] text:@"加载成功！"];
//    [LSLStatusBarHUD showImageName:@"xxx" text:@"加载成功！"];
    
    [LSLStatusBarHUD showSuccess:@"加载成功！"];
}

- (IBAction)failure:(id)sender {
    [LSLStatusBarHUD showError:@"加载失败！"];
}

- (IBAction)loadClick:(id)sender {
    [LSLStatusBarHUD showLoadding:@"正在加载中"];
}

- (IBAction)hide:(id)sender {
    [LSLStatusBarHUD hide];
}

- (IBAction)text:(id)sender {
    [LSLStatusBarHUD showText:@"明天会更好！"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
@end
