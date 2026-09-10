//
//  ROXFetcherResult.h
//  ROX
//
//  Created by Elad Cohen on 12/11/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ROXFetcherStatus) {
    ROXFetcherStatus_appliedFromEmbedded = 1,
    ROXFetcherStatus_appliedFromLocalStorage = 2,
    ROXFetcherStatus_appliedFromNetwork = 3,
    ROXFetcherStatus_noUpdate = 4,
    ROXFetcherStatus_errorFetchFailed = 5
};

@interface ROXFetcherResult : NSObject

@property (nonatomic) ROXFetcherStatus fetcherStatus;
@property (nonatomic) NSDate* creationDate;
@property (nonatomic) NSString* errorDetails;
@property (nonatomic) BOOL hasChanges;

- (instancetype)initWithFetcherStatus:(ROXFetcherStatus)fetcherStatus creationDate:(NSDate*)creationDate errorDetails:(NSString*)errorDetails hasChanges:(BOOL)hasChanges;

@end
