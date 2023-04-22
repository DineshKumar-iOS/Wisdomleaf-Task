//
//  Services.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

/// The ServiceManager class is implemented as a singleton to ensure that there is only one instance of the APIClient
class ServiceManager {
    static let shared: APIClient = APIClient(session: .shared)
    private init() {}
}


/// The Services class is created to abstract all the API requests, making it easier to manage the network requests throughout the app.
/// This function uses the shared instance of the APIClient to fetch data endpoints. Once the data is fetched, the result is passed to the completion handler.
class Services {
    
    static func getPhotosList(page: Int, completion: @escaping(Result<[PicsumPhotosModel]?, ApiError>) -> Void) {
        ServiceManager.shared.fetchData(endpoint: Endpoints.getPhotosList(page: page), responseModel: [PicsumPhotosModel].self) { result in
            completion(result)
        }
    }
}


