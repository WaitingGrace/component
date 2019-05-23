//
//  WGActionSheet.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGActionSheetDelegate;
@interface WGActionSheet : UIView <UIAppearanceContainer>

- (instancetype)initWithDelegate:(id<WGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property(nonatomic,assign) id<WGActionSheetDelegate> delegate;    // weak reference

// adds a button with the title. returns the index (0 based) of where it was added. buttons are displayed in the order added except for the
// destructive and cancel button which will be positioned based on HI requirements. buttons cannot be customized.
- (NSInteger)addButtonWithTitle:(NSString *)title;    // returns index of button. 0 based.
- (NSInteger)addButtonWithTitle:(NSString *)title actionBlock:(void (^)(void))actionBlock;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;
- (NSInteger)addButtonWithTitle:(NSString *)title actionColor:(UIColor *)actionColor;

@property(nonatomic,readonly) NSInteger numberOfButtons;

@property(nonatomic,readonly,getter=isVisible) BOOL visible;
@property(nonatomic) CGFloat blurRadius UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *blurTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, strong) UIColor *highlightedButtonColor UI_APPEARANCE_SELECTOR;

@property(nonatomic, readonly) NSInteger cancelButtonIndex;
@property(nonatomic, readonly) NSInteger destructiveButtonIndex;

// show a sheet animated.
- (void)show;

- (NSDictionary *)buttonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (NSDictionary *)cancelButtonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setCancelButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (NSDictionary *)destructiveButtonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setDestructiveButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;


// hides alert sheet or popup. use this method when you need to explicitly dismiss the alert.
// it does not need to be called if the user presses on a button
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end

@protocol WGActionSheetDelegate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(WGActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(WGActionSheet *)actionSheet;

- (void)willPresentActionSheet:(WGActionSheet *)actionSheet;  // before animation and showing view
- (void)didPresentActionSheet:(WGActionSheet *)actionSheet;  // after animation

- (void)actionSheet:(WGActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)actionSheet:(WGActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end
