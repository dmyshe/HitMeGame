//
//  GameStatusInfo.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Cocoa

final class GameInfo: NSView {
    
    var game = Game()
    
    // MARK: - IBOutlets
    @IBOutlet weak var roundLabel: NSTextField!
    @IBOutlet weak var scoreLabel: NSTextField!
    @IBOutlet weak var timeLeftLabel: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        game.gameInfoDelegate = self
        self.layer?.backgroundColor = !game.isPaused ? .lightGray : .darkGray
        setupLabels()
    }
    
    private func setupLabels() {
        roundLabel.stringValue = "\(game.round)"
        scoreLabel.stringValue = "\(game.score)"
        timeLeftLabel.stringValue = "\(game.timeLeft) sec"
    }
}

extension GameInfo {
    override func mouseDown(with event: NSEvent) {
        let point: NSPoint = event.locationInWindow
        let clickedView = self.hitTest(point)
        
        if (clickedView as? GameInfo) != nil {
            game.isPaused.toggle()
            game.score += 1
        }
    }
}

// MARK: - GameDelegate
extension GameInfo: GameInfoDelegate {
    func gameInfoUpdated(_ game: Game) {
        self.needsDisplay = true
    }
}

private extension CGColor {
    static let lightGray = NSColor(named: NSColor.Name("menuBackgroundColor"))?.cgColor
    static let darkGray = NSColor.darkGray.cgColor
}
