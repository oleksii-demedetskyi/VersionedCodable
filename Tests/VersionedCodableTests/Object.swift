import VersionedCodable

enum Object {
    typealias Current = Version.V3
    
    enum Version {
        struct V1: Versionable {
            let text: String?
        }
        
        struct V2: Versionable {
            let text: String
            
            static func migrate(_ v1: V1) -> Self {
                V2(text: v1.text ?? "defaultText")
            }
        }
        
        struct V3: Versionable {
            let text: String
            let number: Int
            
            static func migrate(_ v2: V2) -> Self {
                V3(
                    text: v2.text,
                    number: v2.text == "defaultText" ? 1 : 200)
            }
        }
    }
}


