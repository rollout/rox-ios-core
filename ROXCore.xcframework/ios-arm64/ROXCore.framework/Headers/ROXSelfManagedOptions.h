//
//  ROXSelfManagedOptions.h
//  ROX
//
//  Created by asaf meir on 16/04/2020.
//  Copyright © 2020 DeDoCo. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ROXSelfManagedOptions : NSObject <NSCopying>

@property (nonatomic, copy) NSString * _Nullable serverURL;

@property (nonatomic, copy) NSString * _Nullable analyticsURL;

@end
