import Foundation
import ROXCore


/**
 This class is the API for options that can be send in setup to control SDK options.
 
 
 - SeeAlso: [ROXOptions](../objc/Classes/ROXOptions.html)
 
 
 ```swift ???
 open class ROXOptions : NSObject {
 
    ROXConfigurationFetchedHandler onConfigurationFetched;
    ROXImpressionHandler impressionHandler;
    ROXOptionsVerboseLevel verbose;
 
 }
 
 ```
 
 
 */
public typealias RoxSelfManagedOptions = ROXSelfManagedOptions
public typealias RoxOptions = ROXOptions
public typealias RoxOptionsVerboseLevel = ROXOptionsVerboseLevel
public typealias RoxReportingValue = ROXReportingValue
public typealias RoxFetcherResult = ROXFetcherResult
public typealias RoxFreeze = ROXFreeze
public typealias RoxExceptionTrigger = ROXExceptionTrigger
public typealias RoxDynamicPropertyContext = ROXDynamicPropertyContext

/**
 This class is the API for string feature flags that are controlled by ROX server, Flags are assigned to an experiment and their value is based on experiment container.
 
 
 - SeeAlso: [ROXString](../objc/Classes/ROXString.html)
 
 
 ```swift
 open class RoxString {
 
    open var name: String! { get }
    open var value: String! { get }
 }

 ```

 
*/

public typealias RoxString = ROXString

/**
 This class is the API for boolean flags that are controlled by ROX server, Flags are assigned to an experiment and their value is based on experiment container.
 
 
 - SeeAlso: [ROXFlag](../objc/Classes/ROXFlag.html)
 
 
 ```swift
 open class ROXFlag : ROXString {
 
    open var isEnabled: Bool { get }
    open func enabled(_ codeBlock: (() -> Swift.Void)!)
    open func disabled(_ codeBlock: (() -> Swift.Void)!)
    open func enabled(_ enabledCodeBlock: (() -> Swift.Void)!, disabled disabledCodeBlock: (() -> Swift.Void)!)
    open var name: String! { get }

 }

 ```

 
*/
public typealias RoxFlag = ROXFlag

/**
 This class is the API for integer flags that are controlled by ROX server. Flags are assigned to an experiment and their value is based on experiment container.
 
 
 - SeeAlso: [ROXInt](../objc/Classes/ROXInt.html)
 
 
 ```swift
 open class ROXInt : ROXString {
 
    open var name: String! { get }
    open var value: Int { get }
 }

 ```

 
*/

public typealias RoxInt = ROXInt

/**
 This class is the API for floating point type flags that are controlled by ROX server. Flags are assigned to an experiment and their value is based on experiment container.
 
 
 - SeeAlso: [ROXDouble](../objc/Classes/ROXDouble.html)
 
 
 ```swift
 open class ROXDouble : ROXString {
 
    open var name: String! { get }
    open var value: Double { get }
 }

 ```

 
*/

public typealias RoxDouble = ROXDouble


/**
 ROX class is a static swift class that acts as an facade interface
 - You use this flag for the following:
    
    - Intialize ROX SDK using `ROX.setup(withKey:)`
    - Register container instances using `ROX.register(_:)`
    - Load custom properties with `ROX.setCustomProperty(key:value:)`
    - Present the flags view controller with `ROX.flagsViewController()`

 */


public class ROX {
    /**
     Loads the SDK, usually called as part of `AppDelegate.application:didFinishLaunchingWithOptions:`
     
     Checks if a cached experimentation container exists, and loads a container.
     
     Executes an async network call to fetch the experiment container from the ROX server and calculates experiments and target groups.
     
     - Parameter key: The app key (taken from ROX dashboard)
     */
    public static func setup(withKey key: String) {
        ROXCore.setup(withKey: key)
    }
    
    /**
     Loads the SDK, usually called as part of `AppDelegate.application:didFinishLaunchingWithOptions:`
     
     Checks if a cached experimentation container exists, and loads a container.
     
     Executes an async network call to fetch the experiment container from the ROX server and calculates experiments and target groups.
     
     
     - Parameter key: a unique identifier from type String generated from ROX dashboard
     - Parameter options: setup options
     
     */
    public static func setup(withKey key: String, options: ROXOptions) {
        ROXCore.setup(withKey: key, options: options, platformVersion:"Swift", languageVersion:SwiftVersion.getLanguageCompatibilityVersion())
    }
    

    
    /**
     Register a container instance to ROX system.
     
     - parameter namespace: The namespace to register the instance too.
     
     - parameter  container: The instance to register, this instance values are set at `ROX.setup(withKey:)`, or a if the app goes into foreground.
     
     - Note: This method should be called **only once** for a given namespace.
     
     */
    public static func register(_ namespace: String = "", container: RoxContainer) {
        Register.handleContainer(namespace : namespace, container : container)
    }
    
