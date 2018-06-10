//
//  ROXConfigurationString.h
//  ROX
//
//  Created by Elad Cohen on 7/10/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import "ROXRemoteVariable.h"
#import "ROXFreeze.h"
/**
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 */

@interface ROXConfigurationString : ROXRemoteVariable
NS_ASSUME_NONNULL_BEGIN
/**
 :nodoc:
 */

- (_Nonnull instancetype)init __attribute__((deprecated("Default init function is not available")));

/**
 Initiate the configuration with a defaultValue
 
 @param defaultValue value that is retrieve by `value` unless configured differently on ROX
 */

- (_Nonnull instancetype) initWithDefaultValue:(NSString* _Nonnull)defaultValue;

- (_Nonnull instancetype) initWithDefaultValue:(NSString* _Nonnull)defaultValue freeze:(ROXFreeze)freeze;

/**
 The BOOL value, if nothing is configured on ROX dashboard, the default value will be returned
 */

@property (nonatomic, readonly, nonnull) NSString* value;
NS_ASSUME_NONNULL_END

@end
