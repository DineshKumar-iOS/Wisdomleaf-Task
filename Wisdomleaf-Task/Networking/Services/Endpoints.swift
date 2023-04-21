//
//  Endpoints.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

//MARK: - Endpoints
enum Endpoints {
    
    case getPhotosList
    //......
    
}



extension Endpoints: EndpointProvider {
    
    var host: String {
        return "picsum.photos"
    }
    
    var header: [String : String]? {
        switch self {
        case .getPhotosList:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getPhotosList:
            return "/v2/list"
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
