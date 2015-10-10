//
//  LFRestaurant.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFRestaurant : NSObject

@property (strong, atomic) NSString* identifier;
@property (strong, atomic) NSString* name;
@property (strong, atomic) NSString* pictureUrl;
@property (strong, atomic) NSString* yelpUrl;
@property (strong, atomic) NSArray* tags;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
