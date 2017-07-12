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

@interface ROXMetadata : NSObject

@property (nonatomic, readonly) NSArray<ROXFlag*>* flags;
@property (nonatomic, readonly) NSArray<ROXExperiment*>* experiments;
@property (nonatomic, readonly) NSArray<ROXTargetGroup*>* targetGroups;
@property (nonatomic, readonly) NSArray<ROXRemoteVariable*>* remoteVariables;

-(instancetype)initWithFlags:(NSArray<ROXFlag*>*)flags experiments:(NSArray<ROXExperiment*>*)experiments
                targetGroups:(NSArray<ROXTargetGroup*>*)targetGroups remoteVariables:(NSArray<ROXRemoteVariable*>*)remoteVariables;

@end
