import Foundation
import ROXCore

class Register {
    static func handleConfiguration(reflecting: RoxConfiguration){
        var objcNamespace : String? = nil
        if let objcConfiguration = reflecting as? NSObject {
            ROXCore.registerClass(objcConfiguration)
            objcNamespace = NSStringFromClass(type(of: objcConfiguration))
        }
        
        let props = Mirror(reflecting: reflecting).children
        for p in props.flatMap({ $0 }) {
            let namespace = reflecting.namespace ?? objcNamespace ?? String(describing: reflecting)
            let rawName = namespace == "" ? p.label! : "\(namespace).\(p.label!)"

            if let flag = p.value as? ROXVariant {
                ROXCore.setVariant(flag, forKey: rawName)
            }
            else if let remoteVariable = p.value as? ROXRemoteVariable {
                ROXCore.setRemoteVariable(remoteVariable, forKey: rawName)
            }
            else if let variantable = p.value as? ROXVariantableType {
                ROXCore.setVariant(variantable.variant, forKey: rawName)
            }
        }
    }
}
