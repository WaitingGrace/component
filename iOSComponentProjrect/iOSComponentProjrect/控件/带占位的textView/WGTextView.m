//
//  WGTextView.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/10/9.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGTextView.h"
#import "Config.h"

//这里是限制字数
#define MAX_WORD_LIMIT 800
@interface WGTextView ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation WGTextView

#pragma mark - --- 懒加载 —--
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.delegate = self;
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        topView.backgroundColor = [UIColor whiteColor];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                       UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                       UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:String(@"完成") style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
        [topView setItems:buttonsArray];
        [_textView setInputAccessoryView:topView];
    }
    
    return _textView;
}
- (UITextView *)placeholderTextView{
    if (!_placeholderTextView) {
        _placeholderTextView = [[UITextView alloc]init];
        _placeholderTextView.backgroundColor = [UIColor clearColor];
        _placeholderTextView.font = [UIFont systemFontOfSize:13];
        _placeholderTextView.textColor = [UIColor colorWithRed:133/255 green:136/255 blue:140/255 alpha:0.2];
    }
    return _placeholderTextView;
}

#pragma mark - --- 视图初始化 ---

+ (instancetype )placeholderTextView{
    //    init方法内部会自动调用initWithFrame:方法
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.placeholderTextView];
    [self addSubview:self.textView];
    
}
#pragma mark - --- delegate
//点击return 按钮 去掉
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/**
 * 这个方法专门用来布局子控件，一般在这里设置子控件的frame
 * 当控件本身的尺寸发生改变的时候，系统会自动调用这个方法
 *
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat textViewW = self.frame.size.width;
    CGFloat textViewH = self.frame.size.height;
    self.textView.frame = CGRectMake(0, 0, textViewW, textViewH );
    self.placeholderTextView.frame  = CGRectMake(0, 0, textViewW, textViewH );
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.textBlock) {
        self.textBlock(textView.text);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (text.length == 0 && range.location == 0) {
        self.placeholderTextView.hidden = NO;
    }else{
        self.placeholderTextView.hidden =YES;
    }
    return YES;
}

/*由于联想输入的时候，函数textView:shouldChangeTextInRange:replacementText:无法判断字数，
 因此使用textViewDidChange对TextView里面的字数进行判断
 */
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeholderTextView.hidden = NO;
    }else{
        self.placeholderTextView.hidden =YES;
    }
    //该判断用于联想输入
    if (textView.text.length > MAX_WORD_LIMIT){
        textView.text = [textView.text substringToIndex:MAX_WORD_LIMIT];
        INFOWith(@"当前输入文字已超出最大800字限制");
    }
    if (self.textBlock) {
        self.textBlock(textView.text);
    }
}

- (void)resignKeyboard{
    [self endEditing:YES];
}

@end
