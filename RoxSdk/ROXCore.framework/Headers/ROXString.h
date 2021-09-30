//
//  ROXString.h
//  ROX
//
//  Created by Elad Cohen on 6/28/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXFreeze.h"
#import "ROXDynamicPropertiesRule.h"
/**
 :nodoc:
 */
@interface ROXString : NSObject
{
    NSString* _value;
    BOOL isFreezed;
}
NS_ASSUME_NONNULL_BEGIN
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) NSArray<NSString*>* variations;

- (instancetype)initWithDefault:(NSString*)defaultValue;
- (instancetype)initWithDefault:(NSString*)defaultValue variations:(NSArray<NSString*>*)variations;
- (instancetype)initWithDefault:(NSString*)defaultValue variations:(NSArray<NSString*>*)variations freeze:(ROXFreeze)freeze;


- (NSString*)value;
- (NSString*)value:(ROXDynamicPropertyContext* _Nullable)context;
- (NSString*)defaultValue;
- (void)forceValue:(NSString*)value;
- (void)unfreeze;
- (NSString*)peek;

@end
NS_ASSUME_NONNULL_END
