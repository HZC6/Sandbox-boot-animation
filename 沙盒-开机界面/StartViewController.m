//
//  StartViewController.m
//  沙盒-开机界面
//
//  Created by mac1 on 16/7/19.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "StartViewController.h"

//------------------本程序的功能是实现进入界面后的滑动效应------------------
#import "StartViewController.h"
#import "ViewController.h"

//定义屏幕高度和宽度
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface StartViewController () <UIScrollViewDelegate> {
    
    //1) 定义滑动视图
    UIScrollView *_scrollView;
    
    //2) 定义ImageView的图片名
    NSArray *_imageNameArray;
    
    //3) 定义分页控件
    UIPageControl *_pageControl;
    
}

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1) 创建启动图片
    [self createStartView];
    
    //2) 加载分页控件
    [self createPageControl];
    
    
}

#pragma mark - 创建启动图片
- (void) createStartView {
    
    //------------------1. 初始化图片名------------------
    _imageNameArray = @[ @"1", @"2", @"3", @"4" ];
    
    
    //------------------2. 初始化滑动视图------------------
    //1) 初始化
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //2) 不显示水平滑动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //3) 定义滑动范围
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _imageNameArray.count, kScreenHeight);
    //4) 分页效果
    _scrollView.pagingEnabled = YES;
    //5) 代理
    _scrollView.delegate = self;
    //6) 添加到当前视图中
    [self.view addSubview:_scrollView];
    
    //------------------3. 加载启动图片------------------
    for (int i = 0; i < _imageNameArray.count; i++) {
        //a) 获取图片
        UIImage *image = [UIImage imageNamed:_imageNameArray[i]];
        //b) 创建图片视图
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        //c) 显示位置：frame
        imageView.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight);
        //d) 用户交互
        imageView.userInteractionEnabled = YES;
        //e) 添加到滑动视图中
        [_scrollView addSubview:imageView];
    }
    
}

#pragma mark - 创建分页控件
- (void) createPageControl {
    
    //1) 初始化分页控件
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 30)];
    //2) 设置页码指示器的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //3) 设置选中的指示器颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //4) 设置页码
    _pageControl.numberOfPages = _imageNameArray.count;
    //5) 添加点击事件
    [_pageControl addTarget:self
                     action:@selector(pageControlValueChangeAction)
           forControlEvents:UIControlEventValueChanged];
    //6) 添加到当前视图
    [self.view addSubview:_pageControl];
    
}

#pragma mark - 分页控件的点击事件
//作用：点击上面的小点时，会一个一个的切换
- (void) pageControlValueChangeAction{
    
    //a) 计算偏移量
    float x = _pageControl.currentPage * kScreenWidth;
    
    //b) 根据偏移量来切换图片
    //    _scrollView.contentOffset = CGPointMake(x, _scrollView.contentOffset.y);
    [_scrollView setContentOffset:CGPointMake(x, _scrollView.contentOffset.y) animated:YES];
    
    
}

#pragma mark - 滑动时分页效果也会跟着切换(代理方法)
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //1) 获取移动的偏移量
    float offsetX = scrollView.contentOffset.x;
    
    //2) 根据偏移计算页数
    _pageControl.currentPage = (NSInteger) (offsetX / kScreenWidth);
    
}

#pragma mark - 滑动到最后一个视图时，就跳转(代理方法)
//原理：由于滑动到最后一个视图时，已经到3倍的屏幕宽度，那么大于3倍的屏幕宽度，就跳转到下一个视图
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //a) 定义一个count
    NSInteger count = _imageNameArray.count - 1;
    
    //b) 当大于3倍时，就跳转到下一个视图
    if (scrollView.contentOffset.x > count * kScreenWidth) {
        
        //1) 添加动画 
        [UIView animateWithDuration:0.5 animations:^{
            //2) 通过UIWindow来控制  -----》 不要初始化，直接获取当前视图的window即可
            UIWindow *window = self.view.window;
            
            //3) 权限给下一个视图
            window.rootViewController = [[ViewController alloc] init];
        }];
        
    }
}



@end
