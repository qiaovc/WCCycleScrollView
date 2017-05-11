//
//  WCCollectionViewCell.m
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import "WCCollectionViewCell.h"
#import "UIView+WCExtension.h"
@implementation WCCollectionViewCell

{
    __weak UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = [NSString stringWithFormat:@"%@",title];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    CGFloat titleLabelW = self.wc_width;
    CGFloat titleLabelH = 20;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = self.wc_height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
}
@end
