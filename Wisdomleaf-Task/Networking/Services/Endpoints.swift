//
//  Endpoints.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

/// This enumeration represents the available endpoints that can be used for making network requests.
/// - The use of an enumeration for endpoints provides a clear and organized way to represent the different available network requests
/// - Additional cases can be added as needed to represent other endpoints, making it easier to manage and maintain the codebase.
enum Endpoints {
    
    case getPhotosList(page: Int)
    //......
    
}


//MARK: -
extension Endpoints: EndpointProvider {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "picsum.photos"
    }
    
    var header: [String : String]? {
        switch self {
        case .getPhotosList:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getPhotosList:
            return "/v2/list"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPhotosList(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "30")
            ]
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getPhotosList:
            return .get
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .getPhotosList:
            return nil
        }
    }
}
