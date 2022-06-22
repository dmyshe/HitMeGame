//
//  PlayerView.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Cocoa

final class PlayerView: NSView {
    
    var player = Player()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        player.playerDelegate = self 
        configureView()
    }
    
    private func configureView() {
        self.layer?.backgroundColor = player.color.cgColor
        self.frame.size = player.size
    }
}

//MARK: - PlayerDelegate
extension PlayerView: PlayerDelegate {
    func colorDidChange(_ player: Player) {
        self.needsDisplay = true
    }
}
