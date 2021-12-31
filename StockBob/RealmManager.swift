//
//  RealmManager.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 30.12.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static var shared: RealmManager = RealmManager()
    private(set) var stocks: [Stock] = []
    private(set) var localRealm: Realm?
    
//    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.stocks.forEach { item in
//                self.updateStock(item.code, price: 99.99)
//            }
//        }
//    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Do something, usually updating the schema's variables here
                }
            })
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func addStocks(_ stocks: [String]) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    
                    stocks.forEach { stockCode in
                        let stock = Stock()
                        stock.price = Double.random(in: 0...100)
                        stock.code = stockCode
                        stock.inWatchlist = false
                        localRealm.add(stock)
                    }
                    
                    print("Added all stocks to Realm!")
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func getStocks() {
        if let localRealm = localRealm {
            let allStocks = localRealm.objects(Stock.self)
            allStocks.forEach { stock in
                stocks.append(stock)
            }
        }
    }
    
    func updateStock(_ code: String, price: Double? = nil, inWatchlist: Bool? = nil) -> Stock {
        
        var updated: Stock? = nil
        
        if let localRealm = localRealm {
            let stocks = localRealm.objects(Stock.self).filter("code = %@", code)
            if let stockToUpdate = stocks.first {
                try! localRealm.write {
                    if let inWatchlist = inWatchlist {
                        stockToUpdate.inWatchlist = inWatchlist
                    }
                    
                    if let price = price {
                        stockToUpdate.price = price
                    }
                }
                updated = stockToUpdate
            }
        }
        
        if let row = self.stocks.firstIndex(where: { $0.code == updated?.code }), let updated = updated {
            self.stocks[row] = updated
        }
        
        return updated! // TODO: Here is not safe.
    }
}
