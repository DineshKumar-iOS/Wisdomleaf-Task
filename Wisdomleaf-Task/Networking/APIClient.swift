//
//  APIClient.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

/// This protocol defines the method required to fetch data from an endpoint using a provided response model and a completion handler.
protocol NetworkService {
    func fetchData<M:Decodable>(endpoint: EndpointProvider, responseModel:M.Type, completionHandler: @escaping (Result<M?,ApiError>) -> Void)
}

/// This class implements the NetworkService protocol, which defines the method required to fetch data from an endpoint.
/// The fetchData method makes a network request using the provided endpoint information and response model, and calls the completion handler with the result.
final class APIClient: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<M:Decodable>(endpoint: EndpointProvider, responseModel:M.Type, completionHandler: @escaping (Result<M?,ApiError>) -> Void) {

        guard let url = makeURL(from: endpoint) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        session.dataTask(with: request) { (data, response, error) in
                        
            if let error = error {
                completionHandler(.failure(.requestFailed(description: error.localizedDescription)))
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.noResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    completionHandler(.failure(.failedSerialization))
                    return
                }
                completionHandler(.success(decodedResponse))
            default:
                completionHandler(.failure(.unexpectedStatusCode))
            }
        }.resume()
    }
    
    
    // Create a URL object from the provided endpoint information.
    private func makeURL(from endpoint: EndpointProvider) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        return urlComponents.url
    }
}
