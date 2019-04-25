//
//  WGMoreImageVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGMoreImageVC.h"
#import "Config.h"
#import "WGImageItem.h"

@interface WGMoreImageVC ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
}
@property (nonatomic ,strong) UIView * photoView;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic ,strong) NSMutableArray <UIImage *> * imageArray;
@property (nonatomic ,strong) NSMutableArray * selectedAssets;
@property (nonatomic ,strong) UIImage * placeImage;//占位提示image
@property (nonatomic ,strong) UIImagePickerController *imagePickerVc;
@property (nonatomic ,strong) UILabel * numLabel;

@end

@implementation WGMoreImageVC

#pragma mark ---
#pragma mark --- 懒加载
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem * tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        UIBarButtonItem * BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.textColor = TitleColor;
        _numLabel.font = FONT(iPhone4_5?13:14);
    }
    return _numLabel;
}
- (UIView *)photoView{
    if (_photoView == nil) {
        _photoView = [[UIView alloc]init];
        _photoView.backgroundColor = BaiSe;
    }
    return _photoView;
}
#pragma mark ---
#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    self.placeImage = [UIImage imageNamed:@"ic_image_background"];
    self.imageArray = [NSMutableArray arrayWithObject:self.placeImage];
    self.selectedAssets = [NSMutableArray array];
    [self.view addSubview:self.photoView];

    [self setInitNineGridViewWith:[self.imageArray containsObject:self.placeImage]];
    
}

/**
 九宫格布局
 */
- (void)setInitNineGridViewWith:(BOOL)contains{
    if (contains) {
        self.numLabel.text = [NSString stringWithFormat:@"(%ld/9)",(long)self.imageArray.count-1];
    }else{
        self.numLabel.text = [NSString stringWithFormat:@"(%ld/9)",(long)self.imageArray.count];
    }
    [self.photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat itemW = (ScreenWidth - (10*2+32))/3;
    CGFloat itemH = itemW;
    CGFloat line = self.imageArray.count / 3 +(self.imageArray.count%3==0?0:1);//有多少行
    CGFloat viewH = line * (itemH+10) + 25;
    [self.photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(120);
        make.height.mas_equalTo(viewH);
    }];
    @WeakObj(self)
    for (int i = 0; i < self.imageArray.count; i++) {
        WGImageItem * item = [[WGImageItem alloc]init];
        item.image = self.imageArray[i];
        if (i == self.imageArray.count-1) {
            if (contains) {
                item.deleteImageStr = @"";
            }else{
                item.deleteImageStr = @"photo_delete";
            }
        }else{
            item.deleteImageStr = @"photo_delete";
        }
        item.deleteImage = ^{
            [selfWeak.imageArray removeObjectAtIndex:i];
            [selfWeak.selectedAssets removeObjectAtIndex:i];
            if (selfWeak.imageArray.count < 9 && ![selfWeak.imageArray containsObject:selfWeak.placeImage]) {
                [selfWeak.imageArray addObject:selfWeak.placeImage];
            }
            [selfWeak setInitNineGridViewWith:[selfWeak.imageArray containsObject:selfWeak.placeImage]];
        };
        item.addImage = ^{
            [selfWeak obtainPhotoWith:i];
        };
        [self.photoView addSubview:item];
        CGFloat lineN = i/3;
        CGFloat cloumN = i%3 ;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16+(itemW+10)*cloumN);
            make.top.mas_equalTo((10+itemH)*lineN+25);
            make.size.mas_equalTo(CGSizeMake(itemW, itemH));
        }];
    }
}
#pragma mark =================
#pragma mark ----------------- 图片选择
#pragma mark ---
#pragma mark --- TZImagePickerController
- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
    // 设置是否可以选择视频
    imagePickerVc.allowPickingVideo = NO;
    // 你可以通过block或者代理，来得到用户选择的照片.
    @WeakObj(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count == 9) {
            selfWeak.imageArray = [NSMutableArray arrayWithArray:photos];
        }else{
            [selfWeak.imageArray removeAllObjects];
            [selfWeak.imageArray addObjectsFromArray:photos];
            [selfWeak.imageArray addObject:selfWeak.placeImage];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限 做一个友好的提示
        [WGPromptBoxView popUpOptionPromptBoxWithTitle:@"无法使用相机" message:String(@"请在iPhone的""设置-隐私-相机""中允许访问相机") controllerStyle:UIAlertControllerStyleAlert action:@[@"设置"] style:@[@(UIAlertActionStyleDefault)] cancle:String(@"取消") cancleStyle:UIAlertActionStyleCancel block:^(NSInteger btnTag) {
            // 去设置界面，开启相机访问权限
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } cancleBlock:^{ }];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatusAuthorized] == NO) {// 已被拒绝，没有相册权限，将无法保存拍的照片
        [WGPromptBoxView popUpOptionPromptBoxWithTitle:@"无法访问相册" message:String(@"请在iPhone的""设置-隐私-相册""中允许访问相册") controllerStyle:UIAlertControllerStyleAlert action:@[@"设置"] style:@[@(UIAlertActionStyleDefault)] cancle:String(@"取消") cancleStyle:UIAlertActionStyleCancel block:^(NSInteger btnTag) {
            // 去设置界面，开启相机访问权限
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } cancleBlock:^{ }];
    } else {
        [self pushImagePickerController];
    }
}
// 调用相机
- (void)pushImagePickerController {
    @WeakObj(self)
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> * locations) {
        CLLocation * location = [locations firstObject];
        selfWeak.location = location;
    } failureBlock:^(NSError *error) {
        selfWeak.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self  presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error) {
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}
- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [self.selectedAssets addObject:asset];
    [self.imageArray insertObject:image atIndex:self.imageArray.count-1];
    
    [self setInitNineGridViewWith:[self.imageArray containsObject:self.placeImage]];
