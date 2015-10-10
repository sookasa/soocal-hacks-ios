//
//  LFRestaurant.m
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import "LFRestaurant.h"

@interface LFRestaurant()

@end

@implementation LFRestaurant

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.identifier = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.pictureUrl = [dict objectForKey:@"pictureUrl"];
        self.yelpUrl = [dict objectForKey:@"yelpUrl"];
        self.tags = [[dict objectForKey:@"tags"] copy];
    }
    return self;
}

@end
