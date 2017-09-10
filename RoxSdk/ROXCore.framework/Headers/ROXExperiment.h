//
//  ROXExperiment.h
//  ROX
//
//  Created by Elad Cohen on 4/24/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ROXReportingValue;

/**
 This class contains session data about an Experiment
 
 @see `ROXOptions.syncCompletionHandler`
 @see `ROXOMetadata`
 */
@interface ROXExperiment : NSObject

/**
 Experiment name
 */
@property (nonatomic, readonly) NSString* name;
/**
 Experiment unique indentifier
 */
@property (nonatomic, readonly) NSString* identifier;
/**
 Flags for this experiment
 */
@property (nonatomic, readonly) NSArray<ROXReportingValue*>* flags;
/**
 :nodoc:
 */
-(instancetype)initWithName:(NSString*)name flags:(NSArray<ROXReportingValue*>*)flags identifier:(NSString*)identifier;

@end
