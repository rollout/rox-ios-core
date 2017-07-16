//
//  ROXRemoteVariable.h
//  ROX
//
//  Created by Gal Saada on 19/06/2017.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
    Base class for remote variables
 */
@interface ROXRemoteVariable : NSObject
/**
 The full name of the remote variable  (including namespace)
 */
@property(nonatomic, readonly) NSString *name;

@end
