//
//  ROXErrorHandling.h
//  ROX
//
//  Created by Andrew Anisimov on 19.03.2021.
//  Copyright © 2021 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, ROXExceptionTrigger){
    ROXExceptionTriggerDynamicPropertiesRule,
    ROXExceptionTriggerConfigurationFetchedHandler,
    ROXExceptionTriggerImpressionHandler,
    ROXExceptionTriggerCustomPropertyGenerator
};

typedef void (^ROXUserspaceUnhandledErrorHandler)(ROXExceptionTrigger trigger, NSException * _Nonnull exception);

@interface ROXUserspaceUnhandledErrorInvoker : NSObject

- (void)setHandler:(ROXUserspaceUnhandledErrorHandler _Nonnull )handler;

- (void)trigger:(ROXExceptionTrigger)trigger withException:(NSException* _Nonnull)exception;

@end

@interface ROXUserspaceHandlerException : NSException

@property (nonatomic, readonly) ROXExceptionTrigger trigger;
@property (nonatomic, strong, readonly) NSException * _Nonnull exception;

- (instancetype _Nonnull )initWithTrigger:(ROXExceptionTrigger)trigger exception:(NSException * _Nonnull)exception;
@end
