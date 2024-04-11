//
//  ItemListPage.swift
//  debugger
//
//  Created by dubhe on 2024/4/11.
//

import SwiftUI

struct ItemListPage: View {
    let items = ["1", "2", "3"]
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                
                VStack(spacing: 10) {
                    HStack() {
                        Text("www.baidu.com").font(.body).bold()
                        Spacer()
                        Text("/query")
                    }
                    .frame(maxWidth: .infinity)
                    HStack() {
                        Text("GET").font(.body).bold()
                        Text("200").font(.body).foregroundStyle(.green).bold()
                        Spacer()
                        Text("2020-01-02 22:22:22").font(.body).foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    HStack() {
                        Text("#1").font(.body).bold()
                        Spacer()
                        Text("JSON").font(.body).bold()
                        Text("1mb")
                        Text("1ms")
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ItemListPage()
}
