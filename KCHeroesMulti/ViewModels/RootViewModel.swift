//
//  RootViewModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 6/12/22.
//

import Foundation
import Combine

public let CONST_TOKEN_ID = "TokenJWTKeyChainKeepCoding2022"

final class RootViewModel: ObservableObject {
    @Published var status = Status.loaded
    
    private var suscriptor = Set<AnyCancellable>()
    
}


