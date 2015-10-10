//
//  LFChoice.h
//  lunchify
//
//  Created by Lior Gavish on 10/10/15.
//  Copyright © 2015 Sookasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LFRestaurant.h"

@interface LFChoice : NSObject

@property (strong, atomic) LFRestaurant*                    restaurant;
@property (assign, atomic) BOOL                             userFeedback;

@end
