//
//  SIMEmojiView.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiView.h"
#import "SIMEmojiSinglePageView.h"
#import "SIMEmojiKeyBoardHead.h"
#import "UIView+SIMEmojiKeyBoardViewFrame.h"

#define EmojiKeyBoardColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface SIMEmojiView ()<UIScrollViewDelegate>
//View
@property (nonatomic, strong) UIScrollView *scroollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *sendButton;

//data
@property (nonatomic, strong) NSArray <SIMEmojiModel *> *emojiModles;  //表情赋值
@property (nonatomic, copy) void (^emojiDidDeleteBlock)(void);   //表情删除回调
@property (nonatomic, copy) void (^emojiDidSendBlock)(void);   //表情发送回调
@property (nonatomic, copy) void (^emojiDidSelectBlock)(SIMEmojiModel *emojiModel);   //选中某个表情回调


@end

@implementation SIMEmojiView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scroollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.sendButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //发送按钮
    CGSize sendButtonSize = self.sendButton.currentImage.size;
    self.sendButton.frame = CGRectMake(self.bounds.size.width - sendButtonSize.width, self.bounds.size.height - sendButtonSize.height-SIMEmojKeyBoardkBottomNOSafeArea_Height, sendButtonSize.width, sendButtonSize.height);
    
    //pageControl
    self.pageControl.bounds = CGRectMake(0, 0, self.bounds.size.width, 15);
    self.pageControl.center = CGPointMake(self.center.x, self.sendButton.center.y);
    self.pageControl.emojikey_height -= SIMEmojKeyBoardkBottomNOSafeArea_Height;
    
    //scrollView
    self.scroollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.sendButton.bounds.size.height - SIMEmojKeyBoardkBottomNOSafeArea_Height);
    
    //单个面板控件
    NSInteger count = self.scroollView.subviews.count;
    for (NSInteger i = 0; i < count; i++)
    {
        SIMEmojiSinglePageView *pageView = self.scroollView.subviews[i];
        CGFloat pageViewW = self.scroollView.bounds.size.width;
        CGFloat pageViewH = self.scroollView.bounds.size.height;
        CGFloat pageViewY = 0;
        CGFloat pageViewX = pageViewW * i;
        pageView.frame = CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH);
    }
    
    self.scroollView.contentSize = CGSizeMake(self.scroollView.bounds.size.width * count, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}

#pragma mark - handle
- (void)setEmojiModles:(NSArray <SIMEmojiModel *>*)emojiModles selectEmojiModelBlock:(void(^)(SIMEmojiModel*selectModel))selectBlock deleteBlcok:(void(^)(void))deleteBlcok sendBlcok:(void(^)(void))sendBlock
{
    self.emojiDidSendBlock = sendBlock;
    self.emojiDidDeleteBlock = deleteBlcok;
    self.emojiDidSelectBlock = selectBlock;
    self.emojiModles = emojiModles;
}

- (void)sendButtonClick
{
    if(self.emojiDidSendBlock)
        self.emojiDidSendBlock();
}

- (void)setEmojiModles:(NSArray<SIMEmojiModel *> *)emojiModles
{
    _emojiModles = emojiModles;
    [self.scroollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger pageCount = (emojiModles.count + SIMEmojKeyBoardSignlePageView_AllEmjoiCount - 1)/SIMEmojKeyBoardSignlePageView_AllEmjoiCount;
    self.pageControl.numberOfPages = pageCount;
    for (NSInteger i = 0; i < pageCount; i++)
    {
        SIMEmojiSinglePageView *pageView = [[SIMEmojiSinglePageView alloc]init];
        pageView.emojiDidDeleteBlock = self.emojiDidDeleteBlock;
        pageView.emojiDidSelectBlock = self.emojiDidSelectBlock;
        NSRange range;
        range.location = i * SIMEmojKeyBoardSignlePageView_AllEmjoiCount;
        NSInteger remainCount = emojiModles.count - range.location;
        if(remainCount >= SIMEmojKeyBoardSignlePageView_AllEmjoiCount)
            range.length = SIMEmojKeyBoardSignlePageView_AllEmjoiCount;
        else
            range.length = remainCount;
        pageView.emojiSignlePageModles = [emojiModles subarrayWithRange:range];
        [self.scroollView addSubview:pageView];
    }
    [self setNeedsLayout];
}

#pragma mark - lazy
- (UIScrollView *)scroollView
{
    if(_scroollView == nil)
    {
        _scroollView = [[UIScrollView alloc]init];
        _scroollView.pagingEnabled = YES;
        _scroollView.delegate = self;
        _scroollView.showsHorizontalScrollIndicator = NO;
        _scroollView.showsVerticalScrollIndicator = NO;
    }
    return _scroollView;
}

- (UIPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}
- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [[UIButton alloc] init];
        [_sendButton setImage:SIMEmojiKeyBoardBundleImage(@"btn_comment_expression_send") forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}


@end
