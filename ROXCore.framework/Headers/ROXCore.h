//
//  ROX SDK version 1.0.0, Build 428
//
//  Copyright (c) 2014 ROX.io. All rights reserved.
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
#import "ROXBaseConfiguration.h"
#import "ROXVariant.h"


#define ROX ROXCore

@interface ROXCore : NSObject

+(void)setupWithKey:(NSString *)roxKey;
+(void)setupWithKey:(NSString *)roxKey options:(ROXOptions *)options;
+(BOOL)roxDisabled;

+ (UIViewController*)flagsViewController;
+ (BOOL)isTestDevice;

+(void) setCustomStringProperty:(NSString*)value forKey:(NSString*)key;
+(void) setCustomComputedStringProperty:(NSString* (^)())block forKey:(NSString*)key;

+(void) setCustomBooleanProperty:(BOOL)value forKey:(NSString*)key;
+(void) setCustomComputedBooleanProperty:(BOOL (^)())block forKey:(NSString*)key;

+(void) setCustomIntProperty:(int)value forKey:(NSString*)key;
+(void) setCustomComputedIntProperty:(int (^)())block forKey:(NSString*)key;

+(void) setCustomDoubleProperty:(double)value forKey:(NSString*)key;
+(void) setCustomComputedDoubleProperty:(double (^)())block forKey:(NSString*)key;

+(void) setCustomSemverProperty:(NSString*)value forKey:(NSString*)key;
+(void) setCustomComputedSemverProperty:(NSString* (^)())block forKey:(NSString*)key;

+(void) setVariant:(ROXVariant*)variant forKey:(NSString*)key;
+(ROXVariant*) variantWithKey:(NSString*)key;

+(void) setRemoteVariable:(ROXRemoteVariable*)remoteVariable forKey:(NSString*)key;
+(ROXRemoteVariable*) remoteVariableWithKey:(NSString*)key;

+(void) sync;
+(void) unfreeze;

+(void) register:(ROXBaseConfiguration*)configuration;
+(void) registerClass:(NSObject*)configuration;
+(NSObject*) get:(Class)clazz;

+(ROXFlag*)flag;
+(ROXVariant*)variantWithDefault:(NSString*)value options:(NSArray<NSString*>*)options;

#ifdef DEBUG
void resetROXDispatchOnce(void);
#endif

@end

