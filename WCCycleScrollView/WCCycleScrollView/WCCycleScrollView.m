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

@property(nonatomic, weak) UICollectionView     *mainView;
@property(nonatomic, weak) UIPageControl        *pageControl;
@property(nonatomic, weak) NSTimer              *timer;
@property(nonatomic, assign) NSInteger          totalItemCount;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
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
    _autoScrollTimeInterval = 3.0;
    
}

- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor grayColor];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = self.frame.size;
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 && _totalItemCount) {
        int targetIndex = _totalItemCount*0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    CGFloat width = [self.pageControl sizeForNumberOfPages:self.imageURLStringGroup.count].width;
    CGFloat height = 10.0;
    CGFloat x = self.mainView.frame.size.width - width - 10;
    CGFloat y = self.mainView.frame.size.height - height - 10;
    self.pageControl.frame = CGRectMake(x, y, width, 10);
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

-(void)dealloc
{
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}
//MARK: - 属性
- (void)setImageURLStringGroup:(NSArray *)imageURLStringGroup
{
    _imageURLStringGroup = imageURLStringGroup;
    _totalItemCount = imageURLStringGroup.count * 100;
    if (imageURLStringGroup.count == 1) {
        self.mainView.scrollEnabled = NO;
    }
    [self setupPageControl];
    [self invalidateTimer];
    [self setupTimer];
}

//MARK: - 自定义方法
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

- (void)setupPageControl
{
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    if (self.imageURLStringGroup.count == 0) return;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageURLStringGroup.count;
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
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

/**
 获取当前collection view显示的下标

 @return 下标值
 */
- (int)currentIndex
{
    return (int)((_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width);
}
/**
 获取pagecontrol要显示的下标

 @param index collectionview当前显示的下标
 @return pagecontrol要显示的下标
 */
- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.imageURLStringGroup.count;
}

//MARK: - collectionview 数据源代理方法

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
    cell.clipsToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
}
//MARK: - scrollview代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int collectionViewItemIndex = [self currentIndex];
    int pageControlCurrentPage = [self pageControlIndexWithCurrentCellIndex:collectionViewItemIndex];
    self.pageControl.currentPage = pageControlCurrentPage;
}
@end
