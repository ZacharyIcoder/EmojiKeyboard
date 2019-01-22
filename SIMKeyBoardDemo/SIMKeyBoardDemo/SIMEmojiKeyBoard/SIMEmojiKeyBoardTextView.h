//
//  SIMEmojiKeyBoardTextView.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIMEmojiKeyBoardTextView;

@protocol SIMEmojiKeyBoardTextViewDelegate <NSObject>

@optional
- (void)emojiKeyBoardtextView:(SIMEmojiKeyBoardTextView *)textView willChangeHeight:(CGFloat)height;
- (void)emojiKeyBoardtextView:(SIMEmojiKeyBoardTextView *)textView didChangeHeight:(CGFloat)height;
- (void)emojiKeyBoardtextView:(SIMEmojiKeyBoardTextView *)textView past:(NSString *)pastStr;
@end

NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiKeyBoardTextView : UITextView
@property (nonatomic , weak) id<SIMEmojiKeyBoardTextViewDelegate> textViewDelegate;
@property (nonatomic , strong) UIResponder * responder;

// 占位符
@property (nonatomic , copy)   NSString    * placeholder;
// 占位符 颜色
@property (nonatomic , strong) UIColor     * placeholderColor;
// 自动增高行数
@property (nonatomic , assign) NSUInteger    lineNum;


@end

NS_ASSUME_NONNULL_END
