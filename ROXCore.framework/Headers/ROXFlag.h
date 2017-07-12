//
//  ROXFlag.h
//  ROX
//
//  Created by Elad Cohen on 3/19/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXVariant.h"

@interface ROXFlag : ROXVariant

@property (readonly, nonatomic) BOOL isEnabled;

- (void)enabled:(void (^)(void))codeBlock;
- (void)disabled:(void (^)(void))codeBlock;
- (void)enabled:(void (^)(void))enabledCodeBlock disabled:(void (^)(void))disabledCodeBlock;

@end
