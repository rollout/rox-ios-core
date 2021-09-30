//
//  ROXInt.h
//  ROX
//
//  Created by Elad Cohen on 23/12/2019.
//  Copyright © 2019 DeDoCo. All rights reserved.
//

#import <ROXCore/ROXCore.h>
#import "ROXDynamicPropertiesRule.h"

NS_ASSUME_NONNULL_BEGIN

@interface ROXInt : ROXString

/**
 Force a value on the flag. This will override any other value (Experiment, Flags View Controller, etc..), and can only be overriden with another call to forceValue:
 
 @param value to force the sdk with
 */

- (void)forceValue:(int)value;

- (int)value;

- (int)value:(ROXDynamicPropertyContext* _Nullable)context;

- (instancetype)initWithDefault:(int)defaultValue;

- (instancetype)initWithDefault:(int)defaultValue variations:(nonnull NSArray<NSNumber*> *)variations;

- (instancetype)initWithDefault:(int)defaultValue variations:(nonnull NSArray<NSNumber *> *)variations freeze:(ROXFreeze)freeze;

@end

NS_ASSUME_NONNULL_END
