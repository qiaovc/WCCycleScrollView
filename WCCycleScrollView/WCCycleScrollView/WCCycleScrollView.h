//
//  WCCycleScrollView.h
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCCycleScrollView;

@protocol WCCycleScrollViewDelegate <NSObject>

@optional

/**
 图片点击回调

 @param cycleScrollView cycleScrollView description
 @param index index description
 */
- (void)cycleScrollView:(WCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface WCCycleScrollView : UIView

/**
 初始化方法

 @param frame 尺寸
 @param delegate 点击回调代理
 @param placeholderImage 默认图片
 @return WCCycleScrollView 实例化对象
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame
                                delegate:(id<WCCycleScrollViewDelegate>)delegate
                        placeholderImage:(UIImage*)placeholderImage;

/**
 网络图片 url string 数组
 */
@property(nonatomic, strong) NSArray *imageURLStringGroup;
/**
 每张图片对应要显示的文字数组
 */
@property(nonatomic, strong) NSArray *titleGroup;

@property(nonatomic, assign) id<WCCycleScrollViewDelegate> delegate;

/**
 自动滚动时间间隔 默认2秒
 */
@property(nonatomic, assign) CGFloat autoScrollTimeInterval;


////////////////////////   自定义样式 ///////////////////////////////

/**
 占位图
 */
@property(nonatomic, strong) UIImage            *placeholderImage;
@property(nonatomic, strong) UIColor            *titleLabelTextColor;
@property(nonatomic, strong) UIFont             *titleLabelTextFont;
@property(nonatomic, strong) UIColor            *titleLabelBackgroundColor;
@property(nonatomic, assign) NSTextAlignment    titleLabelTextAlignment;
@property(nonatomic, assign) CGFloat            titleLabelHeight;
/**
 当前分页指示器颜色
 */
@property(nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 分页指示器颜色
 */
@property(nonatomic, strong) UIColor *pageIndicatorTintColor;
@end
