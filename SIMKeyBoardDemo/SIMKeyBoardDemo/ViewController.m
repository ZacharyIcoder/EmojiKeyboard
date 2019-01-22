//
//  ViewController.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/17.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "ViewController.h"
#import "SIMEmojiKeyBoard.h"

@interface ViewController ()
@property (nonatomic, strong) SIMEmojiKeyBoard *emojiKeyBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.emojiKeyBoard];
    
}

- (IBAction)emojiButtonClick:(UIButton *)sender {
    [_emojiKeyBoard keyBoardBecomeFirstResponder];
}

-(SIMEmojiKeyBoard *)emojiKeyBoard {
    if (_emojiKeyBoard == nil) {
        _emojiKeyBoard = [[SIMEmojiKeyBoard alloc] initWithFrame:CGRectMake(0, SIMEmojKeyBoardUIScreenHeight-SIMEmojKeyBoardViewToolBarHeight-SIMEmojKeyBoardkBottomNOSafeArea_Height, SIMEmojKeyBoardUIScreenWidth, SIMEmojKeyBoardViewToolBarHeight)];
        [_emojiKeyBoard placeHolderText:@"请输入文字"];
        __weak typeof(self) weakSelf = self;
        _emojiKeyBoard.sendBlock = ^(NSString *text) {
            NSLog(@"发送的文本:%@",text);
            [weakSelf sendComment:text];
        };
        _emojiKeyBoard.keyboardYBlock = ^(CGFloat y) {
            NSLog(@"键盘.y :%lf",y);
        };
    }
    return _emojiKeyBoard;
}


-(void)sendComment:(NSString *)sendText {
    [_emojiKeyBoard endEdit];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_emojiKeyBoard endEdit];
}

@end
