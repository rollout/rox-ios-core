//
//  ROXCore SDK version 5.0.3, Build 560
//
//  Copyright (c) 2017 rollout.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ROXOptions.h"
#import "ROXFlag.h"
#import "ROXInt.h"
#import "ROXDouble.h"
#import "ROXBaseContainer.h"
#import "ROXString.h"
#import "ROXFreeze.h"
#import "ROXFetcherResult.h"
#import "ROXReportingValue.h"
#import "ROXFlagsOverrides.h"
#import "ROXErrorHandling.h"
#import "ROXDynamicAPI.h"
#import "ROXDynamicPropertiesRule.h"

#define ROX ROXCore

typedef NS_ENUM(NSUInteger, ROXCoreState) {
    ROXCoreState_Idle = 0,
    ROXCoreState_SettingUp,
    ROXCoreState_Set,
    ROXCoreState_ShuttingDown,
    ROXCoreState_Corrupted
};

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
+(void)setupWithKey:(NSString* _Nonnull)roxKey;

/**
 Loads the SDK, usually called as part of `-[AppDelegate application:didFinishLaunchingWithOptions:]`
 
 Checks if a cached experimentation container exists, and loads a container.
 
 Executes an async network call to fetch the experiment container from the ROX server and calculates experiments and target groups.
 
 @param roxKey The app key (taken from ROX dashboard)
 @param options setup options
 */
+(void)setupWithKey:(NSString * _Nonnull)roxKey options:(ROXOptions * _Nonnull)options;

+(void)setupWithKey:(NSString * _Nonnull)roxKey options:(ROXOptions * _Nonnull)options platformVersion:(NSString* _Nullable)platformVersion languageVersion:(NSString* _Nullable)languageVersion;

+(ROXCoreState)state;

+(void)shutdown;

/**
 Register a container instance to ROX system.
 - @param namespace The namespace to to register the container with (all flags / configuration will be prefixed with the namespace).
 - @param container The instance to register, this instance values are fetched at `+setupWithKey:`, or when the app goes into foreground.
 - @note This method should be called **only once** for a given namespace.
 */
+(void) register:(NSString * _Nonnull)namespace container:(ROXBaseContainer * _Nonnull)container;

/**
  Register a container in the default namespace.
 */
+(void) register:(ROXBaseContainer * _Nonnull)container;

+(void) handleNamespace:(NSString * _Nonnull)namespace;

/**
 Unfreeze the state of all flags in code
 
 When a flag is used in code, his value gets frozen in the app untill the next app foreground event. Calling this function will unfreeze all flags, and using a flag will return it's most updated value
 
 @see [Flags Consistency](https://support.rollout.io/docs/flags-consistency)
 
 */
+(void) unfreeze;
+(void) unfreezeNamespace:(NSString* _Nonnull)ns;

/**
 A view to control feature flags values locally on a mobile device or simulator.
 
 ROX ViewController allows developers, QA or internal employees (depending on policy) to view, disable, enable and reset the state of their flags locally on the device. The functions return a view controller that can be loaded to the view hierarchy for test devices upon shake, or by triggering an existing debug view in the app.
 
 @see [How to setup flagsviewController](https://support.rollout.io/docs/flags-override-view)
 
 @return ViewController which shows the local feature flags and provides an interface to turn them on or off.
 */
+ (UIViewController* _Nonnull)flagsViewController;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */
+(void) setCustomStringProperty:(NSString* _Nonnull)value forKey:(NSString* _Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedStringProperty:(NSString* _Nullable (^_Nonnull)(NSString* _Nonnull, ROXDynamicPropertyContext* _Nonnull))block forKey:(NSString* _Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */
+(void) setCustomBooleanProperty:(BOOL)value forKey:(NSString*_Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedBooleanProperty:(BOOL (^_Nullable)(NSString* _Nullable, ROXDynamicPropertyContext* _Nonnull))block forKey:(NSString*_Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */
+(void) setCustomIntProperty:(int)value forKey:(NSString* _Nullable)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedIntProperty:(int (^_Nonnull)(NSString* _Nonnull, ROXDynamicPropertyContext* _Nonnull))block forKey:(NSString*_Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */
+(void) setCustomDoubleProperty:(double)value forKey:(NSString* _Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedDoubleProperty:(double (^_Nonnull)(NSString* _Nonnull, ROXDynamicPropertyContext* _Nonnull))block forKey:(NSString*_Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key The name of the custom property
 @param value The value of the custom property
 
 */
+(void) setCustomSemverProperty:(NSString*_Nonnull)value forKey:(NSString* _Nonnull)key;

/**
 Sets a custom property value that can be used when creating target groups.
 
 @see [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
 
 @param key  The name of the custom property
 @param block this block will get invoked when trying to evaluate the value of the property
 
 */
+(void) setCustomComputedSemverProperty:(NSString* _Nullable (^_Nonnull)(NSString* _Nonnull, ROXDynamicPropertyContext* _Nonnull))block forKey:(NSString*_Nonnull)key;

/**
  Sets a dynamic property context that will be used as a default for each flag evaluation.
 */
+(void) setGlobalDynamicPropertyContext:(ROXDynamicPropertyContext* _Nullable)context;

/**
 :nodoc:
 */
+(void) setVariant:(ROXString*_Nonnull)variant forKey:(NSString*_Nonnull)key;
/**
 :nodoc:
 */
+(ROXString*_Nullable) variantWithKey:(NSString*_Nonnull)key;

/**
 :nodoc:
 */
+(void)fetch;

+ (ROXFlagsOverrides*_Nonnull)overrides;
+ (ROXDynamicAPI*_Nonnull)dynamicAPI;
+ (NSArray<ROXString*>*_Nonnull)flags;

/**
 :nodoc:
 */
+(void)setUserspaceUnhandledErrorHandler:(ROXUserspaceUnhandledErrorHandler _Nonnull)handler;

@end

