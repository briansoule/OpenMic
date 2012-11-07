//
//  SubmitViewController.h
//  Critic
//
//  Created by Brian Soule on 11/5/12.
//  Copyright (c) 2012 Brian Soule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SubmitViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *urlTextField;
    IBOutlet UITextField *nameField;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *recordButton;
    IBOutlet UIButton *stopButton;
}

//@property (nonatomic, retain) IBOutlet UIButton *playButton;
//@property (nonatomic, retain) IBOutlet UIButton *recordButton;
//@property (nonatomic, retain) IBOutlet UIButton *stopButton;
- (IBAction) recordAudio;
- (IBAction) playAudio;
- (IBAction) stop;
- (IBAction) submitTapped:(id)sender;

@end
