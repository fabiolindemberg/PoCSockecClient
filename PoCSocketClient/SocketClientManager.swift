//
//  SocketManager.swift
//  PoCSocketClient
//
//  Created by Fabio Pereira on 25/04/24.
//

import Foundation
import SocketIO

protocol SocketClientManagerDelegate {
    func connect()
    func send(command: String) async -> String
}

class SocketClientManagerMock: SocketClientManagerDelegate {
    func connect() {
        print("Connected to mock")
    }
    
    func send(command: String) async -> String {
        return "Mock result"
    }
}

class SocketClientManager: SocketClientManagerDelegate {
    private static let webSocketURL: URL = URL(string:"https://echo.websocket.org/")!
    
    let manager = SocketManager(socketURL: webSocketURL)
    var socket: SocketIOClient!
    
    func connect() {
        self.socket = manager.defaultSocket
        
        self.socket.on(clientEvent: .connect) { data, ack in
            print("Soclet connected! \ndata:\(data) \nack: \(ack)")
        }
    }
    
    func send(command: String) async -> String {
        return await withCheckedContinuation { continuation in
            socket.on(command) { data, ack in
                guard let cur = data[0] as? Double else { return }
                    
                self.socket.emitWithAck("canUpdate", cur).timingOut(after: 0) { data in
                        if data.first as? String ?? "passed" == "" {
                            // Handle ack timeout
                            continuation.resume(returning: ack.description)
                        }
                        continuation.resume(returning: "amount \(String(describing: data.first))")
                        self.socket.emit("update", ["amount": cur + 2.50])
                }

                ack.with("Got your currentAmount", "dude")
                continuation.resume(returning: "Got your currentAmount, Dude")
            }
        }
    }
    
}
