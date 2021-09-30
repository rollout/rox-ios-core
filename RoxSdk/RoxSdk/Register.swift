import Foundation
import ROXCore

class Register {
    static func handleContainer(namespace: String, container: RoxContainer) {
        ROXCore.handleNamespace(namespace)
        let props = Mirror(reflecting: container).children
        for p in props.compactMap({ $0 }) {
            let rawName = namespace == "" ? p.label! : "\(namespace).\(p.label!)"

            if let flag = p.value as? ROXString {
                ROXCore.setVariant(flag, forKey: rawName)
            }
            else if let variantable = p.value as? ROXStringableType {
                ROXCore.setVariant(variantable.objcBridge, forKey: rawName)
            }
        }
    }
}
