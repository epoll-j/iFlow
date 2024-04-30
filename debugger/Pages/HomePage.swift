//
//  HomePage.swift
//  debugger
//
//  Created by dubhe on 2024/4/11.
//

import SwiftUI


struct HomePage: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CardView(buttons: [CardButtonModel(text: "123", page: AnyView(HistoryPage()), action: {
                    
                }), CardButtonModel(text: "444", action: {
                    
                })])
            }
            .padding(.horizontal, 24)
            .padding(.top, 40)
        }.background(Color.backgroundColor.edgesIgnoringSafeArea([.horizontal, .bottom]))
    }
}

fileprivate struct CardButtonModel {
    var text: String
    var page: AnyView?
    var action: () -> Void
}


fileprivate struct CardView: View {
    
    var buttons: [CardButtonModel]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
                .shadow(radius: 0.5)
            VStack(alignment: .trailing, spacing: 25) {
                Toggle(isOn: .constant(true), label: {
                    HStack {
                        Image(systemName: "bell")
                        VStack(alignment: .leading) {
                            Text("MIMT").font(.title2).bold()
                            Text("djfasfadsf").font(.body).foregroundStyle(.gray)
                        }
                    }
                })
                HStack {
                    ForEach(0..<buttons.count, id: \.self) { index in
                        Button(action: buttons[index].action) {
                            NavigationLink {
                                buttons[index].page
                            } label: {
                                Text(buttons[index].text)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(Color(red: 241 / 255, green: 243 / 255, blue: 247 / 255))
                        .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
        .frame(height: 150) // 你可以根据需要调整卡片的大小
    }
}


#Preview {
    HomePage()
}
