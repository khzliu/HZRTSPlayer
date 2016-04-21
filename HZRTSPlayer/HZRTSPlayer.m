//
//  HZRTSPlayer.m
//  HZRTSPlayerDemo
//
//  Created by 刘华舟 on 16/4/21.
//  Copyright © 2016年 khzliu. All rights reserved.
//

#import "HZRTSPlayer.h"

#import "RTSPStreamer.h"

@interface HZRTSPlayer()

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) RTSPStreamer* streamer;

@property (nonatomic, strong) UIButton* playBtn;

@property (nonatomic, strong) NSTimer* nextFrameTimer;
@property (nonatomic, strong) NSString* srcPath;
@property (nonatomic, assign, getter=isTCP) BOOL tcp;

@end

@implementation HZRTSPlayer

- (instancetype)initWithFrame:(CGRect)frame videoPath:(NSString *)src useTcp:(BOOL)tcp
{
    if (self = [super initWithFrame:frame]) {
        _srcPath = src;
        _tcp = tcp;
        
        _streamer = [[RTSPStreamer alloc] initWithVideo:_srcPath usesTcp:_tcp];
        
        _streamer.outputWidth = self.bounds.size.width;
        _streamer.outputHeight = self.bounds.size.height;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [_imageView setContentMode:UIViewContentModeCenter];
        
        [self addSubview:_imageView];
        
        _playBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 60.0f)];
        _playBtn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(playBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playBtn];
    }
    return self;
}

- (BOOL)isPlaying{
    return _playBtn.isSelected;
}

- (void)playBtnOnClick:(UIButton* )playBtn
{
    playBtn.selected = !playBtn.selected;
    
    if (playBtn.isSelected) {
        // seek to 0.0 seconds
        [self.streamer seekTime:0.0];
        
        [_nextFrameTimer invalidate];
        self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                               target:self
                                                             selector:@selector(displayNextFrame:)
                                                             userInfo:nil
                                                              repeats:YES];
    }else{
        [_nextFrameTimer invalidate];
        [self.streamer closeAudio];
    }
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)

-(void)displayNextFrame:(NSTimer *)timer
{
    if (![self.streamer stepFrame]) {
        [timer invalidate];
        [self.playBtn setSelected:NO];
        [self.streamer closeAudio];
        return;
    }
    self.imageView.image = self.streamer.currentImage;
}
@end
