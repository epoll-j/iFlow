//
//  ItemDetailPage.swift
//  debugger
//
//  Created by dubhe on 2024/4/12.
//

import SwiftUI

struct ItemDetailPage: View {
    @State private var selection = "消息头"
    private let tabList = ["消息头", "参数", "响应", "耗时"]
    var body: some View {
        VStack {
            HStack {
                ForEach(tabList, id:\.self) { item in
                    Spacer()
                    Text(item)
                        .font(.system(size: 16))
                        .padding(.horizontal, 15)
                        .foregroundColor(selection == item ? .blue : .black)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selection = item
                            }
                        }
                    Spacer()
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            .background(.white)
            
            TabView(selection: $selection) {
                HeaderDetail()
                    .tag("消息头")
                ParamDetail()
                    .tag("参数")
                ResponseDetail()
                    .tag("响应")
                ResponseDetail()
                    .tag("耗时")
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    ItemDetailPage()
}

