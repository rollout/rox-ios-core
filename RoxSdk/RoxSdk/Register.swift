import Foundation
import ROXCore

class Register {
    static func handleContainer(namespace: String, container: RoxContainer) {
        ROXCore.handleNamespace(namespace)
        let props = Mirror(reflecting: container).children
        for p in props.flatMap({ $0 }) {
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
