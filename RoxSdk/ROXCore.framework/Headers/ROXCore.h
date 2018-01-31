//
//  ROXCore SDK version 2.0.1, Build 475
//
//  Copyright (c) 2017 rollout.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ROXOptions.h"
#import "ROXFlag.h"
#import "ROXConfigurationString.h"
#import "ROXConfigurationInt.h"
#import "ROXConfigurationDouble.h"
#import "ROXConfigurationBool.h"
#import "ROXBaseContainer.h"
#import "ROXVariant.h"
#import "ROXFreeze.h"
#import "ROXFetcherResult.h"
#import "ROXReportingValue.h"
#import "ROXExperiment.h"

#define ROX ROXCore

/**
 ROXCore class is a static objc class that acts as an facade interface
 - You use this flag for the following:
 
    - Intialize ROX SDK using `+setupWithKey:`
    - Register container instances using `+register:`
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
 Register a container instance to ROX system.
 - @param namespace The namespace to to register the container with (all flags / configuration will be prefixed with the namespace).
 - @param container The instance to register, this instance values are fetched at `+setupWithKey:`, or when the app goes into foreground.
 - @note This method should be called **only once** for a given namespace.
 */
+(void) register:(NSString *)namespace container:(ROXBaseContainer *)container;

+(void) handleNamespace:(NSString *)namespace;

/**
 Unfreeze the state of all flags in code
 
 When a flag is used in code, his value gets frozen in the app untill the next app foreground event. Calling this function will unfreeze all flags, and using a flag will return it's most updated value
 
 @see [Flags Consistency](https://support.rollout.io/docs/flags-consistency)
 
 */
+(void) unfreeze;
+(void) unfreezeNamespace:(NSString*)ns;

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
+(void) setCustomComputedStringProperty:(NSString* (^)(NSString*))block forKey:(NSString*)key;

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
+(void) setCustomComputedBooleanProperty:(BOOL (^)(NSString*))block forKey:(NSString*)key;

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
+(void) setCustomComputedIntProperty:(int (^)(NSString*))block forKey:(NSString*)key;

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
+(void) setCustomComputedDoubleProperty:(double (^)(NSString*))block forKey:(NSString*)key;

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
+(void) setCustomComputedSemverProperty:(NSString* (^)(NSString*))block forKey:(NSString*)key;

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
/**
 :nodoc:
 */
+(void)fetch;

#ifdef DEBUG
void resetROXDispatchOnce(void);
#endif

@end

