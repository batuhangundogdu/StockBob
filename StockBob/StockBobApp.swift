//
//  StockBobApp.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 29.12.2021.
//

import SwiftUI

@main
struct StockBobApp: App {
    
    init() {
        
        RealmManager.shared.openRealm()
        
        let dbCreated = UserDefaults.standard.object(forKey: "DB_CREATED") as? Bool ?? false
        if !dbCreated {
            RealmManager.shared.addStocks(allStocksResponse)
            UserDefaults.standard.set(true, forKey: "DB_CREATED")
        }
        
        RealmManager.shared.getStocks()
    }
    
    var body: some Scene {
        WindowGroup {
            WatchListView()
        }
    }
}
