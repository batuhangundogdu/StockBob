//
//  WatchListView.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 30.12.2021.
//

import SwiftUI

struct WatchListView: View {
    
//    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @ObservedObject var viewmodel = WatchListViewModel()
    @State private var showingSheet = false
//    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            if viewmodel.items.isEmpty {
                VStack {
                    Spacer()
                    Text("There is no favourite.")
                    Spacer()
                }
            } else {
                List(viewmodel.items) { item in
                    HStack {
                        Text(item.code)
                        Spacer()
                        Text("\(item.price)")
                    }
//                    .onTapGesture {
//                        showingAlert = true
//                    }
//                    .alert("Delete from watchlist ?", isPresented: $showingAlert) {
//                        Button("OK", role: .cancel) {
//                            showingAlert = false
//                            viewmodel.removeFromWatchlist(item)
//                            viewmodel.getFavStocks()
//                        }
//                    }
                    
                }
            }
            
            Spacer()
            
            Button {
                showingSheet.toggle()
            } label: {
                Text("Add")
            }
            .sheet(isPresented: $showingSheet) {
                StockListView(
                    updateHandler: {
                        viewmodel.getFavStocks()
                    }
                )
            }
        }
        .onAppear {
            viewmodel.getFavStocks()
        }
//        .onReceive(timer, perform: { _ in
//            viewmodel.updateStockPrices()
//            viewmodel.getFavStocks()
//        })
    }
}

//struct WatchListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchListView()
//    }
//}
