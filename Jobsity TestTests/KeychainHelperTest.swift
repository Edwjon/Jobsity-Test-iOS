import XCTest
@testable import Jobsity_Test

class KeychainHelperTests: XCTestCase {
    
    var keychain: KeychainHelper!
    let testKey = "TestKey"
    let testValue = "SecureData123"

    override func setUp() {
        super.setUp()
        keychain = KeychainHelper.shared
        keychain.delete(forKey: testKey)
    }
    
    override func tearDown() {
        keychain.delete(forKey: testKey)
        keychain = nil
        super.tearDown()
    }
    
    func testSaveAndRetrieve_ShouldReturnCorrectValue() {
        keychain.save(testValue, forKey: testKey)
        
        let retrievedValue = keychain.retrieve(forKey: testKey)
        XCTAssertEqual(retrievedValue, testValue, "The retrieved value should match the saved one.")
    }
    
    func testRetrieve_NonExistingKey_ShouldReturnNil() {
        let retrievedValue = keychain.retrieve(forKey: "NonExistingKey")
        XCTAssertNil(retrievedValue, "Retrieving a non-existing key should return nil.")
    }
    
    func testOverwrite_ShouldUpdateValue() {
        keychain.save("OldValue", forKey: testKey)
        keychain.save(testValue, forKey: testKey)
        
        let retrievedValue = keychain.retrieve(forKey: testKey)
        XCTAssertEqual(retrievedValue, testValue, "The value should have been updated correctly.")
    }
    
    func testDelete_ShouldRemoveValue() {
        keychain.save(testValue, forKey: testKey)
        keychain.delete(forKey: testKey)
        
        let retrievedValue = keychain.retrieve(forKey: testKey)
        XCTAssertNil(retrievedValue, "The value should have been deleted from the Keychain.")
    }
}
