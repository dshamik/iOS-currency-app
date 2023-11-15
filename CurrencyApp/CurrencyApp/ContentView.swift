//
//  ContentView.swift
//  CurrencyApp
//
//  Created by Динар Шамсутдинов on 15.11.2023.
//

import SwiftUI

struct ContentView: View {
    let api = Api()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            api.getData(currency: "rub")
        }
    }
}

#Preview {
    ContentView()
}
