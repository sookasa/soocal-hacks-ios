//
//  LFVoteManager.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFVoteManager.h"

@interface LFVoteManager ()

@property (strong, atomic) LFVote *                 currentVote;

@end

static LFVoteManager * defaultManager;

@implementation LFVoteManager


+(LFVoteManager*) defaultManager
{
    if (!defaultManager)
    {
        defaultManager = [LFVoteManager new];
    }
    return defaultManager;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.currentVote = [LFVote new];
    }
    
    return self;
}

-(LFVote*)getCurrentVote
{
    return self.currentVote;
}

-(BOOL)resetVote
{
    self.currentVote = nil;
    return YES;
}


@end
