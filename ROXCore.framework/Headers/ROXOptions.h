//
// Created by Sergey Ilyevsky on 11/19/14.
// Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXProxyInfo.h"
#import "ROXMetadata.h"

typedef NSString * _Nonnull (^ROXProxy)(ROXProxyInfo* _Nonnull proxyInfo);
typedef void (^ROXSyncCompletionHandler)(ROXMetadata* _Nonnull metadata);

typedef enum {
    ROXOptionsVerboseLevelSilent,
    ROXOptionsVerboseLevelDebug
} ROXOptionsVerboseLevel;

@interface ROXOptions : NSObject

@property (nonatomic, copy, nullable) ROXProxy proxy;
@property (nonatomic, copy, nullable) ROXSyncCompletionHandler syncCompletionHandler;
@property (nonatomic) BOOL disableSyncLoadingFallback;
@property (nonatomic) ROXOptionsVerboseLevel verbose;
@property (nonatomic, strong) NSArray * _Nullable silentFiles;
@property (nonatomic) BOOL roxDisabled;
@property (nonatomic, copy) NSString * _Nullable customSigningCertificate;
@property (nonatomic, copy) NSString * _Nullable defaultConfigurationPath;

@end

