//
//  WCCycleScrollView.m
//  WCCycleScrollView
//
//  Created by 乔伟成 on 2017/5/10.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

#import "WCCycleScrollView.h"
#import "WCCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+WCExtension.h"
@interface WCCycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, weak) UICollectionView *mainView;
@property(nonatomic, weak) UIPageControl *pageControl;
@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic, assign) NSInteger totalItemCount;
@end

@implementation WCCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)initialization
{
    _titleLabelTextAlignment = NSTextAlignmentLeft;
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont = [UIFont systemFontOfSize:14];
    _titleLabelHeight = 30;
    _autoScrollTimeInterval = 2.0;
}

- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = self.frame.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.pagingEnabled = YES;
    mainView.showsVerticalScrollIndicator = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.delegate = self;
    mainView.dataSource = self;
    [mainView registerClass:[WCCollectionViewCell class] forCellWithReuseIdentifier:@"WCCollectionViewCell"];
    [self addSubview:mainView];
    _mainView = mainView;
}
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<WCCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
{
    WCCycleScrollView *cycleScrollView = [[WCCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    return cycleScrollView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WCCollectionViewCell" forIndexPath:indexPath];
    NSInteger index = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    NSString *imagePath = self.imageURLStringGroup[index];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage];
    cell.title = self.titleGroup[index];
    
    cell.titleLabelTextAlignment = self.titleLabelTextAlignment;
    cell.titleLabelTextColor = self.titleLabelTextColor;
    cell.titleLabelTextFont = self.titleLabelTextFont;
    cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
    cell.titleLabelHeight = self.titleLabelHeight;
    return cell;
}
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.imageURLStringGroup.count;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_mainView.contentOffset.x == 0 && _totalItemCount) {
        int targetIndex = _totalItemCount*0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}
- (void)setImageURLStringGroup:(NSArray *)imageURLStringGroup
{
    _imageURLStringGroup = imageURLStringGroup;
    _totalItemCount = imageURLStringGroup.count * 100;
    [self invalidateTimer];
    [self setupTimer];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}
- (void)automaticScroll
{
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}
- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= _totalItemCount) {
        targetIndex = _totalItemCount * 0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}
- (int)currentIndex
{
    return (int)(_mainView.contentOffset.x / self.wc_width);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}
@end
