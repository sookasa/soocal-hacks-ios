//
//  LFChoiceViewController.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFChoiceViewController.h"
#import "LFRestaurant.h"
#import "LFVoteManager.h"


@interface LFChoiceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *      restaurantName;

@property (assign, atomic) unsigned int             currentIndex;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
@property (weak, nonatomic) IBOutlet UIImageView *restImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;
@property (weak, nonatomic) IBOutlet UILabel *uploadingLabel;

@end

@implementation LFChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentIndex = 0;
    
    [self.uploadingLabel setHidden:YES];
    
    [self populateCurrent];
}

-(void)populateCurrent
{
    [self resetPage];
    
    if ([self.options count] > self.currentIndex)
    {
        LFRestaurant *rest = [self.options objectAtIndex:self.currentIndex];
        self.restaurantName.text = rest.name;
        
        [self performSelectorInBackground:@selector(loadImage:) withObject:[NSURL URLWithString:rest.pictureUrl]];
    }
    else
    {
        [self.uploadingLabel setHidden:NO];
        [self.imageLoadingIndicator startAnimating];
        [[LFServerApi defaultApi] castVote:[[LFVoteManager defaultManager] getCurrentVote] withDelegate:self];
    }
    
}

-(void)resetPage
{
    self.restaurantName.text = @"";
    self.restImage.image = nil;
    
}

- (void)loadImage:(NSURL*)url
{
    [self.imageLoadingIndicator performSelectorOnMainThread:@selector(startAnimating) withObject:nil waitUntilDone:NO];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [self.restImage performSelectorOnMainThread:@selector(setImage:) withObject:img waitUntilDone:YES];
    [self.imageLoadingIndicator performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeChoice:(BOOL)feedback {
    LFChoice* currentChoice = [LFChoice new];
    currentChoice.restaurant = [self.options objectAtIndex:self.currentIndex];
    currentChoice.userFeedback = feedback;
    [[[LFVoteManager defaultManager] getCurrentVote] addChoice:currentChoice];
}

- (IBAction)rightSwipeHappened:(id)sender {
    [self makeChoice:YES];
    self.currentIndex++;
    [self populateCurrent];
    
}

- (IBAction)leftSwipeHappened:(id)sender {
    [self makeChoice:NO];
    self.currentIndex++;
    [self populateCurrent];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - LFServerApiDelegate

- (void)getTodaysOptionsReturnedWithOptions:(NSArray *)options andError:(NSError *)err
{
}

- (void)getResultsReturnedWithResults:(NSArray *)results andError:(NSError *)err
{
    
}

- (void)castVoteReturnedWithError:(NSError *)err
{
    if (err)
    {
        NSLog(@"CAST VOTE FAILED!!!!!");
    }
    [self performSelectorOnMainThread:@selector(dismiss) withObject:nil waitUntilDone:NO];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
