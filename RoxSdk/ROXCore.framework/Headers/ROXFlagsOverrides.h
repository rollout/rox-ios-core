//
//  ROXFlagsOverrides.h
//  ROX
//
//  Created by Hezi Cohen on 3/30/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXString.h"

@protocol ROXDeviceProperties;
@class ROXFeatureFlagsSetter;

@interface ROXFlagsOverrides : NSObject

- (instancetype)initWithFlagSetter:(ROXFeatureFlagsSetter*)setter deviceProperties:(id<ROXDeviceProperties>)deviceProperties;

- (BOOL)hasOverride:(NSString*)featureName;
- (NSString*)overrideForName:(NSString*)featureName;
- (void)clearOverrideForName:(NSString*)featureName;
- (void)clearOverrides;

- (void)setOverride:(NSString*)value forFeature:(ROXString*)rolloutFeature;
- (NSString*)originalValueForFeature:(ROXString*)feature;

@end
