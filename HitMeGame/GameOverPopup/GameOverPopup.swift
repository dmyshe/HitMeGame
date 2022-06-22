//
//  GameOverPopup.swift
//  HitMeGame
//
//  Created by Дмитро  on 12/05/22.
//

import Cocoa

class GameOverPopup: NSViewController {

    @IBOutlet var label: NSTextField!
    
    @IBAction func dismiss(_ sender: NSButton) {
        dismiss(self)
    }
}
