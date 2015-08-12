//
//  NowPlayingViewController.m
//  IronTunes
//
//  Created by John Holsapple on 8/12/15.
//  Copyright (c) 2015 John Holsapple -- The Iron Yard. All rights reserved.
//

#import "NowPlayingViewController.h"

@import AVFoundation;
@import MediaPlayer;

@interface NowPlayingViewController ()

@property (nonatomic) AVQueuePlayer *avQueuePlayer;

@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)playTapped:(UIButton *)sender;
- (IBAction)restartTapped:(UIButton *)sender;

@end

@implementation NowPlayingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAudioSession];
    
    self.avQueuePlayer = [[AVQueuePlayer alloc] init];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CannedHeat" ofType:@"mp3"]]];
    if (playerItem)
    {
        [self.avQueuePlayer insertItem:playerItem afterItem:nil];
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = @{MPMediaItemPropertyTitle:@"Canned Heat", MPMediaItemPropertyArtist:@"Jamiroquai"};
        self.artistLabel.text = @"Jamiroquai";
        self.songTitleLabel.text = @"Canned Heat";
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.avQueuePlayer rate] == 0.0)
    {
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        [self resignFirstResponder];
        [self.avQueuePlayer removeAllItems];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Handlers

- (IBAction)playTapped:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Pause"])
    {
        [self togglePlayback:NO];
    }
    else
    {
        [self togglePlayback:YES];
    }
}

- (IBAction)restartTapped:(UIButton *)sender
{
    [self.avQueuePlayer seekToTime:CMTimeMakeWithSeconds(0.0, 1)];
    if ([self.avQueuePlayer rate] == 0.0)
    {
        [self togglePlayback:YES];
    }
}

#pragma mark - Remote Control events

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl)
    {
        switch (event.subtype)
        {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if ([self.avQueuePlayer rate] > 0.0)
                {
                    [self togglePlayback:NO];
                }
                else
                {
                    [self togglePlayback:YES];
                }
                break;
            case UIEventSubtypeRemoteControlPlay:
                [self togglePlayback:YES];
                break;
            case UIEventSubtypeRemoteControlPause:
                [self togglePlayback:NO];
                break;
            default:
                break;
        }
    }
}

#pragma mark - Private

- (void)setupAudioSession
{
    NSError *categoryError = nil;
    // Singleton
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
    if (categoryError)
    {
        NSLog(@"Error setting category! %@", [categoryError localizedDescription]);
    }
    
    NSError *activationError = nil;
    BOOL success = [[AVAudioSession sharedInstance] setActive:YES error:&activationError];
    if (!success)
    {
        NSLog(@"Audio session could not be activated.");
        if (activationError)
        {
            NSLog(@"Session error: %@", [activationError localizedDescription]);
        }
    }
}

- (void)togglePlayback: (BOOL)play
{
    if (play)
    {
        [self.avQueuePlayer play];
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else
    {
        [self.avQueuePlayer pause];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
}

- (BOOL) canBecomeFirstResponder
{
    return YES;
}

@end
