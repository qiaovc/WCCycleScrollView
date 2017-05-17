# WCCycleScrollView
iOS 循环滚动幻灯片

# 使用
```objc
    WCCycleScrollView *cycleView = [WCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, width, 200) delegate:self placeholderImage:[UIImage imageNamed:@"h6"]];
    cycleView.delegate = self;
    cycleView.imageURLStringGroup = @[@"http://d.5857.com/xgs_150428/desk_005.jpg",@"http://imgstore.cdn.sogou.com/app/a/100540002/406526.jpg",@"http://www.bz55.com/uploads/allimg/150701/140-150F1142638.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/83025aafa40f4bfbaa2e3c72094f78f0f736181d.jpg"];
    cycleView.titleGroup = @[@"这是第一张这是第一张这是第一张这是第一张这是第一张这是第一张",@"这是第二张",@"这是第三张",@"这是第四张"];
    [scrollview addSubview:cycleView];

```


 ![image](https://github.com/Verchen/WCCycleScrollView/raw/master/效果图.gif)


