import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(let_sExtendTests.allTests),
    ]
}
#endif
