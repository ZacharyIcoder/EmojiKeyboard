//
//  SIMEmojiInputView.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMEmojiKeyBoardTextView.h"

@class SIMEmojiInputView;

@protocol SIMEmojiInputViewDelegate <NSObject>
@optional
//表情按钮 被点击
- (void)didClickOnEmojiButtonWithSelected:(BOOL)selected;

/**
 *  视图高度动态改变
 *
 *  @param inputFunctionView 视图本身
 *  @param height            改变后的高度
 */
- (void)inputView:(SIMEmojiInputView *)inputFunctionView didChangeHeight:(CGFloat)height;

/**
 *  发送消息内容
 *
 *  @param message 输入框内容
 */
- (void)didSendMesage:(NSString *)message;

@end


NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiInputView : UIView<SIMEmojiKeyBoardTextViewDelegate , UITextViewDelegate>
// 表情按钮
@property (nonatomic , strong) UIButton * emojiButton;

@property (nonatomic , strong) SIMEmojiKeyBoardTextView *textView;

@property (nonatomic, assign) id<SIMEmojiInputViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
