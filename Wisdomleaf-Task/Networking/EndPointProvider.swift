//
//  EndPointProvider.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

protocol EndpointProvider {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}


extension EndpointProvider {
    var scheme: String {
        return "https"
    }
}
