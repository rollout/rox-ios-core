//
//  ROXConfigurationBool.h
//  ROX
//
//  Created by Elad Cohen on 7/10/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <ROXCore/ROXCore.h>
#import "ROXRemoteVariable.h"

@interface ROXConfigurationBool : ROXRemoteVariable

@property (nonatomic, readonly) BOOL value;

- (_Nonnull instancetype)init __attribute__((deprecated("Default init function is not available")));
- (_Nonnull instancetype) initWithDefaultValue:(BOOL)defaultValue;

@end
