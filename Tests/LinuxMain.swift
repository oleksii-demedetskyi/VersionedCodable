import XCTest

import VersionedCodableTests

var tests = [XCTestCaseEntry]()
tests += VersionedCodableTests.allTests()
XCTMain(tests)
