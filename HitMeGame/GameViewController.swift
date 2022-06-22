//
//  ViewController.swift
//  HitMeGame
//
//  Created by Дмитро  on 10/05/22.
//

import Cocoa

class GameViewController: NSViewController {

    var game = Game()
    
    // MARK: - IBOutlets
    @IBOutlet weak var targetView: TargetView!
    @IBOutlet weak var playerView: PlayerView!
    
    @IBOutlet weak var gameInfoView: GameInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGame()
        setupTimer()
//        animateTarget()
    }
        
    private func prepareGame() {
        gameInfoView.game = game
        game.gameStatusDelegate = self
        
        guard let player = game.player, let target = game.target else { return }
        playerView.player = player
        targetView.target = target
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.game.timeLeft != 0 && !self.game.isPaused  {
                self.game.timeLeft -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func animateTarget() {
        targetView.wantsLayer = true
        
        NSAnimationContext.runAnimationGroup { [weak self] context in
                guard let self = self else { return }
                let newOrigin = peekNewOriginForTarget()
                let duration = self.vectorLength(from: self.targetView.frame.origin, to: newOrigin) / Double(self.game.target!.speed)
                context.duration = duration
            context.timingFunction = CAMediaTimingFunction(name: .linear)
                self.targetView.animator().frame.origin = newOrigin
            }
        }
        
        private func vectorLength(from: CGPoint, to: CGPoint) -> Double {
            let deltaX = to.x - from.x
            let deltaY = to.y - from.y
            return sqrt(deltaX * deltaX + deltaY * deltaY)
        }
        
        private func peekNewOriginForTarget() -> CGPoint {
            let originY = Int(self.view.frame.origin.y + self.gameInfoView.frame.height)
            let x = Int.random(in: (0...Int(self.view.frame.maxX - self.targetView.frame.width)))
            let y = Int.random(in: (originY...Int((self.view.frame.maxY - self.targetView.frame.height))))
            return CGPoint(x: x, y: y)
        }
}

extension GameViewController {
    override func mouseDown(with event: NSEvent) {
        let windowPoint = event.locationInWindow
        let targetPoint = targetView.convert(event.locationInWindow, from: nil)
        
        if  targetView.hole.figureHole.contains(targetPoint) &&  playerView.frame.contains(windowPoint) {
            game.score += 1
            return
        }
        
        if playerView.frame.contains(windowPoint) && targetView.frame.contains(windowPoint) {
            return
        }
        if playerView.frame.contains(windowPoint) {
            game.score -= 1
        }
    }
}

// MARK: - GameStatusDelegate
extension GameViewController : GameStatusDelegate {
    func gameIsPaused(_ game: Game) {
        if !game.isPaused {
            setupTimer()
        }
    }
    
    func gameOver(_ game: Game) {
        let vc = GameOverPopup()
        vc.label?.stringValue = "You lose"
        presentAsSheet(vc)
        print("gameOver")
    }
}


