//
//  GlobalData.swift
//  admin
//
//  Created by imen cheref on 25/09/2023.
//

import Foundation

class GlobalData {
    
    static let shared = GlobalData()
    
    var globalStateOrder: [StateOrder] = []
    let endPointImage = "https://127.0.0.1:8000/images/recette/"
    
}
