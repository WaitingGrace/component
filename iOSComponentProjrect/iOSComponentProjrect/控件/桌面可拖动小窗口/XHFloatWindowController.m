//
//  XHFloatWindowController.m
//  XHFloatingWindow
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "XHFloatWindowController.h"
#import "XHDraggableButton.h"
#import "XHFloatWindowSingleton.h"
#define floatWindowSize 50

@interface XHFloatWindowController ()<UIDragButtonDelegate>

@property (strong,nonatomic) UIWindow *window;
@property (strong,nonatomic) XHDraggableButton *button;

@property (nonatomic, strong)UIImage * imageNormal;
@property (nonatomic, strong)UIImage * imageSelected;
@property (nonatomic, strong)UIButton * deleteBtn;

@end

@implementation XHFloatWindowController

- (UIButton *)deleteBtn{
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _deleteBtn.frame = CGRectMake(42, 5, 18, 18);
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"deleteFlowWindow"] forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self  action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // hide the root view
    self.view.frame = CGRectZero;
    // create floating window button
    [self createButton];
    // register UIDeviceOrientationDidChangeNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

/**
 * create floating window and button
 */
- (void)createButton
{
    // 1.floating button
    _button = [XHDraggableButton buttonWithType:UIButtonTypeCustom];
    [self resetBackgroundImage:@"default_normal" forState:UIControlStateNormal];
    [self resetBackgroundImage:@"default_selected" forState:UIControlStateSelected];
    _button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _button.frame = CGRectMake(10, 10, floatWindowSize, floatWindowSize);
    _button.buttonDelegate = self;
    _button.initOrientation = [UIApplication sharedApplication].statusBarOrientation;
    _button.originTransform = _button.transform;
    _button.imageView.alpha = 0.8;
    // 2.floating window
    _window = [[UIWindow alloc]init];
    _window.frame = CGRectMake(0, 200, floatWindowSize+20, floatWindowSize+20);
    _window.windowLevel = UIWindowLevelAlert+1;
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = (floatWindowSize+20)/2;
    _window.layer.masksToBounds = YES;
    [_window addSubview:_button];
    [_window addSubview:self.deleteBtn];
    [_window makeKeyAndVisible];
}
- (void)deleteBtnClick{
    [self setHideWindow:YES];
}
/**
 * set rootview
 */
- (void)setRootView {
    _button.rootView = self.view.superview;
}

/**
 *  floating button clicked
 */
- (void)dragButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:_imageSelected forState:UIControlStateSelected];
    }
    else {
        [sender setBackgroundImage:_imageNormal forState:UIControlStateNormal];
    }
    
    // click callback
    [XHFloatWindowSingleton Ins].floatWindowCallBack();
}

/**
 * reset window hiden
 */
- (void)setHideWindow:(BOOL)hide {
    _window.hidden = hide;
}

/**
 * reset floating window size
 */
- (void)setWindowSize:(float)size {
    CGRect rect = _window.frame;
    _window.frame = CGRectMake(rect.origin.x, rect.origin.y, size, size);
    _button.frame = CGRectMake(0, 0, size, size);
    [self.view setNeedsLayout];
}

/**
 * reset button background image
 */
- (void)resetBackgroundImage:(NSString *)imageName forState:(UIControlState)UIControlState {
    UIImage *image = [UIImage imageNamed:imageName];
    switch (UIControlState) {
        case UIControlStateNormal:
            _imageNormal = image;
            break;
        case UIControlStateSelected:
            _imageSelected = image;
            break;
            
        default:
            break;
    }
    [_button setBackgroundImage:image forState:UIControlState];
}

/**
 * notification
 */
- (void)orientationChange:(NSNotification *)notification {
    [_button buttonRotate];
}

@end
