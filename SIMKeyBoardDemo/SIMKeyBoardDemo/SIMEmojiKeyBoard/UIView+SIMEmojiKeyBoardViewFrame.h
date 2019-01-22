//
//  UIView+SIMEmojiKeyBoardViewFrame.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SIMEmojiKeyBoardViewFrame)
@property (nonatomic) CGFloat emojikey_x;
@property (nonatomic) CGFloat emojikey_y;
@property (nonatomic) CGFloat emojikey_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat emojikey_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat emojikey_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat emojikey_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat emojikey_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat emojikey_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat emojikey_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat emojikey_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint emojikey_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  emojikey_size;        ///< Shortcut for frame.size.

@end

NS_ASSUME_NONNULL_END
