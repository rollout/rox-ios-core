//
//  ROXReportingValue.h
//  ROX
//
//  Created by Elad Cohen on 7/31/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROXDynamicPropertiesRule.h"

/**
 This class contains data about values of an experiement
 
 @see `ROXOMetadata`
 */

@interface ROXReportingValue : NSObject

/**
 Name of the reporting
 */
@property (nonatomic, readonly) NSString* name;
/**
 Value of the reporting
 */
@property (nonatomic, readonly) NSString* value;

@property (nonatomic, readonly) ROXDynamicPropertyContext* context;
/**
 Whether the flag is active.
 */
@property (nonatomic, readonly) BOOL targeting;
/**
 :nodoc:
 */
- (instancetype)initWithName:(NSString*)name value:(NSString*)value targeting:(BOOL)targeting context:(ROXDynamicPropertyContext*) context;

@end
