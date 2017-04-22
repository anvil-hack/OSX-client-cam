//
//  SocketManager.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa
import SocketIO

class SocketManager {

    static let shared = SocketManager()
    private let socket = SocketIOClient(socketURL: URL(string: "http://localhost:4242")!,
                                        config: [.log(true),
                                                 .forcePolling(true)])

    func start() {
        socket.on("connected") { _, _ in
            print("connection socket ok")
        }
        socket.on("hello") { data, _ in
            print("get data hello")
            guard let name = data.first as? String else {return}
            let message = "Hello \(name)"
            print("message : \(message)")
            SpeechText.shared.start(text: message)
        }
        socket.connect()
    }

    func stop() {
        socket.disconnect()
    }
}
