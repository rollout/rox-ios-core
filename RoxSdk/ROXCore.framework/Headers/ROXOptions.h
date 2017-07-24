//
// Created by Sergey Ilyevsky on 11/19/14.
// Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXProxyInfo.h"
#import "ROXMetadata.h"

/**
 :nodoc:
 */
typedef NSString * _Nonnull (^ROXProxy)(ROXProxyInfo* _Nonnull proxyInfo);
/**
 The Callback definition for `ROXOptions.syncCompletionHandler`
 */
typedef void (^ROXSyncCompletionHandler)(ROXMetadata* _Nonnull metadata);

/**
 The enum to define SDK verbosilty level 
 @see `ROXOptions.verbose`
 */
typedef enum ROXOptionsVerboseLevel{
    ///Silent log
    ROXOptionsVerboseLevelSilent,
    ///Verbsoe log
    ROXOptionsVerboseLevelDebug
} /** :nodoc: */ ROXOptionsVerboseLevel;

/**
 This is the configuration class that is used when running `+[ROXCore setupWithKey:options:]`.
 */
@interface ROXOptions : NSObject

/**
 :nodoc:
 */
@property (nonatomic, copy, nullable) ROXProxy proxy;
/**
 The completion handler that is called when the SDK has synced and applied the configuration
 
 
 ```objc
 ROXOptions *options = [[ROXOptions alloc] init];
 options.syncCompletionHandler = ^(ROXMetadata * _Nonnull metadata) {
    for (ROXTargetGroup *t in metadata.targetGroups){
        NSLog(@"%@:%@", t.name, t.isEnabled ? @"in" : @"out");
    }
    for (ROXFlag* f in metadata.flags) {
        NSLog(@"%@:%@", f.name, f.isEnabled ? @"in" : @"out");
    }
    for (ROXExperiment* e in metadata.experiments){
        NSLog(@"%@:%@", e.name, e.isEnabled ? @"enabled" : @"disbaled");
    }
 };
 [ROXCore setupWithKey:APP_KEY options:options];
```
 */
@property (nonatomic, copy, nullable) ROXSyncCompletionHandler syncCompletionHandler;
/**
 :nodoc:
 */
@property (nonatomic) BOOL disableSyncLoadingFallback;
/** 
 Set SDK verbosity level for debugging
 */
@property (nonatomic) ROXOptionsVerboseLevel verbose;
/**
 Setting this options to YES will prevent the SDK from handling and reporting crashed sessions.
 */
@property (nonatomic) BOOL disableCrashReporting;
/**
 :nodoc:
 */
@property (nonatomic, strong) NSArray * _Nullable silentFiles;
/**
 :nodoc:
 */
@property (nonatomic) BOOL roxDisabled;
/**
 :nodoc:
 */
@property (nonatomic, copy) NSString * _Nullable customSigningCertificate;
/**
 :nodoc:
 */
@property (nonatomic, copy) NSString * _Nullable defaultConfigurationPath;

@end

