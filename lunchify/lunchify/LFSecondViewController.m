//
//  LFSecondViewController.m
//  lunchify
//
//  Created by Itay Bleier on 10/10/15.
//  Copyright (c) 2015 Sookasa. All rights reserved.
//

#import "LFSecondViewController.h"


@interface LFSecondViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;

@end

@implementation LFSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicator startAnimating];
    [self.errorLabel setHidden:YES];
    
    [self.restaurantName setHidden:YES];
    [[LFServerApi defaultApi] getResultsWithDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayError:(NSString*)text
{
    self.errorLabel.text = text;
    [self.errorLabel setHidden:NO];
}

-(void)displayChoice:(LFRestaurant*)restaurant
{
    self.restaurantName.text = restaurant.name;
    [self.restaurantName setHidden:NO];
}


#pragma mark - LFServerApiDelegate

- (void)getTodaysOptionsReturnedWithOptions:(NSArray *)options andError:(NSError *)err
{
}

- (void)getResultsReturnedWithResults:(NSArray *)results andError:(NSError *)err
{
    [self.activityIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    
    if(err) {
        NSString *errorText = [NSString stringWithFormat:@"Oy: %@", [err description]];
        [self performSelectorOnMainThread:@selector(displayError:) withObject:errorText waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(displayChoice:) withObject:[results objectAtIndex:0] waitUntilDone:NO];
    }
    
}

- (void)castVoteReturnedWithError:(NSError *)err
{
}

@end
