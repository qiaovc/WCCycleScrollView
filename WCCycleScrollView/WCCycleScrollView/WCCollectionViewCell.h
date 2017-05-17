//
//  WCCollectionViewCell.h
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCCollectionViewCell : UICollectionViewCell
@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIColor *titleLabelTextColor;
@property(nonatomic, strong) UIFont *titleLabelTextFont;
@property(nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property(nonatomic, assign) NSTextAlignment titleLabelTextAlignment;
@property(nonatomic, assign) CGFloat titleLabelHeight;

@property(nonatomic, assign) BOOL hasConfig;
@end
