//
//  LFVote.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFVote.h"

@interface LFVote ()

@property (strong, atomic) NSMutableArray*                  choices;

@end

@implementation LFVote

-(id)init {
    if ( self = [super init] )
    {
        self.choices = [NSMutableArray new];
    }
    return self;
}

- (BOOL)addChoice:(LFChoice*)choice
{
    [self.choices addObject:choice];
    return YES;
}

- (NSArray*)getChoices
{
    return [self.choices copy];
}

@end
