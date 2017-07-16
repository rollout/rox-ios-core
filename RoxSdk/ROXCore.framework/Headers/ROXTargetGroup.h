//
//  ROXTargetGroup.h
//  ROX
//
//  Created by Elad Cohen on 4/24/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class contains session data about a Target Group
 
 @see `ROXOptions.syncCompletionHandler`
 @see `ROXOMetadata`
 */

@interface ROXTargetGroup : NSObject
/**
 Target Group name
 */
@property (nonatomic, readonly) NSString* name;
/**
 Is device part of this target group
 */
@property (nonatomic, readonly) BOOL isEnabled;

/**
 :nodoc:
 */
-(instancetype)initWithName:(NSString*)name isEnabled:(BOOL)isEnabled;

@end
