//
// Created by Sergey Ilyevsky on 11/19/14.
// Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXFreeze.h"
#import "ROXFetcherResult.h"
#import "ROXReportingValue.h"
#import "ROXSelfManagedOptions.h"
#import "ROXDynamicPropertiesRule.h"

/**
 :nodoc:
 */

typedef void (^ROXConfigurationFetchedHandler)(ROXFetcherResult* _Nonnull result);
typedef void (^ROXImpressionHandler)(ROXReportingValue* _Nonnull value);

/**
 The enum to define SDK verbosilty level 
 @see `ROXOptions.verbose`
 */
typedef NS_ENUM (NSUInteger, ROXOptionsVerboseLevel){
    ///Silent log
    ROXOptionsVerboseLevelSilent,
    ///Verbsoe log
    ROXOptionsVerboseLevelDebug
} /** :nodoc: */;

/**
 This is the configuration class that is used when running `+[ROXCore setupWithKey:options:]`.
 */
@interface ROXOptions : NSObject

/**
 :nodoc:
 */
@property (nonatomic, copy, nullable) ROXConfigurationFetchedHandler onConfigurationFetched;

@property (nonatomic, copy, nullable) ROXImpressionHandler impressionHandler;

@property (nonatomic, copy, nullable) ROXDynamicPropertiesRule dynamicPropertiesRule;
/**
 :nodoc:
 */
@property (nonatomic) BOOL disableSyncLoadingFallback;
/** 
 Set SDK verbosity level for debugging
 */
@property (nonatomic) ROXOptionsVerboseLevel verbose;
/**
 :nodoc:
 */
@property (nonatomic, strong) NSArray * _Nullable silentFiles;
/**
 :nodoc:
 */
@property (nonatomic, copy) NSString * _Nullable customSigningCertificate;
/**
 :nodoc:
 */
@property (nonatomic, copy) NSString * _Nullable defaultConfigurationPath;

@property (nonatomic) ROXFreeze defaultFreezeLevel;

@property (nonatomic, copy, nullable) ROXSelfManagedOptions* selfManaged;

@end

