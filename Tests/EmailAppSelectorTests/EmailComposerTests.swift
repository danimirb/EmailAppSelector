import XCTest
@testable import EmailAppSelector

final class EmailAppSelectorTests: XCTestCase {
    
    func testExample() throws {
        XCTAssertEqual(EmailAppSelector().text, "Hello, World!")
    }
    
    func test_getUrl_gmailApp() throws {
        let email = Email(to: "danimirb@gmail.com", subject:"Hola como estas", body: "Este es un subject de prueba")
        
        let subjectEncoded = email.subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = email.body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let to = email.to
        
        let urlAbs = "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        let app = EmailApp.gmail
        let url = app.getUrl(to: email)
        
        XCTAssertEqual(url.absoluteString, urlAbs)
    }
    
    func test_getUrl_yahooMailApp() throws {
        let email = Email(to: "danimirb@gmail.com", subject:"Hola como estas", body: "Este es un subject de prueba")
        
        let subjectEncoded = email.subjectQueryEncoded()
        let bodyEncoded = email.bodyQueryEncoded()
        let to = email.to
        
        let urlAbs = "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        let app = EmailApp.yahooMail
        let url = app.getUrl(to: email)
        
        XCTAssertEqual(url.absoluteString, urlAbs)
    }
    
    
    func test_getUrl_sparkApp() throws {
        let email = Email(to: "danimirb@gmail.com", subject:"Hola como estas", body: "Este es un subject de prueba")
        
        let subjectEncoded = email.subjectQueryEncoded()
        let bodyEncoded = email.bodyQueryEncoded()
        let to = email.to
        
        let urlAbs = "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)"
        
        let app = EmailApp.spark
        
        let url = app.getUrl(to: email)
        
        XCTAssertEqual(url.absoluteString, urlAbs)
    }
    
    func test_getUrl_outlookApp() throws {
        let email = Email(to: "danimirb@gmail.com", subject:"Hola como estas", body: "Este es un subject de prueba")
        let subjectEncoded = email.subjectQueryEncoded()
        let to = email.to
        let urlAbs = "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)"
        let app = EmailApp.outlook
        let url = app.getUrl(to: email)
        XCTAssertEqual(url.absoluteString, urlAbs)
    }
}
