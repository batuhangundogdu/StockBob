//
//  StockListViewModel.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 30.12.2021.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftUI
import Combine

class StockListViewModel: ObservableObject {
    
    @Published var items: [Stock] = []
    
    private let datasource = MockDataSource()
    private let disposeBag = DisposeBag()
    
    func getData() {
        datasource.getStocks()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] items in
                    self?.items = items
                }
            )
            .disposed(by: self.disposeBag)
    }
    
    func addToWatchlist(_ stock: Stock) {
        datasource.updateStock(stock: stock, inWatchlist: true)
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
}
