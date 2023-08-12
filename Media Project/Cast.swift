//
//  Cast.swift
//  Media Project
//
//  Created by 박소진 on 2023/08/12.
//

import Foundation

struct Cast {
    let originalName: String
    let character: String
    let profileURLString: String
    
    var castTitle: String {
        "\(character) (\(originalName))"
    }
}
