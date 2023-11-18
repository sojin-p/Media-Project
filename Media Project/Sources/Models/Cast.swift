//
//  Cast.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

struct CastData: Decodable {
    let id: Int
    var cast, crew: [Cast]
}

struct Cast: Decodable {
    let id: Int
    let name: String //배우이름
    let character: String? //역할 이름
    let originalName: String //배우의 오리지날 이름
    let knownForDepartment: String
    let profilePath: String?
    let castId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case originalName = "original_name"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case castId = "cast_id"
    }
}
