//
//  LFServerApi.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFVote.h"

@protocol LFServerApiDelegate <NSObject>

- (void)getTodaysOptionsReturnedWithOptions:(NSArray*)options andError:(NSError*)err;
- (void)castVoteReturnedWithError:(NSError*)err;
- (void)getResultsReturnedWithResults:(NSArray*)results andError:(NSError*)err;

@end


@interface LFServerApi : NSObject <NSURLConnectionDelegate>

-(BOOL)getTodaysOptionsWithDelegate:(id<LFServerApiDelegate>)delegate;
-(BOOL)castVote:(LFVote*)vote withDelegate:(id<LFServerApiDelegate>)delegate;
-(BOOL)getResultsWithDelegate:(id<LFServerApiDelegate>)delegate;

+(LFServerApi*)defaultApi;

@end
