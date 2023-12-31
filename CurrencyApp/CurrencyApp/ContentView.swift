//
//  ContentView.swift
//  CurrencyApp
//
//  Created by Динар Шамсутдинов on 15.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State var state = ScreenState.loading
    @State var mainCurrency = "usd"
    
    let api = Api()
    let storage = Storage()
    
    func sectionTitle(data: ExchangeData) -> String {
        "\(mainCurrency) \(NSLocalizedString("subtitle", comment: "")) \(data.date)"
    }
    
    func refresh() {
        state = .loading
        api.getData(currency: mainCurrency) { result in
            switch result {
            case .success(let data):
                state = .data(data: data)
                storage.save(currency: mainCurrency)
            case .failure(let description): 
                state = .error(description: description)
            }
        }
    }
    
    var body: some View {
        MyNavigation {
            switch state {
            case .loading: Text("Loading...").padding()
            case .error(let description): VStack {
                Text("Error happened :(((")
                Text(description)
            }.padding()
            case .data(let data): List {
                Section(sectionTitle(data: data)) {
                    ForEach(data.exchange, id: \.name) { exchange in
                        HStack {
                            Text(exchange.name)
                            Spacer()
                            Text("\(exchange.coefficient)")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            mainCurrency = exchange.name
                            refresh()
                        }
                    }
                }
            }.navigationTitle("Currency App").toolbar {
                Button("Refresh") {
                    refresh()
                }
            }
                
            }
        }
        .onAppear {
            let currency = storage.load()
            if currency == nil {
                mainCurrency = "usd"
            } else {
                mainCurrency = currency!
            }
            refresh()
        }
    }
}

#Preview {
    ContentView()
}

struct MyNavigation<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
