//
//  ROXBaseContainer.h
//  ROX
//
//  Created by Elad Cohen on 6/27/17.
//  Copyright © 2017 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A container class for configurations and flags
 
 Any class that inherits from this base class can be used as an entry point for flags and configurations that are controlled by ROX system. To use an instance of this class you need to register the instance using the `+[ROXCore register:]`
  method and retrieve the instance using `+[ROXCore get:]` method
 

 */

@interface ROXBaseContainer : NSObject

@end
