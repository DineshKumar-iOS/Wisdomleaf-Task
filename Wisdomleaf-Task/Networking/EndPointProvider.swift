//
//  EndPointProvider.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation


/// This protocol defines the properties and methods required to provide endpoint information for making network requests.
protocol EndpointProvider {
    // The scheme component of the endpoint URL (e.g. https).
    var scheme: String { get }
    
    // The host component of the endpoint URL (e.g. api.example.com).
    var host: String { get }
    
    // The path component of the endpoint URL (e.g. /api/v1/users).
    var path: String { get }
    
    // The query items to be included in the endpoint URL (optional).
    var queryItems: [URLQueryItem]? { get }
    
    // The HTTP request method to be used for the network request (e.g. GET, POST).
    var method: RequestMethod { get }
    
    // The HTTP header fields to be included in the network request (optional).
    var header: [String: String]? { get }
    
    // The request body to be included in the network request (optional).
    var body: [String: Any]? { get }
}
