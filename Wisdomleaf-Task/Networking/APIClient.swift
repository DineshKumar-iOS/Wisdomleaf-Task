//
//  APIClient.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

protocol NetworkService {
    func fetchData<M:Decodable>(endpoint: EndpointProvider, responseModel:M.Type, completionHandler: @escaping (Result<M?,ApiError>) -> Void)
}

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
            
            data?.printResponse(with: "\(url)", and: [:])
            
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
    
    
    private func makeURL(from endpoint: EndpointProvider) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        return urlComponents.url
    }
}
