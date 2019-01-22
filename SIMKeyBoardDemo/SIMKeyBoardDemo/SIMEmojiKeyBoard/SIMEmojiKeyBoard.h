//
//  SIMEmojiKeyBoard.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMEmojiInputView.h"
#import "SIMEmojiKeyBoardHead.h"

typedef void(^EmojiTextSendBlock)(NSString *text);
typedef void(^EmojiKeyboardYBlock)(CGFloat y);

NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiKeyBoard : UIView<SIMEmojiInputViewDelegate>
@property (nonatomic, strong) SIMEmojiInputView   *inputView;

/**
 发送按钮block
 */
@property (nonatomic, copy)   EmojiTextSendBlock  sendBlock;

/**
 键盘.y block
 */
@property (nonatomic, copy)   EmojiKeyboardYBlock keyboardYBlock;

/**
 键盘设为第一响应
 */
- (void)keyBoardBecomeFirstResponder;

/**
 结束编辑 取消第一响应
 */
- (void)endEdit;

/**
 设置键盘的placeholder

 @param text text description
 */
- (void)placeHolderText:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
