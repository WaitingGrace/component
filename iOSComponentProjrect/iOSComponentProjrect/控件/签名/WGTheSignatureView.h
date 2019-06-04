//
//  WGTheSignatureView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SignatureBlock) (UIImage * image);
@interface WGTheSignatureView : UIView
@property (nonatomic ,strong) SignatureBlock signatureBlock;

@end
