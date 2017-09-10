//
//  ROXMetadata.h
//  ROX
//
//  Created by Elad Cohen on 5/28/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ROXFlag;
@class ROXExperiment;
@class ROXTargetGroup;
@class ROXRemoteVariable;

/**
 This class cotains the state of the current session 
 @see `ROXOptions.syncCompletionHandler`
 */
@interface ROXMetadata : NSObject

/**
 an array the available experiemnts in this session
 */

@property (nonatomic, readonly) NSArray<ROXExperiment*>* experiments;
/**
 an array the available targetGroups in this session
 */

@property (nonatomic, readonly) NSArray<ROXTargetGroup*>* targetGroups;
/**
 an array the available remoteVariables in this session
 */
@property (nonatomic, readonly) NSArray<ROXRemoteVariable*>* remoteVariables;
/**
 :nodoc:
 */
-(instancetype)initWithExperiments:(NSArray<ROXExperiment*>*)experiments
                targetGroups:(NSArray<ROXTargetGroup*>*)targetGroups remoteVariables:(NSArray<ROXRemoteVariable*>*)remoteVariables;

@end
