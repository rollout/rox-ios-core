//
//  ROXVariant.h
//  ROX
//
//  Created by Elad Cohen on 6/28/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXFreeze.h"
/**
 :nodoc:
 */
@interface ROXVariant : NSObject
{
    NSString* _value;
    BOOL isFreezed;
}
NS_ASSUME_NONNULL_BEGIN
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) NSArray<NSString*>* options;


- (instancetype)initWithDefault:(NSString*)defaultValue options:(NSArray<NSString*>*)options;
- (instancetype)initWithDefault:(NSString*)defaultValue options:(NSArray<NSString*>*)options freeze:(ROXFreeze)freeze;


- (NSString*)value;
- (NSString*)defaultValue;
- (void)forceValue:(NSString*)value;
- (void)unfreeze;
- (NSString*)peek;

@end
NS_ASSUME_NONNULL_END
