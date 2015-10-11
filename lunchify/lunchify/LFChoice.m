//
//  LFChoice.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFChoice.h"


@interface LFChoice ()



@end

@implementation LFChoice

-(NSDictionary*)getDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary new];

    [dict setObject:[NSNumber numberWithBool:self.userFeedback] forKey:@"choice"];
    [dict setObject:self.restaurant.identifier forKey:@"id"];
    
    return dict;
}

@end
