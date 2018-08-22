//
// Created by Sergey Ilyevsky on 11/01/2017.
// Copyright (c) 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 :nodoc:
 */
@interface ROXProxyInfo : NSObject

@property (readonly) NSString *originalURL;
@property (readonly) NSString *buid;
@property (readonly) NSString *distinctId;

- (instancetype)initWithOriginalURL:(NSString *)originalURL buid:(NSString *)buid distinctId:(NSString *)distinctId;

@end
