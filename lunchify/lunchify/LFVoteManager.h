//
//  LFVoteManager.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFVote.h"

@interface LFVoteManager : NSObject

+(LFVoteManager*) defaultManager;

-(LFVote*)getCurrentVote;

@end
