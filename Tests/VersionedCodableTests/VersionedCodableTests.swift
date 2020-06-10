import XCTest
import VersionedCodable

final class VersionedCodableTests: XCTestCase {
    func testExample() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let old = Versioned(payload: Object.Version.V1(text: nil))
        let oldData = try encoder.encode(old)
        
        let new = try decoder.decode(Versioned<Object.Current>.self, from: oldData)
        
        XCTAssertEqual(new.payload.number, 1)
        XCTAssertEqual(new.payload.text, "defaultText")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
