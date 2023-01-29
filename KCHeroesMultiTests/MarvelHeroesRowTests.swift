//
//  KCHeroesMultiTests.swift
//  KCHeroesMultiTests
//
//  Created by Rodrigo Latorre on 12/12/22.
//

import SwiftUI
import ViewInspector // https://github/nalexn/ViewInspector
import XCTest
@testable import KCHeroesMulti

//Vistas a testear
extension MarvelHeroesRowView: Inspectable {}

final class KCHeroesMultiTests: XCTestCase {

    
    func test_marvelHerosRow_view() throws {
    
        let view = MarvelHeroesRowView(hero: MarvelHeroModel(
            id: 1,
            name: "test",
            description: "testdesc",
            thumbnail: Thumbnail(path: "testpath", thumbnailExtension: Extension.jpg ),
            resourceURI: "uri",
            series: Comics(available: 1,
                           collectionURI: "collUri",
                           items: [ComicsItem(resourceURI: "comicuri",
                                              name: "tesetcomi")],
                           returned: 1)))

        let rowImage = try view.inspect().find(viewWithId: "ImageRow")
        XCTAssertNotNil(rowImage)
        
        let rowText = try view.inspect().find(viewWithId: "TextRow")
        XCTAssertNotNil(rowText)
        
    }


}
