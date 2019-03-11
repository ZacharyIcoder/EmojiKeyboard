//
//  SIMEmojiKeyBoard.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiKeyBoard.h"

#import "SIMEmojiKeyBoardTextView.h"
#import "SIMEmojiView.h"
#import "NSString+SIMEmojiKeyBoardTranscoding.h"
#import "UIView+SIMEmojiKeyBoardViewFrame.h"

@interface SIMEmojiKeyBoard ()
@property (nonatomic , strong) SIMEmojiView *faceView;
@property (nonatomic , assign) BOOL         isEmojiSelect;
@end

@implementation SIMEmojiKeyBoard

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.inputView];
    [self addSubview:self.faceView];
    
    self.isEmojiSelect = NO;
    self.faceView.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.faceView setEmojiModles:[self loadEmojiEmotions] selectEmojiModelBlock:^(SIMEmojiModel *selectModel) {
        [weakSelf emojitionDidSelect:selectModel];
    } deleteBlcok:^{
        [weakSelf emojitionDidDelete];
    } sendBlcok:^{
        [weakSelf emojitionDidSend];
    }];
    
    // 注册键盘尺寸监听的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillHideNotification object:nil];
}


// 监听键盘弹出事件
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification
{
    NSDictionary * userInfoDict = notification.userInfo;
    //    CGRect beginRect = [[userInfoDict objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect rect = [userInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [userInfoDict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification])
    {
        // 记录键盘弹出的高度
        [self inputFunctionViewAutoChangeWithRect:rect inputFunctionViewRect:self.inputView.frame duration:duration state:SIMEmojiKeyBoardShowViewStateKeyBoard];
        self.inputView.emojiButton.selected = NO;
        self.isEmojiSelect = NO;
    }
    else if([notification.name isEqualToString:UIKeyboardWillHideNotification])
    {
        if (!self.isEmojiSelect) {
            [self inputFunctionViewAutoChangeWithRect:CGRectZero inputFunctionViewRect:self.inputView.frame duration:duration state:SIMEmojiKeyBoardShowViewStateKeyBoard];
        }
    }
}

#pragma mark - 动画弹出视图
// 动画弹出视图（通过修改坐标）
- (void)inputFunctionViewAutoChangeWithRect:(CGRect)rect
                      inputFunctionViewRect:(CGRect)inputFunctionViewRect
                                   duration:(NSTimeInterval)duration
                                      state:(SIMEmojiKeyBoardShowViewState)state
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        CGFloat Y;
        Y = SIMEmojKeyBoardUIScreenHeight - CGRectGetHeight(rect) - CGRectGetHeight(inputFunctionViewRect);
        if (SIMEmojKeyBoardiPhoneX && rect.size.height == 0) {
            Y = SIMEmojKeyBoardUIScreenHeight - CGRectGetHeight(rect) - CGRectGetHeight(inputFunctionViewRect)-SIMEmojKeyBoardkBottomNOSafeArea_Height;
        }
        if (rect.size.height == 0) {
            weakSelf.faceView.hidden = YES;
        }
        else {
            weakSelf.faceView.hidden = NO;
        }
        weakSelf.frame = CGRectMake(0, Y, SIMEmojKeyBoardUIScreenWidth, SIMEmojKeyBoardViewHeight+SIMEmojKeyBoardViewToolBarHeight);
        weakSelf.inputView.emojikey_y = 0;
        if (weakSelf.keyboardYBlock) {
            weakSelf.keyboardYBlock(Y);
        }
        
        switch (state)
        {
            case SIMEmojiKeyBoardShowViewStateKeyBoard:
            {
                weakSelf.faceView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.inputView.frame), CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.faceView.frame));
            }
                break;
                
            case SIMEmojiKeyBoardShowViewStateEmojiFace:
            {
                weakSelf.faceView.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.inputView.frame), CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.faceView.frame));
                weakSelf.faceView.hidden = NO;
            }
                break;
            default:
                break;
        }
        
    } completion:^(BOOL finished) {
    }];
}

