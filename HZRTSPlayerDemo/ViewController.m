//
//  ViewController.m
//  HZRTSPlayerDemo
//
//  Created by 刘华舟 on 16/4/20.
//  Copyright © 2016年 khzliu. All rights reserved.
//

#import "ViewController.h"
#import "HZRTSPlayer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect playerSize = CGRectMake(0, 0, 320, 280);
    HZRTSPlayer * player = [[HZRTSPlayer alloc] initWithFrame:playerSize videoPath:@"rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov" useTcp:NO];
    
    player.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:player];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
