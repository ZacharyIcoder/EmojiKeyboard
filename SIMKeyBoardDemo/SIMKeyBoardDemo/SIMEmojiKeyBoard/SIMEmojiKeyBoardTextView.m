//
//  SIMEmojiKeyBoardTextView.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiKeyBoardTextView.h"
#import "UIView+SIMEmojiKeyBoardViewFrame.h"
#import "SIMEmojiKeyBoardHead.h"

#define EmojiUIColorFromRGBA(rgbValue , a) [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:a]

@implementation SIMEmojiKeyBoardTextView

#pragma mark - 生命周期 方法
- (void)dealloc
{
    _placeholder = nil;
    _placeholderColor = nil;
    [self removeObserver:self forKeyPath:@"contentSize" context:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 根据输入框是否有内容 决定 发送按钮是否可以点击
    self.enablesReturnKeyAutomatically = YES;
    
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
    _placeholderColor = EmojiUIColorFromRGBA(0x000000, 0.3);
    self.font = [UIFont systemFontOfSize:SIMEmojKeyBoardFontValue];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    
    self.layoutManager.allowsNonContiguousLayout = NO;

}

#pragma mark - setter 方法
- (void)setPlaceholder:(NSString *)placeholder
{
    if ([placeholder isEqualToString:_placeholder])
    {
        return;
    }
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if ([placeholderColor isEqual:_placeholderColor])
    {
        return;
    }
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

#pragma mark - 重写 父类方法
- (UIResponder *)nextResponder
{
    return _responder ? _responder : [super nextResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (_responder)
    {
        return NO;
    }
    else
    {
        if (action == @selector(paste:))
        {
            return YES;
        }
        else
        {
            return [super canPerformAction:action withSender:sender];
        }
    }
}

//粘贴功能
- (void)paste:(id)sender
{
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    [self willChangeValueForKey:@"contentSize"];
    //    self.attributedText = [NSMutableAttributedString returnEmojiStrWithText:pasteboard.string];
    //appendAttributedString
    if (pasteboard.string.length == 0 || pasteboard.string == nil) {
        NSLog(@"********pasteboard为空********");
        return;
    }
    NSMutableAttributedString *pastStr =  [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
//    [pastStr appendAttributedString:[NSMutableAttributedString returnEmojiStrWithText:pasteboard.string]];
    [pastStr appendAttributedString:[[NSAttributedString alloc] initWithString:pasteboard.string]];
    
    // 2.添加属性
    [pastStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SIMEmojKeyBoardFontValue] range:NSMakeRange(0,pastStr.length)];
    self.attributedText = pastStr;
    self.font = [UIFont systemFontOfSize:SIMEmojKeyBoardFontValue];

    [self didChangeValueForKey:@"contentSize"];
    if ([self.textViewDelegate respondsToSelector:@selector(emojiKeyBoardtextView:past:)]) {
        [self.textViewDelegate emojiKeyBoardtextView:self past:pasteboard.string];
    }
}

- (void)setText:(NSString *)text
{
    BOOL scrollEnabled = self.scrollEnabled;
    [self setScrollEnabled:YES];
    [super setText:text];
    [self setScrollEnabled:scrollEnabled];
    [self setNeedsDisplay];
}

- (void)setScrollable:(BOOL)isScrollable
{
    [super setScrollEnabled:isScrollable];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

- (NSUInteger)numberOfLines
{
    NSUInteger lines = self.contentSize.height / self.font.lineHeight;
    return lines;
}

#pragma mark - 通知相关
- (void)textViewTextDidChangeNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        //NSLog(@"contentSize:%@",NSStringFromCGSize(self.contentSize));
        if ([self numberOfLines] > 4) {
            [self scrollRangeToVisible:NSMakeRange(self.text.length, 1)];
        }

        if ((([self numberOfLines] + 1 > self.lineNum) && (self.frame.size.height >= (self.lineNum * self.font.lineHeight))) || self.lineNum == 0)
        {
            return;
        }
        CGSize contentSize = self.contentSize;
        if (contentSize.height > (self.lineNum * self.font.lineHeight))
        {
            contentSize.height = self.lineNum * self.font.lineHeight;
        }
        if ([self.textViewDelegate respondsToSelector:@selector(emojiKeyBoardtextView:willChangeHeight:)])
        {
            [self.textViewDelegate emojiKeyBoardtextView:self willChangeHeight:contentSize.height];
        }
        self.emojikey_height = contentSize.height;
        if ([self.textViewDelegate respondsToSelector:@selector(emojiKeyBoardtextView:didChangeHeight:)])
        {
            [self.textViewDelegate emojiKeyBoardtextView:self didChangeHeight:contentSize.height];
        }
    }
}

#pragma mark - 绘制
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.text.length == 0 && self.placeholder)
    {
        CGRect placeHolderRect = CGRectMake(10, 7, rect.size.width, rect.size.height);
        [self.placeholderColor set];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = self.textAlignment;
        NSDictionary * dict = @{NSFontAttributeName : self.font , NSForegroundColorAttributeName : self.placeholderColor , NSParagraphStyleAttributeName : paragraphStyle};
        [self.placeholder drawInRect:placeHolderRect withAttributes:dict];
    }
}

@end