- (void)placeHolderText:(NSString *)text {
    self.inputView.textView.placeholder = text;
}

- (void)emojitionDidSelect:(SIMEmojiModel *)emojiModel
{
    self.inputView.textView.text = [self.inputView.textView.text stringByAppendingString:emojiModel.code.simemojikeyboardEmoji];
    [self textDidChange];
}

- (void)emojitionDidDelete
{
    [self.inputView.textView deleteBackward];
}

- (void)emojitionDidSend
{
    NSString *text = self.inputView.textView.text;
    if(self.sendBlock)
        self.sendBlock(text);
    [self resetInputView];
    [self textDidChange];
}

-(void)didSendMesage:(NSString *)message {
    if (self.sendBlock) {
        self.sendBlock(message);
    }
}

- (void)textDidChange {
    if([self.inputView.textView.text containsString:@"\n"])
    {
        [self emojitionDidSend];
        return;
    }
    [self setNeedsLayout];
}

- (void)resetInputView
{
    self.inputView.textView.text = @"";
    [self.inputView.textView resignFirstResponder];
    if(self.inputView.emojiButton.selected)
    {
        self.inputView.emojiButton.selected = !self.inputView.emojiButton.isSelected;
    }
    //布局的目的是布局textContainer 显示区域,显示区域回到初始位置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
}


-(void)inputView:(SIMEmojiInputView *)inputFunctionView didChangeHeight:(CGFloat)height {
    self.emojikey_y -= height;
}


-(void)didClickOnEmojiButtonWithSelected:(BOOL)selected {
    if (selected)
    {
        self.isEmojiSelect = YES;
        [self.inputView.textView resignFirstResponder];
        [self inputFunctionViewAutoChangeWithRect:self.faceView.frame inputFunctionViewRect:self.inputView.frame duration:0.2 state:SIMEmojiKeyBoardShowViewStateEmojiFace];
    }
    else
    {
        self.isEmojiSelect = NO;
        [self.inputView.textView becomeFirstResponder];
    }
}

- (void)keyBoardBecomeFirstResponder {
    self.hidden = NO;
    self.isEmojiSelect = NO;
    [self.inputView.textView becomeFirstResponder];
    
}

- (void)endEdit {
    self.hidden = YES;
    self.isEmojiSelect = NO;
    [self.inputView.textView resignFirstResponder];
    [self.inputView.textView endEditing:YES];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _inputView.emojikey_y = 0;
    _faceView.emojikey_y =  CGRectGetMaxY(_inputView.frame);
}

-(SIMEmojiInputView *)inputView {
    if (_inputView == nil) {
        _inputView = [[SIMEmojiInputView alloc] initWithFrame:CGRectMake(0, 0, SIMEmojKeyBoardUIScreenWidth, 50)];
        _inputView.delegate = self;
    }
    return _inputView;
}

- (NSArray <SIMEmojiModel *>*)loadEmojiEmotions{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SIMEmojiKeyboardBundle.bundle/emoji.plist" ofType:nil];
    NSArray *emotions = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *emotionsMul = [NSMutableArray array];
    for (NSDictionary *dic in emotions) {
        SIMEmojiModel *model = [[SIMEmojiModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [emotionsMul addObject:model];
    }
    return emotionsMul.copy;
}

- (SIMEmojiView *)faceView
{
    if(_faceView == nil)
    {
        _faceView = [[SIMEmojiView alloc] init];
        _faceView.backgroundColor = SIMEmojKeyBoardColorRGB(240, 240, 240);
        _faceView.frame = CGRectMake(0, 0, SIMEmojKeyBoardUIScreenWidth, SIMEmojKeyBoardViewHeight+SIMEmojKeyBoardkBottomNOSafeArea_Height);
    }
    return _faceView;
}


@end
