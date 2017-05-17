//
//  ViewController.m
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import "ViewController.h"
#import "WCCycleScrollView.h"
@interface ViewController ()<WCCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollview];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    WCCycleScrollView *cycleView = [WCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, width, 200) delegate:self placeholderImage:[UIImage imageNamed:@"h6"]];
    cycleView.delegate = self;
    cycleView.imageURLStringGroup = @[@"http://d.5857.com/xgs_150428/desk_005.jpg",@"http://imgstore.cdn.sogou.com/app/a/100540002/406526.jpg",@"http://www.bz55.com/uploads/allimg/150701/140-150F1142638.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/83025aafa40f4bfbaa2e3c72094f78f0f736181d.jpg"];
    cycleView.titleGroup = @[@"这是第一张这是第一张这是第一张这是第一张这是第一张这是第一张",@"这是第二张",@"这是第三张",@"这是第四张"];
    [scrollview addSubview:cycleView];
    
}
- (void)cycleScrollView:(WCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor brownColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
