//
//  UIView+WCExtension.m
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import "UIView+WCExtension.h"

@implementation UIView (WCExtension)
- (CGFloat)wc_height
{
    return self.frame.size.height;
}
- (void)setWc_height:(CGFloat)wc_height
{
    CGRect temp = self.frame;
    temp.size.height = wc_height;
    self.frame = temp;
}
- (CGFloat)wc_width
{
    return self.frame.size.width;
}
- (void)setWc_width:(CGFloat)wc_width
{
    CGRect temp = self.frame;
    temp.size.width = wc_width;
    self.frame = temp;
}

- (CGFloat)wc_y
{
    return self.frame.origin.y;
}
- (void)setWc_y:(CGFloat)wc_y
{
    CGRect temp = self.frame;
    temp.origin.y = wc_y;
    self.frame = temp;
}
- (CGFloat)wc_x
{
    return self.frame.origin.x;
}
- (void)setWc_x:(CGFloat)wc_x
{
    CGRect temp = self.frame;
    temp.origin.x = wc_x;
    self.frame = temp;
}
@end
