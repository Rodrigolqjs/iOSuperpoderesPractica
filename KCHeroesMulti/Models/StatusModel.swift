//
//  StatusModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation

enum Status {
    case none, loading, loaded, register, error(error: String)
}


enum RegisterStatus {
    case None, Registering, RegisterSuccess, RegisterError
}
