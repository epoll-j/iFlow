//
//  DetailTitle.swift
//  debugger
//
//  Created by dubhe on 2024/4/26.
//

import SwiftUI

struct DetailTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    DetailTitle(title: "title")
}
