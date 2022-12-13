//
//  RegisterViewModel.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 13/12/22.
//

import Foundation
import Combine

final class RegisterViewModel: ObservableObject {
    @Published var status = RegisterStatus.None
    private var suscriptor = Set<AnyCancellable>()
    
    func register(data: RegisterModel) {
        self.status = .Registering
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionRegister(data: data))
            .tryMap {
                guard let resp = $0.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                return resp.statusCode
            }
            .replaceError(with: 400)
            .receive(on: DispatchQueue.main)
            .sink { statusCode in
                if (statusCode == 201) {
                    self.status = RegisterStatus.RegisterSuccess
                } else {
                    self.status = RegisterStatus.RegisterError
                }
            }
            .store(in: &suscriptor)
    }
}

