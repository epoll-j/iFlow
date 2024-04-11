//
//  HistoryPage.swift
//  debugger
//
//  Created by dubhe on 2024/4/11.
//

import SwiftUI

struct HistoryPage: View {
    let items = ["1", "2", "3"]
    
    var body: some View {
        
        List {
            ForEach(items, id: \.self) { item in
                NavigationLink {
                    ItemListPage()
                        .navigationBarTitle("#1", displayMode: .large)
                } label: {
                    VStack(spacing: 20) {
                        HStack() {
                            Text("#1").font(.body).bold()
                            Spacer()
                            Text("2022-02-03 23:22:11")
                            //                                Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                        .frame(maxWidth: .infinity)
                        HStack() {
                            Text("666个请求").font(.body).foregroundStyle(.gray)
                            Spacer()
                            Text("持续时间: 11分钟").foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity)
                }
            }
            .onDelete(perform: deleteItems)
        }.navigationBarTitle(Text("历史记录"), displayMode: .large)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                //                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HistoryPage()
}
