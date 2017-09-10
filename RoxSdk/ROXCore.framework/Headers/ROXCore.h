//
//  ROXCore SDK version 1.1.1, Build 450
//
//  Copyright (c) 2017 rollout.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ROXOptions.h"
#import "ROXFlag.h"
#import "ROXTargetGroup.h"
#import "ROXExperiment.h"
#import "ROXConfigurationString.h"
#import "ROXConfigurationInt.h"
#import "ROXConfigurationDouble.h"
#import "ROXConfigurationBool.h"
#import "ROXBaseContainer.h"
#import "ROXVariant.h"
#import "ROXReportingValue.h"

#define ROX ROXCore

/**
 ROXCore class is a static objc class that acts as an facade interface
 - You use this flag for the following:
 
    - Intialize ROX SDK using `+setupWithKey:`
    - Register container instances using `+register:`
    - Retrieve container instances using `+getContainer:`
    - Load custom properties with setCustomPropertyKey:value: methods
    - Present the flags view controller with `+flagsViewController`

 
 */
@interface ROXCore : NSObject
/**
 Loads the SDK, usually called as part of `-[AppDelegate application:didFinishLaunchingWithOptions:]`
 
 Checks if a cached experimentation container exists, and loads a container.
 
 Executes an async network call to fetch the experiment container from the ROX server and calculates experiments and target groups.
 
 @param roxKey The app key (taken from ROX dashboard)
 */
+(void)setupWithKey:(NSString *)roxKey;
/**
 Loads the SDK, usually called as part of `-[AppDelegate application:didFinishLaunchingWithOptions:]`
 
 Checks if a cached experimentation container exists, and loads a container.
 
 Executes an async network call to fetch the experiment container from the ROX server and calculates experiments and target groups.
 
 @param roxKey The app key (taken from ROX dashboard)
 @param options setup options
 */

+(void)setupWithKey:(NSString *)roxKey options:(ROXOptions *)options;
/**
 Register a container instance to ROX system, the same instance can be retrieved by using `+getContainer:` function
 
 - @params container The instance to register, this instance values are set at `+sync`, `+setupWithKey:`, or a if the app goes into foreground
 
 - @note this method should be called **only once** for a given class
 
 */
+(void) register:(ROXBaseContainer *)container;
/**
 :nodoc:
 */
+(void) registerClass:(NSObject*)container;

/**
 Retrieve an instance from type clazz that was registered with `ROX.register(_:)`
 
 @param  clazz The type of instance you want to retrieve
 @return The instance that was registered
 
 */

+(NSObject*) getContainer:(Class)clazz;

/**
 Recalculate the rules of experiments allocation base on new data
 
 
 @see `+unfreeze`
 
 @note Usually called after the user has logged in to refresh ROX custom properties
 @note  if a flag has already been used (had impression) is is freezed and the calculation will not change the flag state, to change the flag state you need to unfreeze the flag right after the sync call
 
 */

+(void) sync;
/**
 Unfreeze the state of all flags in code
 
 When a flag is used in code, his value gets frozen in the app untill the next app foreground event. Calling this function will unfreeze all flags, and using a flag will return it's most updated value
 
 @see [Flags Consistency](https://support.rollout.io/docs/flags-consistency)
 
 */

+(void) unfreeze;


/**
 A view to control feature flags values locally on a mobile device or simulator.
 
 ROX ViewController allows developers, QA or internal employees (depending on policy) to view, disable, enable and reset the state of their flags locally on the device. The functions return a view controller that can be loaded to the view hierarchy for test devices upon shake, or by triggering an existing debug view in the app.
 
 @see [How to setup flagsviewController](https://support.rollout.io/docs/flags-override-view)
 
 @return ViewController which shows the local feature flags and provides an interface to turn them on or off.
 
 
 */
+ (UIViewController*)flagsViewController;


/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */

+(void) setCustomStringProperty:(NSString*)value forKey:(NSString*)key;
/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */

+(void) setCustomComputedStringProperty:(NSString* (^)())block forKey:(NSString*)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */

+(void) setCustomBooleanProperty:(BOOL)value forKey:(NSString*)key;
/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedBooleanProperty:(BOOL (^)())block forKey:(NSString*)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */

+(void) setCustomIntProperty:(int)value forKey:(NSString*)key;
/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedIntProperty:(int (^)())block forKey:(NSString*)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */

+(void) setCustomDoubleProperty:(double)value forKey:(NSString*)key;
/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedDoubleProperty:(double (^)())block forKey:(NSString*)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */

+(void) setCustomSemverProperty:(NSString*)value forKey:(NSString*)key;
/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedSemverProperty:(NSString* (^)())block forKey:(NSString*)key;

/**
 :nodoc:
 */
+(void) setVariant:(ROXVariant*)variant forKey:(NSString*)key;
/**
 :nodoc:
 */
+(ROXVariant*) variantWithKey:(NSString*)key;
/**
 :nodoc:
 */
+(void) setRemoteVariable:(ROXRemoteVariable*)remoteVariable forKey:(NSString*)key;
/**
 :nodoc:
 */
+(ROXRemoteVariable*) remoteVariableWithKey:(NSString*)key;

/**
 Checks if device is a test device.
 
 Test device are managed by [App Settings](true if device is test device, false otherwise) in the dashboard
 
 @see [App Settings](true if device is test device, false otherwise)
 
 @return true if device is test device, false otherwise.
 */

+(BOOL)roxDisabled;

#ifdef DEBUG
void resetROXDispatchOnce(void);
#endif

@end

