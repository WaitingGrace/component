//
//  WGAudioPlayerMgr.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const ykBirthdayMusicName = @"birthday.mp3";

@interface WGAudioPlayerMgr : NSObject

+ (WGAudioPlayerMgr *)sharedInstance;

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
- (BOOL)playMusic:(NSString *)filename isLoops:(BOOL)isLoops;

- (void)stopMusic:(NSString *)filename;

@end
