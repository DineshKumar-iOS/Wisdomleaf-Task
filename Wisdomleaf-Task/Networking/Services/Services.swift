//
//  Services.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import Foundation

//Singleton
class ServiceManager {
    static let shared: APIClient = APIClient(session: .shared)
    private init() {}
}



class Services {
    
    static func getPhotosList(page: Int, completion: @escaping(Result<[PicsumPhotosModel]?, ApiError>) -> Void) {
        ServiceManager.shared.fetchData(endpoint: Endpoints.getPhotosList(page: page), responseModel: [PicsumPhotosModel].self) { result in
            completion(result)
        }
    }
    
}


