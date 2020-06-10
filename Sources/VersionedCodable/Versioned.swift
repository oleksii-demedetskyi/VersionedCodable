
public struct Versioned<T: Versionable>: Codable {
    public let payload: T
    
    public init(payload: T) {
        self.payload = payload
    }
}

extension Versioned {
    struct VersionNotFound: Error {}
    
    enum CodingKeys: CodingKey {
        case version
        case payload
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(T.version, forKey: .version)
        try container.encode(payload, forKey: .payload)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataVersion = try container.decode(String.self, forKey: .version)
        
        self.payload = try Self.decodePayload(
            type: T.self,
            from: container,
            for: dataVersion
        )
    }
    
    static func decodePayload<Version: Versionable>(
        type: Version.Type,
        from container: KeyedDecodingContainer<Self.CodingKeys>,
        for version: String) throws -> Version
    {
        if Version.version == version {
            return try container.decode(Version.self, forKey: .payload)
        } else if Version.isRoot {
            throw VersionNotFound()
        } else {
            let previous = try decodePayload(
                type: Version.Previous.self,
                from: container,
                for: version
            )
            
            return Version.migrate(from: previous)
        }
    }
}
