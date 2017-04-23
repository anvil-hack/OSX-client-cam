//
//  AppDelegate.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa
import AVFoundation

let baseUrl = "http://127.0.0.1:4242"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        SocketManager.shared.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        SocketManager.shared.stop()
    }
}

