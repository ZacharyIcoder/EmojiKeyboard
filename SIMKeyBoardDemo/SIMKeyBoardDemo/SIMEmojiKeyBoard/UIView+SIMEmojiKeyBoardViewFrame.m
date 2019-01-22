//
//  UIView+SIMEmojiKeyBoardViewFrame.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "UIView+SIMEmojiKeyBoardViewFrame.h"

@implementation UIView (SIMEmojiKeyBoardViewFrame)

-(CGFloat)emojikey_x {
    return self.frame.origin.x;
}

-(void)setEmojikey_x:(CGFloat)emojikey_x {
    CGRect frame=self.frame;
    frame.origin.x=emojikey_x;
    self.frame=frame;
}

-(CGFloat)emojikey_y {
    return self.frame.origin.y;
}

-(void)setEmojikey_y:(CGFloat)emojikey_y {
    CGRect frame=self.frame;
    frame.origin.y=emojikey_y;
    self.frame=frame;
}

-(CGFloat)emojikey_left {
    return self.frame.origin.x;
}

-(void)setEmojikey_left:(CGFloat)emojikey_left {
    CGRect frame = self.frame;
    frame.origin.x = emojikey_left;
    self.frame = frame;
}

-(CGFloat)emojikey_top {
    return self.frame.origin.y;
}

-(void)setEmojikey_top:(CGFloat)emojikey_top {
    CGRect frame = self.frame;
    frame.origin.y = emojikey_top;
    self.frame = frame;
}

-(CGFloat)emojikey_right {
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setEmojikey_right:(CGFloat)emojikey_right {
    CGRect frame = self.frame;
    frame.origin.x = emojikey_right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)emojikey_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setEmojikey_bottom:(CGFloat)emojikey_bottom {
    CGRect frame = self.frame;
    frame.origin.y = emojikey_bottom - frame.size.height;
    self.frame = frame;
}

-(CGFloat)emojikey_width {
    return self.frame.size.width;
}

-(void)setEmojikey_width:(CGFloat)emojikey_width {
    CGRect frame = self.frame;
    frame.size.width = emojikey_width;
    self.frame = frame;
}

-(CGFloat)emojikey_height {
    return self.frame.size.height;
}

-(void)setEmojikey_height:(CGFloat)emojikey_height {
    CGRect frame = self.frame;
    frame.size.height = emojikey_height;
    self.frame = frame;
}

-(CGFloat)emojikey_centerX {
    return self.center.x;
}

-(void)setEmojikey_centerX:(CGFloat)emojikey_centerX {
    self.center = CGPointMake(emojikey_centerX, self.center.y);
}

-(CGFloat)emojikey_centerY {
    return self.center.y;
}

-(void)setEmojikey_centerY:(CGFloat)emojikey_centerY {
    self.center = CGPointMake(self.center.x, emojikey_centerY);
}

-(CGPoint)emojikey_origin {
    return self.frame.origin;
}

-(void)setEmojikey_origin:(CGPoint)emojikey_origin {
    CGRect frame = self.frame;
    frame.origin = emojikey_origin;
    self.frame = frame;
}

-(CGSize)emojikey_size {
    return self.frame.size;
}

-(void)setEmojikey_size:(CGSize)emojikey_size {
    CGRect frame = self.frame;
    frame.size = emojikey_size;
    self.frame = frame;
}

@end
