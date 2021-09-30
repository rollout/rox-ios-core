//
//  ROXDynamicPropertiesRule.h
//  ROX
//
//  Created by Andrew Anisimov on 10.06.2021.
//  Copyright © 2021 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROXDynamicPropertyContext : NSObject<NSCopying>
-(instancetype)initWithValues:(NSDictionary* _Nonnull)values;
-(instancetype)initMerged:(ROXDynamicPropertyContext*  _Nonnull)globalContext localContext:(ROXDynamicPropertyContext*  _Nonnull)localContext;
-(NSObject* _Nullable)get:(NSString* _Nonnull)propName;
@end

typedef NSObject* _Nullable (^ROXDynamicPropertiesRule)(NSString* _Nonnull propName, ROXDynamicPropertyContext* _Nonnull context);
