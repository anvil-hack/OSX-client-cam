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
    private let socket = SocketIOClient(socketURL: URL(string: baseUrl)!,
                                        config: [.log(true),
                                                 .forcePolling(true)])

    func start() {
        socket.on("connected") { _, _ in
            print("connection socket ok")
        }
        socket.on("speech") { data, _ in
            guard let message = data.first as? String else {return}
            SpeechText.shared.start(text: message)
        }
        socket.on("captureFrame") { _, _ in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "capture"), object: nil)
        }
        socket.connect()
    }

    func stop() {
        socket.disconnect()
    }
}
