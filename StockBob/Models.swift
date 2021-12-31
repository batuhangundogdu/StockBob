//
//  Models.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 29.12.2021.
//

import Foundation
import RealmSwift
import RxSwift

class Stock: Object, Codable, Identifiable {
    @objc dynamic var id = UUID()
    @objc dynamic var code = ""
    @objc dynamic var price: Double = Double.random(in: 10...100)
    @objc dynamic var inWatchlist: Bool = false
}

let allStocksResponse = ["AEFES","AKSEN","ARCLK","AYGAZ","BRISA","DOHOL","ENKAI","ENJSA","GARAN","HALKB","PETKM","PGSUS","SA HOL","SISE","TCELL","TKFEN","THYAO","TURSG","ULKER","TUPRS","VAKBN"]
let watchlistRequest = ["GARAN","THYAO"]
let watchlistResponse = ["{“code”:”GARAN”, “price”:9.76},{“code”: “THYAO”, “price”: 13.26}"]
