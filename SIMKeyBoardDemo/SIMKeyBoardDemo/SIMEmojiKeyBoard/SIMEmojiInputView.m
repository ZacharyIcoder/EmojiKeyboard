//
//  SIMEmojiInputView.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiInputView.h"
#import "SIMEmojiKeyBoardHead.h"

@implementation SIMEmojiInputView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor =  [UIColor colorWithRed:240/255. green:240/255. blue:240/255. alpha:1];
    UIButton * emojiButton = [self createButtonWithNormalImageName:@"iocn_comment_expression" highlightedImageName:@"iocn_comment_expression" selectedImageName:@"iocn_comment_keyboard"];
    self.emojiButton = emojiButton;
    emojiButton.frame = CGRectMake(SIMEmojKeyBoardUIScreenWidth-8-SIMEmojKeyBoardButtonWidth, 3, SIMEmojKeyBoardButtonWidth, SIMEmojKeyBoardButtonHeight);
    emojiButton.tag = 1;
    [emojiButton addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emojiButton];
    
    // 输入框
    CGFloat textViewX      =  10;
    CGFloat textViewWidth  = CGRectGetMinX(emojiButton.frame) - 5 - textViewX;
    CGFloat textViewHeight = CGRectGetHeight(self.frame) - 2 * SIMEmojKeyBoardTextViewY;
    SIMEmojiKeyBoardTextView * textView  = [[SIMEmojiKeyBoardTextView alloc] initWithFrame:CGRectMake(textViewX, SIMEmojKeyBoardTextViewY, textViewWidth, textViewHeight)];
    self.textView = textView;
    textView.backgroundColor = [UIColor whiteColor];
    textView.font      = [UIFont systemFontOfSize:SIMEmojKeyBoardTextViewFont];
    textView.textColor = SIMEmojKeyBoardTextViewColor;
    textView.lineNum   = 5;
    textView.textViewDelegate    = self;
    textView.delegate            = self;
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius  = 5.0f;
    textView.returnKeyType = UIReturnKeySend;
    [self addSubview:textView];
}

- (void)buttonOnClick:(UIButton *)button {
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(didClickOnEmojiButtonWithSelected:)])
    {
        [self.delegate didClickOnEmojiButtonWithSelected:button.selected];
    }
}

#pragma mark - 协议 SIMEmojiKeyBoardTextViewDelegate
- (void)emojiKeyBoardtextView:(SIMEmojiKeyBoardTextView *)textView didChangeHeight:(CGFloat)height
{
    CGFloat currentHeight = height + SIMEmojKeyBoardTextViewY * 2;
    
    CGRect rect = self.frame;
    CGFloat changeHeight = (currentHeight - rect.size.height);
    rect.origin.y = rect.origin.y - changeHeight;
    rect.size.height = currentHeight;
    self.frame = rect;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputView:didChangeHeight:)])
    {
        [self.delegate inputView:self didChangeHeight:changeHeight];
    }
}

- (void)emojiKeyBoardtextView:(SIMEmojiKeyBoardTextView *)textView past:(NSString *)pastStr {
    
    if (![self isBlankWithStr:pastStr]) {
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(![textView hasText] && [text isEqualToString:@""])
    {
        return NO;
    }
    if ([text isEqualToString:@"\n"])
    {
        if (![self isBlankWithStr:textView.text])
        {
            if ([self.delegate respondsToSelector:@selector(didSendMesage:)]) {
                [self.delegate didSendMesage:textView.text];
            }
            
            textView.attributedText = nil;
            textView.text = nil;
        }
        return NO;
    }
    return YES;
}


- (BOOL)isBlankWithStr:(NSString *)str
{
    if (str == nil || str == NULL)
    {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    return NO;
}

- (UIButton *)createButtonWithNormalImageName:(NSString *)normalImageName
                         highlightedImageName:(NSString *)highlightedImageName
                            selectedImageName:(NSString *)selectedImageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[SIMEmojiKeyBoardBundleImage(normalImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setImage:[SIMEmojiKeyBoardBundleImage(highlightedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button setImage:[SIMEmojiKeyBoardBundleImage(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    return button;
}


@end