#if DEBUG
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
#endif
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark ----- TZImagePickerControllerDelegate
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    INFOWith(@"用户取消了选择");
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    if (photos.count == 9) {
        self.imageArray = [NSMutableArray arrayWithArray:photos];
    }else{
        [self.imageArray removeAllObjects];
        [self.imageArray addObjectsFromArray:photos];
        [self.imageArray addObject:self.placeImage];
    }
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [self setInitNineGridViewWith:[self.imageArray containsObject:self.placeImage]];
    
#if DEBUG
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
#endif
}
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    return YES;
    
}
- (BOOL)isAssetCanSelect:(id)asset {
    return YES;
    
}
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

#pragma mark ---
#pragma mark --- private methods
/**
 获取图片
 */
- (void)obtainPhotoWith:(NSInteger )idx{
    @WeakObj(self)
    if (idx == self.imageArray.count-1 && [self.imageArray containsObject:self.placeImage]) {
        [WGPromptBoxView popUpOptionPromptBoxWithTitle:nil message:nil controllerStyle:(UIAlertControllerStyleActionSheet) action:@[@"拍照",@"去相册选择"] style:@[@(UIAlertActionStyleDestructive),@(UIAlertActionStyleDefault)] cancle:@"取消" cancleStyle:(UIAlertActionStyleCancel) block:^(NSInteger btnTag) {
            if (btnTag == 0) {
                [selfWeak takePhoto];
            }else{
                [selfWeak pushTZImagePickerController];
            }
        } cancleBlock:^{
        }];
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.imageArray index:idx];
        imagePickerVc.maxImagesCount = 9;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (photos.count == 9) {
                selfWeak.imageArray = [NSMutableArray arrayWithArray:photos];
            }else{
                [selfWeak.imageArray removeAllObjects];
                [selfWeak.imageArray addObjectsFromArray:photos];
            }
            selfWeak.selectedAssets = [NSMutableArray arrayWithArray:assets];
            self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
            [selfWeak setInitNineGridViewWith:[selfWeak.imageArray containsObject:selfWeak.placeImage]];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
