//
//  ROXVariant.h
//  ROX
//
//  Created by Elad Cohen on 6/28/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 :nodoc:
 */
@interface ROXVariant : NSObject
{
    NSString* freezeValue;
    NSString* _value;
    BOOL isFreezed;
}

@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) NSArray<NSString*>* options;

- (instancetype)initWithDefault:(NSString*)defaultValue options:(NSArray<NSString*>*)options;
- (NSString*)value;
- (NSString*)defaultValue;
- (void)forceValue:(NSString*)value;

@end
