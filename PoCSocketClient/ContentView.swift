//
//  ContentView.swift
//  PoCSocketClient
//
//  Created by Fabio Pereira on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            if viewModel.loading {
                ProgressView()
            } else {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)

                    Text("Hello, world!")
                    Text(viewModel.value)
                }
                .padding()
            }
        }
        .padding()
        .task {
            viewModel.send()
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel(socketManager: SocketClientManagerMock()))
}
