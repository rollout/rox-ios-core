//
//  ROXDynamicAPI.h
//  ROX
//
//  Created by Andrew Anisimov on 01.06.2021.
//  Copyright © 2021 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXDynamicPropertiesRule.h"

@class ROXFeatureFlagsRepository;

NS_ASSUME_NONNULL_BEGIN

@interface ROXDynamicAPI : NSObject

- (instancetype)initWith:(ROXFeatureFlagsRepository*)flagsRepository;

- (BOOL)isEnabled:(NSString*)name withDefault:(BOOL)defaultValue;
- (BOOL)isEnabled:(NSString*)name withDefault:(BOOL)defaultValue context:(ROXDynamicPropertyContext* _Nullable)context;

- (NSString*)getValue:(NSString*)name withDefault:(NSString*)defaultValue;
- (NSString*)getValue:(NSString*)name withDefault:(NSString*)defaultValue variations:(NSArray<NSString*>*)variations;
- (NSString*)getValue:(NSString*)name withDefault:(NSString*)defaultValue variations:(NSArray<NSString*>*)variations context:(ROXDynamicPropertyContext* _Nullable)context;

- (int)getInt:(NSString*)name withDefault:(int)defaultValue;
- (int)getInt:(NSString*)name withDefault:(int)defaultValue variations:(NSArray<NSNumber*>*)variations;
- (int)getInt:(NSString*)name withDefault:(int)defaultValue variations:(NSArray<NSNumber*>*)variations context:(ROXDynamicPropertyContext* _Nullable)context;

- (double)getDouble:(NSString*)name withDefault:(double)defaultValue;
- (double)getDouble:(NSString*)name withDefault:(double)defaultValue variations:(NSArray<NSNumber*>*)variations;
- (double)getDouble:(NSString*)name withDefault:(double)defaultValue variations:(NSArray<NSNumber*>*)variations context:(ROXDynamicPropertyContext* _Nullable)context;

@end

NS_ASSUME_NONNULL_END
