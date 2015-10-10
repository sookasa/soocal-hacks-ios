//
//  LFVote.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFUser.h"
#import "LFChoice.h"

@interface LFVote : NSObject

- (BOOL)addChoice:(LFChoice*)choice;
- (NSArray*)getChoices;

@property (strong, atomic) LFUser*                          user;

@end
