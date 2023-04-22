//
//  Endpoints.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

//MARK: - Endpoints
enum Endpoints {
    
    case getPhotosList(page: Int)
    //......
    
}



extension Endpoints: EndpointProvider {
    
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
