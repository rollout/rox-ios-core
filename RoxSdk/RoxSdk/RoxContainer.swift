import Foundation

/**
 A container class for configurations and flags
 
 Any swift class that adopts this protocol can be used as an entry point for flags and containers that are controlled by ROX system. To use an instance of this class you need to register the instance using the `ROX.register(_:)` method and retrieve the instance using `ROX.get(_:)` method
 
 Here is an example of a class using flags and containers together:
 
 ```swift
     public class MyContainer : RoxContainer {
        //group support feature flag
        let groupSupport = RoxFlag()
 
        // String configuration defaulted to "Hello World"
        let message = RoxConfigurationString(defaultValue: "Hello World")
        
        // Bool configuration default to true
        let shouldShowBadge = RoxConfigurationBool(defaultValue: true)
        
        // Int configuration default to 100
        let popupTimeout = RoxConfigurationInt(defaultValue: 100)
 
        // Double configuration default to
        let ratio = RoxConfigurationDouble(defaultValue: 0.55)
     }
 
    // Register MyContainer class
    ROX.register(MyContainer())
 
 
    // Access MyContainer from any
    let conf = ROX.get(MyContainer.self)!
 
    // Use the Flag
    conf.groupSupport.enabled {
        print("group support enable code goes here")
    }
 
    print("Welcome message is '\(conf.message.value)'")
 

```
 */
public protocol RoxContainer : class {
    /**
        Override this property to override the default namespace of a class
    */
    var namespace: String? { get }
}

public extension RoxContainer {
    /**
     The default implementation of namespace is to return the class full name , you can use [nested type](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/NestedTypes.html#//apple_ref/doc/uid/TP40014097-CH23-ID242) to create a namespace 
     */
    var namespace: String? {
        get {
            return nil
        }
    }
}
