//
//  File.swift
//  
//
//  Created by Danimir Bermudez on 16/10/21.
//

import Foundation

public struct Email {
    let to: String
    let subject: String
    let body: String
    
    func subjectQueryEncoded() -> String { queryEncode(subject) }
    func bodyQueryEncoded() -> String { queryEncode(body) }
    
    private func queryEncode(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

public enum EmailApp: CaseIterable {
    
    case gmail
    case outlook
    case spark
    case yahooMail
    case other
    
    var name: String {
        switch self {
        case .gmail: return "Gmail"
        case .outlook: return "Outlook"
        case .spark: return "Spark"
        case .yahooMail: return "Yahoo mail"
        case .other: return "Generic"
        }
    }
    
    private var appScheme: String {
        switch self {
        case .gmail: return "googlegmail://"
        case .outlook: return "ms-outlook://"
        case .spark: return "readdle-spark://"
        case .yahooMail: return "ymail://"
        case .other: return "mailto:"
        }
    }
    
    private var urlFormat: String {
        switch self {
        case .gmail: return "\(appScheme)co?to=%@&subject=%@&body=%@"
        case .outlook: return "\(appScheme)compose?to=%@&subject=%@"
        case .spark: return "\(appScheme)compose?recipient=%@&subject=%@&body=%@"
        case .yahooMail: return "\(appScheme)mail/compose?to=%@&subject=%@&body=%@"
        case .other: return "\(appScheme)%@?subject=%@&body=%@"
        }
    }
    
    public func getUrl(to email: Email) -> URL {
        let urlString = String(format: urlFormat,
                               email.to,
                               email.subjectQueryEncoded(),
                               email.bodyQueryEncoded())
        
        return URL(string: urlString)!
    }
}
