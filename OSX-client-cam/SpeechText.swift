//
//  SpeechText.swift
//  OSX-client-cam
//
//  Created by Remi Robert on 22/04/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

import Cocoa

class SpeechText {

    static let shared = SpeechText()
    private var speech: NSSpeechSynthesizer?

    init() {
        speech = NSSpeechSynthesizer(voice: "com.apple.speech.synthesis.voice.alice")
        speech?.rate = 60
    }

    func start(text: String) {
        guard let speech = self.speech else {return}
        if speech.isSpeaking {
            speech.stopSpeaking()
        }
        speech.startSpeaking(text)
    }
}
