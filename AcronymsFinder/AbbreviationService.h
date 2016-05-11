//
//  AbbreviationService.h
//  AcronymsFinder
//
//  Created by vikas voruganti on 5/10/16.
//  Copyright © 2016 vikas voruganti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Service_Success =1,
    Service_Failure = 2,
    Service_No_Data = 3
}Service_Status;


@interface AbbreviationService : NSObject

/**
 The method will return the Acronyms List
 
 @param input string whose Acronyms needs to be retreived
 */

-(void)getAbbreviationListForGivenWord:(NSString *)word completion:(void(^)(NSArray *abbreviationList, Service_Status status)) callBack andFailure:(void(^)(NSError *error, Service_Status status)) failure;

@end
