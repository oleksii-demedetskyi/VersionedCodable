public protocol Versionable: Codable {
    associatedtype Previous: Versionable
    
    static func migrate(from previous: Previous) -> Self
}

extension Versionable {
    public static func migrate(from value: Self) -> Self {
        return value
    }
    
    static var version: String {
        String(describing: Self.self)
    }
    
    static var isRoot: Bool {
        version == Previous.version
    }
}

