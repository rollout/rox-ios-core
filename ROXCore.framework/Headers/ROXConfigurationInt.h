//
//  ROXConfigurationInt.h
//  ROX
//
//  Created by Elad Cohen on 7/10/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <ROXCore/ROXCore.h>
#import "ROXRemoteVariable.h"

@interface ROXConfigurationInt : ROXRemoteVariable

@property (nonatomic, readonly) int value;

- (_Nonnull instancetype)init __attribute__((deprecated("Default init function is not available")));
- (_Nonnull instancetype) initWithDefaultValue:(int)defaultValue;

@end
