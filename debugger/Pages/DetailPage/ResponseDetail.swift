//
//  ResponseDetail.swift
//  debugger
//
//  Created by dubhe on 2024/4/29.
//

import SwiftUI

struct ResponseDetail: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                DetailTitle(title: "预览")
                DetailContent(title: "123", content: "456")
                DetailContent(content: "666")
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
        }.background(Color.backgroundColor.edgesIgnoringSafeArea([.horizontal, .bottom]))
    }
}

#Preview {
    ResponseDetail()
}
