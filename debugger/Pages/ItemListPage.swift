//
//  ItemListPage.swift
//  debugger
//
//  Created by dubhe on 2024/4/11.
//

import SwiftUI
import RealmSwift
import ProxyService

struct DetailItem: Identifiable {
    let id = UUID()
    let name: String
}

struct ItemListPage: View {

    let taskId: String
    @ObservedResults(SessionModel.self) var sessions
    @State private var selectedItem: DetailItem?
    
    init(taskId: String) {
        self.taskId = taskId
    }
    
    var body: some View {
        List {
            ForEach(sessions.where(({$0.taskId == self.taskId})), id: \.self) { item in
                VStack(spacing: 10) {
                    HStack() {
                        Text(item.host!).lineLimit(1).truncationMode(.middle).font(.body).bold()
                        Spacer(minLength: 30)
                        Text(item.uri!).lineLimit(1).truncationMode(.middle)
                    }
                    .frame(maxWidth: .infinity)
                    HStack() {
                        Text(item.methods ?? "-").font(.body)
                        Text(item.httpCode ?? "-").font(.body).foregroundStyle(_getHttpCodeColor(item))
                        Spacer()
                        Text(item.startTime?.formattedDate() ?? "-").font(.body).foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    HStack() {
                        Text("#\(item.id.prefix(4))").font(.footnote).foregroundStyle(.gray)
                        Spacer()
                        Text(item.suffix ?? "-").font(.body)
                        Text(_getFlowText(item))
                        Text(_getTimeText(item))
                    }
                    .frame(maxWidth: .infinity)
                }
                .onTapGesture {
                    self.selectedItem = DetailItem(name: "")
                }
                .frame(maxWidth: .infinity)
                .sheet(item: self.$selectedItem) { item in
                    ItemDetailPage()
                }
            }
        }
    }
    
    private func _getFlowText(_ item: SessionModel) -> String {
        let units = ["b", "kb", "mb", "gb"]
        var unitIndex = 0
        var byte = item.downloadFlow
        while (byte >= 1024 && unitIndex < units.count - 1) {
            byte /= 1024;
            unitIndex += 1;
        }
        return "\(byte)\(units[unitIndex])"
    }
    
    private func _getHttpCodeColor(_ item: SessionModel) -> any ShapeStyle {
        if (item.httpCode == nil) {
            return .red
        }
        if (item.httpCode!.starts(with: "2")) {
            return .green
        }
        if (item.httpCode!.starts(with: "3")) {
            return .blue
        }
        
        return .red
    }
    
    private func _getTimeText(_ item: SessionModel) -> String {
        if (item.startTime == nil || item.endTime == nil) {
            return "-"
        }
        let total = item.endTime! - item.startTime!
        return "\(Int(total))ms"
    }
}

#Preview {
    ItemListPage(taskId: "")
}
