//
//  HistoryPage.swift
//  debugger
//
//  Created by dubhe on 2024/4/11.
//

import SwiftUI
import ProxyService
import RealmSwift

struct HistoryPage: View {
    @ObservedResults(TaskModel.self) var tasks
    
    var body: some View {
        List {
            ForEach(tasks, id: \.self) { item in
                NavigationLink {
                    ItemListPage(taskId: item.id)
                        .navigationBarTitle("#\(item.id.prefix(4))", displayMode: .large)
                } label: {
                    VStack(spacing: 20) {
                        HStack() {
                            Text("#\(item.id.prefix(4))").font(.body).bold()
                            Spacer()
                            Text("\(item.startTime.formattedDate())")
                        }
                        .frame(maxWidth: .infinity)
                        HStack() {
                            Text("\(item.sessionsCount)个请求").font(.body).foregroundStyle(.gray)
                            Spacer()
                            Text("持续时间: \(item.stopTime)").foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                    }.frame(maxWidth: .infinity)
                }
            }
            .onDelete(perform: _deleteItems)
        }.navigationBarTitle(Text("历史记录"), displayMode: .large)
    }
    
    private func _deleteItems(offsets: IndexSet) {
        for index in offsets {
            tasks[index].removeAllSessions()
        }
        withAnimation {
            $tasks.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    HistoryPage()
}
