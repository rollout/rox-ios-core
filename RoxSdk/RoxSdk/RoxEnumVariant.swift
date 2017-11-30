import Foundation
import ROXCore

protocol ROXVariantableType {
    var objcBridge : ROXVariant { get }
}

public class RoxEnumVariant<T:RawRepresentable> : ROXVariantableType where T.RawValue == Int {
    private let defaultValue: T
    private let values :[String: T]
    fileprivate let rawVariant : ROXVariant
    public init(_ defaultValue:T){
        self.defaultValue = defaultValue
        self.values = RoxEnumVariant<T>.allValues(defaultValue)
        self.rawVariant = ROXVariant(withDefault: String(describing: defaultValue), options: Array(values.keys))
    }
    
    public init(_ defaultValue:T, freeze: ROXFreeze){
        self.defaultValue = defaultValue
        self.values = RoxEnumVariant<T>.allValues(defaultValue)
        self.rawVariant = ROXVariant(withDefault: String(describing: defaultValue), options: Array(values.keys), freeze: freeze)
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
        for i in RoxEnumVariant<T>.enumerate() {
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
    
    public var objcBridge : ROXVariant {
        get {
            return self.rawVariant
        }
    }
    
    public func unfreeze() {
        self.rawVariant.unfreeze()
    }
}
