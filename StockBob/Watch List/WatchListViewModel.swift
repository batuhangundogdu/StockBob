//
//  WatchListViewModel.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 29.12.2021.
//

import Foundation
import RxSwift

class WatchListViewModel: ObservableObject {
    
    @Published var items: [Stock] = []
    
    private let datasource = MockDataSource()
    private let disposeBag = DisposeBag()
    
    func getStockDetails(for stocks: [String]) {
        datasource.getStockDetails(for: stocks)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] items in
                    self?.items = items
                }
            )
            .disposed(by: self.disposeBag)
    }
    
    func getFavStocks() {
        datasource.getFavStocks()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] items in
                    self?.items = items
                }
            )
            .disposed(by: self.disposeBag)
    }
    
    func removeFromWatchlist(_ stock: Stock) {
        datasource.updateStock(stock: stock, inWatchlist: false)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] itm in
                    if let row = self?.items.firstIndex(where: { $0.code == itm.code }) {
                        self?.items[row] = itm
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    func updateStockPrices() {
        
        items.forEach { item in
            datasource.updateStock(stock: item, price: Double.random(in: 10...100))
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] itm in
                        if let row = self?.items.firstIndex(where: { $0.code == itm.code }) {
                            self?.items[row] = itm
                        }
                    }
                )
                .disposed(by: disposeBag)
        }
    }
}
