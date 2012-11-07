//
//  SubmitViewController.m
//  Critic
//
//  Created by Brian Soule on 11/5/12.
//  Copyright (c) 2012 Brian Soule. All rights reserved.
//

#import "SubmitViewController.h"
#import "ScoresViewController.h"

@interface SubmitViewController ()

@end

@implementation SubmitViewController

//@synthesize playButton, stopButton, recordButton;

-(void) recordAudio
{
    if (!audioRecorder.recording)
    {
        playButton.enabled = NO;
        [playButton setAlpha:0.5];
        stopButton.enabled = YES;
        [stopButton setAlpha:1.0];
        [audioRecorder record];
    }
}
-(void)stop
{
    stopButton.enabled = NO;
    [stopButton setAlpha:0.5];
    playButton.enabled = YES;
    [playButton setAlpha:1.0];
    recordButton.enabled = YES;
    [recordButton setAlpha:1.0];
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}
-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        stopButton.enabled = YES;
        [stopButton setAlpha:1.0];
        recordButton.enabled = NO;
        [recordButton setAlpha:0.5];

        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:audioRecorder.url
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    recordButton.enabled = YES;
    [recordButton setAlpha:1.0];
    stopButton.enabled = NO;
    [stopButton setAlpha:0.5];
}
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
}
-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

-(IBAction)submitTapped:(id)sender{
    NSLog(@"joke name :%@:", nameField.text);
    NSLog(@"joke name length :%u:", [nameField.text length]);

    if ([nameField.text length] <= 0) {
        [nameField becomeFirstResponder];
        nameField.hidden = NO;

    }
    else {
    
    }
}

-(void)sendJoke{
    //        ScoresViewController *scoresViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScoresViewIdentifier"];
    //        [[self navigationController] pushViewController:scoresViewController animated:YES];
    
    NSURL *url = [NSURL URLWithString:@"https://www.saygent.com/api/v2/recordings"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *requestBodyString = [NSString stringWithFormat:@"auth_token=THkpzDLy5Yopn2DpPmsg&attributes[]={'name':'%@','internal_id': '42'}&audio_file=%@", nameField.text, [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:audioRecorder.url] encoding:NSUTF8StringEncoding]];
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    if (responseData) {
        NSLog(@"No criteria submission errors");
    }
    
    if (!requestError) {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData //1
                              
                              options:kNilOptions
                              error:&requestError];
        
    }

}

- (BOOL)queryCriteriaURL{
    NSURL *url = [NSURL URLWithString:@"https://www.saygent.com/api/v2/criteria"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSArray *keys = [NSArray arrayWithObjects:@"funny", @"dangerous", @"insane", @"scientific", @"logical", nil];
    
    NSString *requestBodyString = [NSString stringWithFormat:@"auth_token=THkpzDLy5Yopn2DpPmsg&criteria[]=funny"];
    

    
    NSData *requestBody = [requestBodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:requestBody];
    NSURLResponse *response = NULL;
    NSError *requestError = NULL;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
    
    if (responseData) {
        NSLog(@"No criteria submission errors");
    }
//    if (!requestError) {
//        NSDictionary* json = [NSJSONSerialization
//                              JSONObjectWithData:responseData //1
//                              
//                              options:kNilOptions
//                              error:&requestError];
//        
//        NSString* token = [json objectForKey:@"token"];
//        NSLog(@"token: %@", token);
//        
//        if (token) {
//            NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
//            [data setObject:token forKey:@"authToken"];
//            [data synchronize];
//            
//            [UserData sharedInstance].authToken = token;
//            [[self delegate] authQueryFinished:YES];
//        }
//        else {
//            [[self delegate] authQueryFinished:NO];
//        }
//        
//        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"responseString: %@",responseString);
//    }
//    else {
//        //Error
//    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)textFieldWillBeginEditing:(UITextField *)textField {

    
//    CGRect frame = nameField.frame;
//    frame.origin.x = 20;
//    frame.origin.y = 326;
//    frame.size.width = 240;
//    //frame.size.height = newHeight;
//    nameField.frame = frame;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    nameField.hidden = YES;
    [self sendJoke];
//    CGRect frame = nameField.frame;
//    frame.origin.x = 21;
//    frame.origin.y = 21;
//    frame.size.width = 60;
//    //frame.size.height = newHeight;
//    nameField.frame = frame;
    
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    nameField.delegate = self;
    
    
    playButton.enabled = NO;
    [playButton setAlpha:0.5];
    stopButton.enabled = NO;
    [stopButton setAlpha:0.5];
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        
    } else {
        [audioRecorder prepareToRecord];
    }
    
    [self queryCriteriaURL];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
