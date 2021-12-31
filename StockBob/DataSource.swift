//
//  DataSource.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 29.12.2021.
//

import Foundation
import RxSwift
import SwiftUI

protocol DataSource {
    func getStocks() -> Observable<[Stock]>
    func getFavStocks() -> Observable<[Stock]>
    func getStockDetails(for stockCodes: [String]) -> Observable<[Stock]>
    func updateStock(stock: Stock, price: Double?, inWatchlist: Bool?) -> Observable<Stock>
}

class MockDataSource: DataSource {
    
    func getStocks() -> Observable<[Stock]> {
        return Observable.just(RealmManager.shared.stocks)
    }
    
    func getFavStocks() -> Observable<[Stock]> {
        return Observable.just(RealmManager.shared.stocks.filter { $0.inWatchlist })
    }
    
    func getStockDetails(for stockList: [String]) -> Observable<[Stock]> {
        
        var stocks: [Stock] = []
        let allSstocks = RealmManager.shared.stocks
        
        stockList.forEach { requestedStock in
            if let stck = allSstocks.first(where: { $0.code == requestedStock }) {
                stocks.append(stck)
            }
        }
        
        return Observable.just(stocks)
    }
    
    func updateStock(stock: Stock, price: Double? = nil, inWatchlist: Bool? = nil) -> Observable<Stock> {
        let updated = RealmManager.shared.updateStock(stock.code, inWatchlist: inWatchlist)
        return Observable.just(updated)
    }
}

//class NetworkDataSource: DataSource {
//
//    private func getData<T: Codable>(url: String, type: T.Type) -> Observable<T> {
//        guard let url = URL(string: url) else {
//            return Observable.error(URLError(URLError.Code.badURL))
//        }
//
//        var request = URLRequest(url: url)
//        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad // Use cache for temporary persistence
//
//        return URLSession.shared.rx.data(request: request)
//            .subscribeOn(SerialDispatchQueueScheduler(qos: .utility))
//            .map { data in try JSONDecoder().decode(type, from: data) }
//    }
//}
