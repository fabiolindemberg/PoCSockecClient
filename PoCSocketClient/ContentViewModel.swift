//
//  ContentViewModel.swift
//  PoCSocketClient
//
//  Created by Fabio Pereira on 25/04/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    var socketManager: SocketClientManagerDelegate
    @Published var value = ""
    @Published var loading = false

    init(socketManager: SocketClientManagerDelegate) {
        self.socketManager = socketManager
        self.socketManager.connect()
    }
    
    func connect() {
        socketManager.connect()
    }
    
    func send() {
        Task {
            self.loading = true
            self.value = await socketManager.send(command:"currentAmount")
            self.loading = false
        }
    }
}
