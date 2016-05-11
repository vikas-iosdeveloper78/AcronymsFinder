//
//  AbbreviationService.m
//  AcronymsFinder
//
//  Created by vikas voruganti on 5/10/16.
//  Copyright © 2016 vikas voruganti. All rights reserved.
//

#import "AbbreviationService.h"

#define abbreviationUrl @"http://www.nactem.ac.uk/software/acromine/dictionary.py"

@implementation AbbreviationService

-(void)getAbbreviationListForGivenWord:(NSString *)word completion:(void(^)(NSArray *abbreviationList, Service_Status status))callBack andFailure:(void(^)(NSError *error, Service_Status status))failure {
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?sf=%@",abbreviationUrl,word]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    failure(error, Service_Failure);
                } else {
                    NSError *err;
                    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&err];
                    
                    if (jsonArray.count != 0) {
                        callBack([self arrbreviationListFromJSONResponse:[jsonArray objectAtIndex:0]], Service_Success);
                    } else {
                        callBack(nil, Service_No_Data);
                    }
                    
                }
            });
        }];
        [dataTask resume];
    });
    
}

-(NSMutableArray *)arrbreviationListFromJSONResponse:(NSDictionary *)JSONDict {
    
    NSMutableArray *arrayList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in [JSONDict objectForKey:@"lfs"]) {
        [arrayList addObject:[dict objectForKey:@"lf"]];
    }
    
    return arrayList;
}

@end