    /**
     Unfreeze the state of all flags in code
     
     When a flag is used in code, his value gets frozen in the app untill the next app foreground event. Calling this function will unfreeze all flags, and using a flag will return it's most updated value
     
     - SeeAlso: [Flags Consistency](https://support.rollout.io/docs/flags-consistency)
     
     */
    public static func unfreeze() {
        ROXCore.unfreeze()
    }
    
    
    /**
     A view to control feature flags values locally on a mobile device or simulator.
     
     ROX ViewController allows developers, QA or internal employees (depending on policy) to view, disable, enable and reset the state of their flags locally on the device. The functions return a view controller that can be loaded to the view hierarchy for test devices upon shake, or by triggering an existing debug view in the app.
     
     - SeeAlso: [How to setup flagsviewController](https://support.rollout.io/docs/flags-override-view)
     
     - Returns: ViewController which shows the local feature flags and provides an interface to turn them on or off.
     

     */
    public static func flagsViewController() -> UIViewController {
        return ROXCore.flagsViewController()
    }
    
    
    /**
     Sets a custom property value that can be used when creating target groups.
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: The value of the custom property

     */
    public static func setCustomProperty(key: String, value: String) {
        self.setCustomProperty(key: key, asSemver: false, value: value)
    }
    
    /**
     Sets a custom property value that can be used when creating target groups.
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter asSemver: Should the string be computed and treated as a semver ([What is Semantic Versioning](http://semver.org/))
     - Parameter value: The value of the custom property
     
     */
    public static func setCustomProperty(key: String, asSemver: Bool, value: String) {
        if (!asSemver) {
            ROXCore.setCustomStringProperty(value, forKey: key)
        }
        else {
            ROXCore.setCustomSemverProperty(value, forKey: key)
        }
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.

     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping (String?, ROXDynamicPropertyContext?) -> String) {
        self.setCustomProperty(key: key, asSemver: false, value: value)
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping () -> String) {
        self.setCustomProperty(key: key, asSemver: false, value: {(_ : String?, _: ROXDynamicPropertyContext?) -> String in  value() } )
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter asSemver: Should the string be computed and treated as a semver ([What is Semantic Versioning(http://semver.org/))
     - Parameter value: a code block to returns the value of the custom property
     
     */

    public static func setCustomProperty(key: String, asSemver: Bool, value: @escaping (String?, ROXDynamicPropertyContext?) -> String) {
        if (!asSemver) {
            ROXCore.setCustomComputedStringProperty(value, forKey: key)
        }
        else {
            ROXCore.setCustomComputedSemverProperty(value, forKey: key)
        }
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter asSemver: Should the string be computed and treated as a semver ([What is Semantic Versioning(http://semver.org/))
     - Parameter value: a code block to returns the value of the custom property
     
     */
    
    public static func setCustomProperty(key: String, asSemver: Bool, value: @escaping () -> String) {
        return self.setCustomProperty(key:key, asSemver:asSemver, value:{ (_: String?, _: ROXDynamicPropertyContext?) -> String in value() })
    }
    
    /**
     Sets a custom property value that can be used when creating target groups.
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: The value of the custom property
     
     */
    

    public static func setCustomProperty(key: String, value: Bool) {
        ROXCore.setCustomBooleanProperty(value, forKey: key)
    }
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping (String?, ROXDynamicPropertyContext?) -> Bool) {
        ROXCore.setCustomComputedBooleanProperty(value, forKey: key)
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping () -> Bool) {
        return self.setCustomProperty(key: key, value: { (_ : String?, _ : ROXDynamicPropertyContext?) -> Bool in value() })
    }
    /**
     Sets a custom property value that can be used when creating target groups.
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: The value of the custom property
     
     */

    public static func setCustomProperty(key: String, value: Int32) {
        ROXCore.setCustomIntProperty(value, forKey: key)
    }
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping (String?, ROXDynamicPropertyContext?) -> Int32) {
        ROXCore.setCustomComputedIntProperty(value, forKey: key)
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping () -> Int32) {
        return self.setCustomProperty(key:key, value: {(_ : String?, _: ROXDynamicPropertyContext?) -> Int32 in value() });
    }
    /**
     Sets a custom property value that can be used when creating target groups.
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: The value of the custom property
     
     */

    public static func setCustomProperty(key: String, value: Double) {
        ROXCore.setCustomDoubleProperty(value, forKey: key)
    }
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping (String?, ROXDynamicPropertyContext?) -> Double) {
        ROXCore.setCustomComputedDoubleProperty(value, forKey: key)
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter key: The name of the custom property
     - Parameter value: a code block to returns the value of the custom property
     
     */
    public static func setCustomProperty(key: String, value: @escaping () -> Double) {
        return self.setCustomProperty(key:key, value: {(_ : String?, _: ROXDynamicPropertyContext?) -> Double in value() })
    }
    
    public static func setGlobalContext(context: ROXDynamicPropertyContext) {
        return ROXCore.setGlobalDynamicPropertyContext(context);
    }
    
    public static func fetch() -> Void {
        return ROXCore.fetch()
    }
    
    public static func overrides() -> ROXFlagsOverrides {
        return ROXCore.overrides()
    }
    
    public static func dynamicAPI() -> ROXDynamicAPI {
        return ROXCore.dynamicAPI()
    }
    
    public static func flags() -> [ROXString] {
        return ROXCore.flags()
    }
    
    public static func shutdown() {
        ROXCore.shutdown()
    }
}
