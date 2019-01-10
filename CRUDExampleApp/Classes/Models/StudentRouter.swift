//
//  StudentRouter.swift
//  CRUDExampleApp
//
//  Created by dejan kraguljac on 10/01/2019.
//  Copyright © 2019 ReRoot. All rights reserved.
//
import Alamofire

enum StudentRouter: URLRequestConvertible {
    
    enum Constants {
        static let baseURLPath = "http://it.ffos.hr/P320182019/tjakopec/Programiranje3API"
    }
    
    case create(name: String, lastName: String, email: String, position: String)
    case read
    case readSingle(id: String)
    case update(id: Int, name: String, lastName: String, email: String, position: String)
    case delete(id: Int)
    case search(searchString: String)
    
    var method: HTTPMethod {
        switch self {
        case .create, .update, .delete:
            return .post
        case .read, .search, .readSingle:
            return .get
        }
    }
    
    // {"ime": "xxx", "prezime": "xxx", "email": "xxx", "uloga": "xxx"}
    var path: String {
        switch self {
        case .create:
            return "/create"
        case .readSingle(let id):
            return "/read/\(id)"
        case .read:
            return "/read"
        case .update(_):
            return "/update"
        case .delete(_):
            return "/delete"
        case .search(let searchString):
            return "/search/\(searchString)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .create(name: let n, lastName: let l, email: let e, position: let p):
            return ["ime": n, "prezime": l, "email": e, "uloga": p]
        case .update(id: let i, name: let n, lastName: let l, email: let e, position: let p):
            return ["sifra": i, "ime": n, "prezime": l, "email": e, "uloga": p]
        case .delete(id: let i):
            return ["sifra": i]
        default:
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "cache-control": "no-cache"
        ]
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        if method == .post {
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
                request.httpBody = data
            }
        }
        
        
        return request
    }
}


