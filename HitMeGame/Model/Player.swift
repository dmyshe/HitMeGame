//
//  Player.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Cocoa

protocol PlayerDelegate: AnyObject {
    func colorDidChange(_ player: Player)
}

class Player {
    
    var color: NSColor {
        didSet { playerDelegate?.colorDidChange(self) }
    }
    
    private(set) var colorInLevel: NSColor
    
    var size: CGSize 
    var speed: Int
    
    weak var playerDelegate: PlayerDelegate?
    
    init(color: NSColor, size: CGSize, speed: Int) {
        self.color = color
        self.colorInLevel = color
        self.size = size
        self.speed = speed
    }
    
    convenience init() {
        self.init(color: NSColor.clear, size: CGSize(width: 100, height: 75), speed: 5)
    }
}
