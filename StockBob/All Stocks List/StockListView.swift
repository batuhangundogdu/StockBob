//
//  StockListView.swift
//  StockBob
//
//  Created by Batuhan GÜNDOĞDU on 30.12.2021.
//

import SwiftUI

struct StockListView: View {
    
    @ObservedObject var viewmodel = StockListViewModel()
    @Environment(\.dismiss) var dismiss
    var updateHandler: (() -> Void)?
    
    var body: some View {
        VStack {
            List(viewmodel.items) { item in
                HStack {
                    Text(item.code)
                    Spacer()
                    
                    if item.inWatchlist {
                        Button {
                            viewmodel.removeFromWatchlist(item)
                        } label: {
                            Text("Remove")
                                .foregroundColor(.red)
                        }
                    } else {
                        Button {
                            viewmodel.addToWatchlist(item)
                        } label: {
                            Text("Add")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            
            Button {
                dismiss()
                updateHandler?()
            } label: {
                Text("Done")
            }
            
        }
        .onAppear {
            viewmodel.getData()
        }
    }
}

//struct StockListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StockListView()
//    }
//}
