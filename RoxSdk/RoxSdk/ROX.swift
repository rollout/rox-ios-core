import Foundation
import ROXCore
/**
 This class is the API for flags that are controlled by ROX server, Flags are assigned to an experiment and their value is based on experiment configuration.
 
 - Methods:
 ```swift
 open class ROXFlag : ROXVariant {
 
    open var isEnabled: Bool { get }
    open func enabled(_ codeBlock: (() -> Swift.Void)!)
    open func disabled(_ codeBlock: (() -> Swift.Void)!)
    open func enabled(_ enabledCodeBlock: (() -> Swift.Void)!, disabled disabledCodeBlock: (() -> Swift.Void)!)
    open var name: String! { get }

 }

 ```
 

 - SeeAlso: [ROXFlag](../objc/Classes/ROXFlag.html)
**/
public typealias RoxFlag = ROXFlag

/**
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - Methods:
    - `open var value: String { get }`
    - `public init(defaultValue: String)`

 
 - SeeAlso: [ROXConfigurationString](../objc/Classes/ROXConfigurationString.html)
 **/

public typealias RoxConfigurationString = ROXConfigurationString

/**
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - Methods:
 - `open var value: Int { get }`
 - `public init(defaultValue: Int)`
 
 
 - SeeAlso: [ROXConfigurationInt](../objc/Classes/ROXConfigurationInt.html)
 **/
public typealias RoxConfigurationInt = ROXConfigurationInt
/**
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - Methods:
 - `open var value: Double { get }`
 - `public init(defaultValue: Double)`
 
 
 - SeeAlso: [ROXConfigurationDouble](../objc/Classes/ROXConfigurationDouble.html)
 **/
public typealias RoxConfigurationDouble = ROXConfigurationDouble
/**
 This class is the API for a remote configuration String that is controlled by ROX server, on init you assing a default value to that string that can be changed by the configuration tab in ROX dashboard
 
 - Methods:
 - `open var value: Bool { get }`
 - `public init(defaultValue: Bool)`
 
 
 - SeeAlso: [ROXConfigurationBool](../objc/Classes/ROXConfigurationBool.html)
 **/
public typealias RoxConfigurationBool = ROXConfigurationBool


/**
 ROX class is a static swift class that acts as an facade interface
 - You use this flag for the following:
    
    - Intialize ROX SDK using `ROX.setup(withKey:)`
    - Register configuration instances using `ROX.register(_:)`
    - Retrieve configuration instances using `ROX.get(_:)`
    - Load custom properties with `ROX.setCustomProperty(key:value:)`
    - Present the flags view controller with `ROX.flagsViewController()`

 */


public class ROX {
    static var store = [String: RoxConfiguration]()
    
    /**
     Register a configuration instance to ROX system, the same instance can be retrieved by using `ROX.get(_:)` function
     
     - parameter  configuration: The instance to register, this instance values are set at `ROX.sync()`, `ROX.setup(withKey:)`, or a if the app goes into foreground
     
     - Note: this method should be called **only once** for a given class
     
     */
    public static func register(_ configuration: RoxConfiguration) {
        guard let configurationClass = type(of: configuration) as? AnyClass else {
            print("type of \(configuration) is not AnyClass. Will not register")
            return
        }
        
        Register.handleConfiguration(reflecting: configuration)
        
        store[NSStringFromClass(configurationClass)] = configuration
    }
    
    /**
     Retrieve an instance from type clazz that was registered with `ROX.register(_:)`
     
     - Parameter  clazz: The type of instance you want to retrieve
     - Returns: The instance that was registered
    
     */
    public static func get<T: RoxConfiguration>(_ clazz: T.Type) -> T? {
        guard let anyClazz = clazz as? AnyClass else {
            return nil
        }
        
        let configuration = store[NSStringFromClass(anyClazz)]
        
        return configuration as? T
    }
    /**
     Loads the SDK, usually called as part of `AppDelegate.application:didFinishLaunchingWithOptions:`
     
     Checks if a cached experimentation configuration exists, and loads a configuration.
     
     Executes an async network call to fetch the experiment configuration from the ROX server and calculates experiments and target groups.
     
     - Parameter key: The app key (taken from ROX dashboard)
    */
    public static func setup(withKey key: String) {
        ROXCore.setup(withKey: key)
    }
    
    /**
     Loads the SDK, usually called as part of `AppDelegate.application:didFinishLaunchingWithOptions:`
     
     Checks if a cached experimentation configuration exists, and loads a configuration.
     
     Executes an async network call to fetch the experiment configuration from the ROX server and calculates experiments and target groups.
     
     
     - Parameter key: a unique identifier from type String generated from ROX dashboard
     - Parameter options: setup options

     */
    public static func setup(withKey key: String, options: ROXOptions) {
        ROXCore.setup(withKey: key, options: options)
    }

    /**
     Check if ROX is disabled.
     
     - Returns: true if ROX is disabled (disabled from the server side).
     */
    public static func roxDisabled() -> Bool {
        return ROXCore.roxDisabled()
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
     Checks if device is a test device.
     
     Test device are managed by [App Settings](true if device is test device, false otherwise) in the dashboard
     
     - SeeAlso: [App Settings](true if device is test device, false otherwise)
     
     - Returns: true if device is test device, false otherwise.
     */
    public static func isTestDevice() -> Bool {
        return ROXCore.isTestDevice()
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
    public static func setCustomProperty(key: String, value: @escaping () -> String) {
        self.setCustomProperty(key: key, asSemver: false, value: value)
    }
    
    /**
     Sets a computed custom property value that can be used when creating target groups.
     
     This method is used when you wish to supply a block of code that will be evaluated on foreground event or when either `ROX.sync()` , `ROX.setup(withKey:)` is called.
     
     
     - SeeAlso: [Creating a target group](https://support.rollout.io/docs/creating-target-groups)
     
     - Parameter asSemver: Should the string be computed and treated as a semver ([What is Semantic Versioning(http://semver.org/))
     - Parameter value: a code block to returns the value of the custom property
     
     */

    public static func setCustomProperty(key: String, asSemver: Bool, value: @escaping () -> String) {
        if (!asSemver) {
            ROXCore.setCustomComputedStringProperty(value, forKey: key)
        }
        else {
            ROXCore.setCustomComputedSemverProperty(value, forKey: key)
        }
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
    public static func setCustomProperty(key: String, value: @escaping () -> Bool) {
        ROXCore.setCustomComputedBooleanProperty(value, forKey: key)
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
    public static func setCustomProperty(key: String, value: @escaping () -> Int32) {
        ROXCore.setCustomComputedIntProperty(value, forKey: key)
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
    public static func setCustomProperty(key: String, value: @escaping () -> Double) {
        ROXCore.setCustomComputedDoubleProperty(value, forKey: key)
    }
    /**
     Recalculate the rules of experiments allocation base on new data
     
     
     - SeeAlso: `ROX.unfreeze()`
     
     - Note: Usually called after the user has logged in to refresh ROX custom properties
     - Note: if a flag has already been used (had impression) is is freezed and the calculation will not change the flag state, to change the flag state you need to unfreeze the flag right after the sync call
     
     */

    public static func sync() {
        ROXCore.sync()
    }
    
    /**
     Unfreeze the state of all flags in code
     
     When a flag is used in code, his value gets frozen in the app untill the next app foreground event. Calling this function will unfreeze all flags, and using a flag will return it's most updated value
     
     - SeeAlso: [Flags Consistency](https://support.rollout.io/docs/flags-consistency)
     
     */
    public static func unfreeze() {
        ROXCore.unfreeze()
    }
}
