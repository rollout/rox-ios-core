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
public typealias RoxOptions = ROXOptions
public typealias RoxOptionsVerboseLevel = ROXOptionsVerboseLevel
public typealias RoxExperiment = ROXExperiment
public typealias RoxReportingValue = ROXReportingValue
public typealias RoxFetcherResult = ROXFetcherResult
public typealias RoxFreeze = ROXFreeze

/**
 This class is the API for flags that are controlled by ROX server, Flags are assigned to an experiment and their value is based on experiment container.
 
 
 - SeeAlso: [ROXFlag](../objc/Classes/ROXFlag.html)
 
 
 ```swift
 open class ROXFlag : ROXVariant {
 
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
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard

 
 - SeeAlso: [ROXConfigurationString](../objc/Classes/ROXConfigurationString.html)

 
 ```swift
 open class ROXConfigurationString {
 
    open var value: String { get }
    public init(defaultValue: String)
 
 }
 ```

 */

public typealias RoxConfigurationString = ROXConfigurationString

/**
 This class is the API for a remote configuration Int that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - SeeAlso: [ROXConfigurationInt](../objc/Classes/ROXConfigurationInt.html)

 ```swift
 open class ROXConfigurationInt {
 
 open var value: Int { get }
 public init(defaultValue: Int)
 
 }
 ```
 
 */
public typealias RoxConfigurationInt = ROXConfigurationInt
/**
 This class is the API for a remote configuration Double that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - SeeAlso: [ROXConfigurationDouble](../objc/Classes/ROXConfigurationDouble.html)
 
 
 ```swift
 open class ROXConfigurationDouble {
 
 open var value: Double { get }
 public init(defaultValue: Double)
 
 }
 ```
 
 
 */
public typealias RoxConfigurationDouble = ROXConfigurationDouble
/**
 This class is the API for a remote configuration Bool that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 

 - SeeAlso: [ROXConfigurationBool](../objc/Classes/ROXConfigurationBool.html)

 
 ```swift
 open class ROXConfigurationBool {
 
 open var value: Bool { get }
 public init(defaultValue: Bool)
 
 }
 ```
 
 
 */
public typealias RoxConfigurationBool = ROXConfigurationBool


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
        ROXCore.setup(withKey: key, options: options)
    }
    

    
    /**
     Register a container instance to ROX system.
     
     - parameter namespace: The namespace to register the instance too.
     
     - parameter  container: The instance to register, this instance values are set at `ROX.setup(withKey:)`, or a if the app goes into foreground.
     
     - Note: This method should be called **only once** for a given namespace.
     
     */
    public static func register(_ namespace: String, container: RoxContainer) {
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
    public static func setCustomProperty(key: String, value: @escaping (String?) -> String) {
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
        self.setCustomProperty(key: key, asSemver: false, value: {(_ : String?) -> String in  value() } )
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter asSemver: Should the string be computed and treated as a semver ([What is Semantic Versioning(http://semver.org/))
     - Parameter value: a code block to returns the value of the custom property
     
     */

    public static func setCustomProperty(key: String, asSemver: Bool, value: @escaping (String?) -> String) {
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
        return self.setCustomProperty(key:key, asSemver:asSemver, value:{ (_: String?) -> String in value() })
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
    public static func setCustomProperty(key: String, value: @escaping (String?) -> Bool) {
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
        return self.setCustomProperty(key: key, value: { (_ : String?) -> Bool in value() })
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
    public static func setCustomProperty(key: String, value: @escaping (String?) -> Int32) {
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
        return self.setCustomProperty(key:key, value: {(_ : String?) -> Int32 in value() });
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
    public static func setCustomProperty(key: String, value: @escaping (String?) -> Double) {
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
        return self.setCustomProperty(key:key, value: {(_ : String?) -> Double in value() })
    }
        
    public static func fetch() -> Void {
        return ROXCore.fetch()
    }
    
    public static func overrides() -> ROXFlagsOverrides {
        return ROXCore.overrides()
    }
    
    public static func flags() -> [ROXVariant] {
        return ROXCore.flags()
    }
}
