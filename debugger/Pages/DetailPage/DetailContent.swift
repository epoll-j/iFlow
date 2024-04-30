//
//  DetailContent.swift
//  debugger
//
//  Created by dubhe on 2024/4/26.
//

import SwiftUI

struct DetailContent: View {
    
    var title: String?
    var content: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
                .shadow(radius: 0.5)
            VStack(alignment: .leading) {
                if let title = title {
                    Text(title).font(.title2).bold()
                }
                Text(content).font(.body).foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        
    }
}

#Preview {
    DetailContent(content: "content")
}
