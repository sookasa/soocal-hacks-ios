//
//  LFServerApi.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFServerApi.h"

@interface LFServerApi ()

@property (strong, atomic) NSString *BASE_URL_STRING;

@end


static LFServerApi *defaultApi;

@implementation LFServerApi

+(LFServerApi*)defaultApi
{
    if (!defaultApi)
    {
        defaultApi = [LFServerApi new];
    }
    return defaultApi;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.BASE_URL_STRING = @"https://t21f47cze5.execute-api.us-east-1.amazonaws.com/prod";
//        self.BASE_URL_STRING = @"http://lior.com";
    }
    
    return self;
}


-(BOOL)getTodaysOptionsWithDelegate:(id<LFServerApiDelegate>)delegate
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.BASE_URL_STRING, @"/v1/choices"]];
    
    [self makeHTTPRequest:url withMethod:@"GET" andValue:nil onCompletion:^(NSData *data, NSURLResponse *resp, NSError *err)
    {
        if (err)
        {
            [delegate getTodaysOptionsReturnedWithOptions:nil andError:err];
        }
        else
        {
            NSError *parsingError = nil;
            id optionsJSON = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:0
                         error:&parsingError];
            
            if (parsingError)
            {
                [delegate getTodaysOptionsReturnedWithOptions:nil andError:parsingError];
            }
            else
            {
                NSDictionary* optionsDict = (NSDictionary *)optionsJSON;
                NSArray* choices = [optionsDict objectForKey:@"choices"];
                
                NSMutableArray* options = [NSMutableArray new];
                for (NSDictionary* choice in choices) {
                    [options addObject:[[LFRestaurant alloc] initWithDictionary:choice]];
                }
                
                [delegate getTodaysOptionsReturnedWithOptions:options andError:nil];
            }
        }
    }];
    return YES;
}

-(BOOL)castVote:(LFVote*)vote withDelegate:(id<LFServerApiDelegate>)delegate
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.BASE_URL_STRING, @"/v1/votes"]];
    
    NSMutableDictionary * results = [NSMutableDictionary new];
    
//    [results setObject:nil forKey:@"date"];
    
    NSMutableArray *choicesForPosting = [NSMutableArray new];
    
    for (LFChoice *choice in [vote getChoices])
    {
        [choicesForPosting addObject:[choice getDictionary]];
    }
    
    [results setObject:vote.user.userEmail forKey:@"email"];
    [results setObject:choicesForPosting forKey:@"choices"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:results options:0 error:nil];
    NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self makeHTTPRequest:url withMethod:@"POST" andValue:value onCompletion:^(NSData *data, NSURLResponse *resp, NSError *err)
     {
         [delegate castVoteReturnedWithError:err];
     }];
    return YES;
}

-(BOOL)getResultsWithDelegate:(id<LFServerApiDelegate>)delegate
{
    return NO;
}

-(void)makeHTTPRequest:(NSURL*)url withMethod:(NSString*)method andValue:(NSString*)value
          onCompletion: (void (^)(NSData *, NSURLResponse *, NSError *))handler
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:url];
    
    [request setHTTPMethod:method];
    
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-type"];
    
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[value length]] forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:[value dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:handler] resume];
}

@end
