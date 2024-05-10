//
//  PoCSocketClientApp.swift
//  PoCSocketClient
//
//  Created by Fabio Pereira on 25/04/24.
//

import SwiftUI

@main
struct PoCSocketClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(socketManager: SocketClientManagerMock()))
        }
    }
}
