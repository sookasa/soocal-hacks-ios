//
//  LFFirstViewController.m
//  lunchify
//
//  Created by Itay Bleier on 10/10/15.
//  Copyright (c) 2015 Sookasa. All rights reserved.
//

#import "LFFirstViewController.h"
#import "LFUser.h"
#import "LFVoteManager.h"
#import "LFChoiceViewController.h"

@interface LFFirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation LFFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicator setHidesWhenStopped:YES];
    
    [self.errorLabel setHidden:YES];
    
    [self.emailTextView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)participateClicked:(id)sender
{
    [self.activityIndicator startAnimating];
    
    LFUser *user = [LFUser new];
    user.userEmail = self.emailTextView.text;
    
    [[[LFVoteManager defaultManager] getCurrentVote] setUser:user];

    LFServerApi* api = [LFServerApi defaultApi];
    [api getTodaysOptionsWithDelegate:self];
}

-(void)displayError:(NSString*)text
{
    self.errorLabel.text = text;
    [self.errorLabel setHidden:NO];
}

-(void)openChoiceController:(NSArray*)options
{
    LFChoiceViewController *choiceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantVotingViewController"];
    
    choiceVC.options = options;
    
    [self presentViewController:choiceVC animated:YES completion:nil];
}

#pragma mark - LFServerApiDelegate

- (void)getTodaysOptionsReturnedWithOptions:(NSArray *)options andError:(NSError *)err
{
    [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];

    if(err) {
        NSString *errorText = [NSString stringWithFormat:@"Oy: %@", [err description]];
        [self performSelectorOnMainThread:@selector(displayError:) withObject:errorText waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(openChoiceController:) withObject:options waitUntilDone:NO];
    }
}

- (void)getResultsReturnedWithResults:(NSArray *)results andError:(NSError *)err
{
    
}

- (void)castVoteReturnedWithError:(NSError *)err
{
    
}

#pragma mark - UITextViewDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailTextView resignFirstResponder];
    return NO;
}

@end
