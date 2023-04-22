//
//  PicsumPhotosModel.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 22/04/23.
//

import Foundation

struct PicsumPhotosModel: Codable{
    var downloadURL: String?
    var id: String?
    var author: String?
    var width: Int?
    var height: Int?
    var url: String?
    var isChecked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
