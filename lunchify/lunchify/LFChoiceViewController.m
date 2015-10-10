//
//  LFChoiceViewController.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFChoiceViewController.h"
#import "LFRestaurant.h"

@interface LFChoiceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *      restaurantName;

@property (assign, atomic) unsigned int             currentIndex;

@end

@implementation LFChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentIndex = 0;
    
    [self populateCurrent];
}

-(void)populateCurrent
{
    if ([self.options count] > self.currentIndex)
    {
        LFRestaurant *rest = [self.options objectAtIndex:self.currentIndex];
        self.restaurantName.text = rest.name;
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
