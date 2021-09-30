import Foundation
import ROXCore

protocol ROXStringableType {
    var objcBridge : ROXString { get }
}

public class RoxEnumString<T:RawRepresentable> : ROXStringableType where T.RawValue == Int {
    private let defaultValue: T
    private let values :[String: T]
    fileprivate let rawVariant : ROXString
    public init(_ defaultValue:T){
        self.defaultValue = defaultValue
        self.values = RoxEnumString<T>.allValues(defaultValue)
        self.rawVariant = ROXString(withDefault: String(describing: defaultValue), variations: Array(values.keys))
    }
    
    public init(_ defaultValue:T, freeze: ROXFreeze){
        self.defaultValue = defaultValue
        self.values = RoxEnumString<T>.allValues(defaultValue)
        self.rawVariant = ROXString(withDefault: String(describing: defaultValue), variations: Array(values.keys), freeze: freeze)
    }
    
    public var value: T {
        get {
            if let valueFromOptions = self.values[self.rawVariant.value()] {
                return valueFromOptions
            }
            
            return self.defaultValue
        }
    }
    
    public var name: String {
        get {
            return self.rawVariant.name
        }
    }
    
    private static func allValues(_ oneValue: T) -> [String: T]{
        var result = [String: T]()
        for i in RoxEnumString<T>.enumerate() {
            result[String(describing:i)] = i
        }
        return result
    }
    
    private static func enumerate() -> AnyIterator<T>{
        var nextIndex = -1
        return AnyIterator {
            nextIndex += 1
            return T(rawValue:  nextIndex)
        }
    }
    
    public var objcBridge : ROXString {
        get {
            return self.rawVariant
        }
    }
    
    public func unfreeze() {
        self.rawVariant.unfreeze()
    }
}
