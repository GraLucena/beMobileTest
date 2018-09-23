//
//  Router.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonDictionary = [String: AnyObject]

enum Router {
    
    // MARK: - Configuration
    private static let baseHostPath = "https://quiet-stone-2094.herokuapp.com"
    var baseURLPath: String {
        return "\(Router.baseHostPath)"
    }
    
    case rates()
    case transactions()
    
}

extension Router {
    
    struct Request {
        let method: Alamofire.HTTPMethod
        let path: String
        let encoding: ParameterEncoding?
        let parameters: jsonDictionary?
        
        init(method: Alamofire.HTTPMethod,
             path: String,
             parameters: jsonDictionary? = nil,
             encoding: ParameterEncoding = JSONEncoding.default) {
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    var request: Request {
        switch self {
            
        case .rates():
            return Request(method: .get, path: "/rates.json", encoding: URLEncoding.default)
            
        case .transactions():
            return Request(method: .get, path: "/transactions.json", encoding: URLEncoding.default)
        }
    }
}

// MARK: - URLRequestConvertible
extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLPath)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        
        if let encoding = request.encoding {
            return try encoding.encode(urlRequest, with: request.parameters)
        } else {
            return urlRequest
        }
    }
}
