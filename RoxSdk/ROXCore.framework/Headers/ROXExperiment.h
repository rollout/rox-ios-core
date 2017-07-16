//
//  ROXExperiment.h
//  ROX
//
//  Created by Elad Cohen on 4/24/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
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
 Experiment state
 */
@property (nonatomic, readonly) BOOL isEnabled;
/**
 Experiment unique indentifier
 */
@property (nonatomic, readonly) NSString* identifier;
/**
 :nodoc:
 */
-(instancetype)initWithName:(NSString*)name isEnabled:(BOOL)isEnabled identifier:(NSString*)identifier;

@end
