//
//  SIMEmojiSinglePageView.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiSinglePageView.h"
#import "SIMEmojiButton.h"
#import "SIMEmojiKeyBoardHead.h"


#define SIMEmojiSignlePageView_Default_LeftRightInset 15  //左右间距
#define SIMEmojiSignlePageView_Default_TopBottomInset 10   //上下间距

@interface SIMEmojiSinglePageView ()
@property (nonatomic, strong) UIButton *deleteButton;  /** 删除按钮 */

@end

@implementation SIMEmojiSinglePageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self addSubview:self.deleteButton];
    }
    return self;
}

- (void)setEmojiSignlePageModles:(NSArray<SIMEmojiModel *> *)emojiSignlePageModles
{
    _emojiSignlePageModles = emojiSignlePageModles;
    NSInteger count = emojiSignlePageModles.count;
    for (NSInteger i = 0; i < count; i++)
    {
        SIMEmojiButton *emojiButton = [[SIMEmojiButton alloc]init];
        [self addSubview:emojiButton];
        emojiButton.model = emojiSignlePageModles[i];
        [emojiButton addTarget:self action:@selector(emojiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.emojiSignlePageModles.count;
    CGFloat emojiButtonW = (self.bounds.size.width - 2 *SIMEmojiSignlePageView_Default_LeftRightInset)/SIMEmojKeyBoardSignlePageView_Emjoi_MaxCol;
    CGFloat emojiButtonH = (self.bounds.size.height - 2 *SIMEmojiSignlePageView_Default_TopBottomInset)/SIMEmojKeyBoardSignlePageView_Emjoi_MaxRow;
    for (NSInteger i = 0; i < count; i++)
    {
        CGFloat emojiButtonX = SIMEmojiSignlePageView_Default_LeftRightInset + (i%SIMEmojKeyBoardSignlePageView_Emjoi_MaxCol)*emojiButtonW;
        CGFloat emojiButtonY = SIMEmojiSignlePageView_Default_TopBottomInset + (i/SIMEmojKeyBoardSignlePageView_Emjoi_MaxCol)*emojiButtonH;
        SIMEmojiButton *emojiButton = self.subviews[i + 1];  //第0个是删除按钮
        emojiButton.frame = CGRectMake(emojiButtonX, emojiButtonY, emojiButtonW, emojiButtonH);
    }
    SIMEmojiButton *lastEmojiButton = [self.subviews lastObject];
    //布局删除按钮
    CGFloat deleteButtonX = lastEmojiButton.frame.origin.x + lastEmojiButton.bounds.size.width;
    CGFloat deleteButtonY = lastEmojiButton.frame.origin.y;
    CGFloat deleteButtonW = emojiButtonW;
    CGFloat deleteButtonH = emojiButtonH;
    self.deleteButton.frame = CGRectMake(deleteButtonX, deleteButtonY, deleteButtonW, deleteButtonH);
    
    
}

#pragma mark - handle
- (void)deleteClick
{
    if(self.emojiDidDeleteBlock)
        self.emojiDidDeleteBlock();
}

- (void)emojiButtonClick:(SIMEmojiButton *)emojiButton
{
    if(self.emojiDidSelectBlock)
        self.emojiDidSelectBlock(emojiButton.model);
}

#pragma mark - lazy
- (UIButton *)deleteButton{
    if (_deleteButton == nil)
    {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:SIMEmojiKeyBoardBundleImage(@"compose_emotion_delete")forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
