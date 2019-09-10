import Foundation

//MARK: - ValidationError
class ValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

//MARK: - ValidatorConvertible
protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

//MARK: - MobileValidator
struct MobileValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        let PHONE_REGEX = "[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        if !result {
            throw ValidationError("Invalid Phone number, Phone number must be in format '819XXXXXXXX'")
        }
        return value
    }
}

//MARK: - FirstNameValidator
struct FirstNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("FirstName must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("FirstName shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid FirstName, FirstName should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid FirstName, FirstName should not contain whitespaces,  or special characters")
        }
        return value
    }
}

//MARK: - LastNameValidator
struct LastNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("LastName must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("LastName shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid LastName, LastName should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid LastName, LastName should not contain whitespaces,  or special characters")
        }
        return value
    }
}

//MARK: - EmailValidator
struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}
