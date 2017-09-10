import Foundation
import ROXCore

class Register {
    static func handleContainer(reflecting: RoxContainer){
        var objcNamespace : String? = nil
        if let objcContainer = reflecting as? NSObject {
            ROXCore.registerClass(objcContainer)
            objcNamespace = NSStringFromClass(type(of: objcContainer))
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
                ROXCore.setVariant(variantable.objcBridge, forKey: rawName)
            }
        }
    }
}
