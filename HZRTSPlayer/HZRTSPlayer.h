//
//  HZRTSPlayer.h
//  HZRTSPlayerDemo
//
//  Created by 刘华舟 on 16/4/21.
//  Copyright © 2016年 khzliu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTSPStreamer;

@interface HZRTSPlayer : UIView

@property (nonatomic, assign, readonly, getter=isPlaying) BOOL playing;

- (instancetype)initWithFrame:(CGRect)frame videoPath:(NSString *)src useTcp:(BOOL)tcp;

@end
