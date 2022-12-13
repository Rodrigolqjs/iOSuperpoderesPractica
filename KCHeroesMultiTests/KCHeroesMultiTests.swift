//
//  KCHeroesMultiTests.swift
//  KCHeroesMultiTests
//
//  Created by Rodrigo Latorre on 12/12/22.
//

import SwiftUI
import Combine
import ViewInspector // https://github/nalexn/ViewInspector
import XCTest
@testable import KCHeroesMulti

//Vistas a testear
extension LoginView: Inspectable {}

final class KCHeroesMultiTests: XCTestCase {

    //Testeamos las vistas
    func testViews() throws {
        
        let viewModel = RootViewModel()
        
        let view = LoginView()
            .environmentObject(RootViewModel())
        
        let itemsCount = try view.inspect().count
        XCTAssertEqual(itemsCount, 1)
        
        let img = try view.inspect().find(viewWithId: 1)
        XCTAssertNotNil(img)
        
        let text = try view.inspect().find(viewWithId: 3)
        XCTAssertNotNil(text)
        let textContent = try text.text().string()
        XCTAssertEqual(textContent, "Login")
        
        let button = try view.inspect().find(viewWithId: 2)
        XCTAssertNotNil(text)
        try button.button().tap() // Simula tap en el botón
        
        XCTAssertEqual(viewModel.tokenJWT, read(key: CONST_TOKEN_ID))
        
    }


}
