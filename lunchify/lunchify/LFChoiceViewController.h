//
//  LFChoiceViewController.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFServerApi.h"

@interface LFChoiceViewController : UIViewController <LFServerApiDelegate>

@property (strong, atomic) NSArray *                options;

@end
