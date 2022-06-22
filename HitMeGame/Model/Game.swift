//
//  Game.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Foundation

protocol GameInfoDelegate: AnyObject {
    func gameInfoUpdated(_ game: Game)
}

protocol GameStatusDelegate: AnyObject {
    func gameIsPaused(_ game: Game)
    func gameOver(_ game: Game)
}

class Game {
    
    var round = 1 {
        didSet { gameInfoDelegate?.gameInfoUpdated(self) }
    }
    
    private var lastRound: Bool {
        round > 2
    }
    
    var score = 0 {
        didSet {
            checkIfGameOver()
            gameInfoDelegate?.gameInfoUpdated(self)
        }
    }
    
    var timeLeft = 5 {
        didSet {
            checkIfGameOver()
            gameInfoDelegate?.gameInfoUpdated(self)
        }
    }
    
    var isPaused = false {
        didSet {
            setColorForPlayerAndTarget()
            gameStatusDelegate?.gameIsPaused(self)
        }
    }
    
    var player: Player?
    var target: Target?
    
    weak var gameInfoDelegate: GameInfoDelegate?
    weak var gameStatusDelegate: GameStatusDelegate?
    
    init() {
        createNewRound()
    }
    
    public func createNewRound() {
        switch round {
        case 1:
            player = Player(color: .systemBlue, size: CGSize(width: 100, height: 75), speed: 30)
            target = Target(color: .systemYellow, size: CGSize(width: 150, height: 75), speed: 1, holeType: .circle)
            
        case 2:
            player?.color = .systemPink
            target?.holeType = .square
            timeLeft = 10
            
        case 3:
            gameStatusDelegate?.gameOver(self)
            print("3 round")
            
        default:
            print("undefined")
        }
    }
    
    private func checkIfGameOver() {
        if lastRound && timeLeft == 0 || score < 0 {
            isPaused = true
            gameStatusDelegate?.gameOver(self)
        } else if timeLeft == 0  {
            round += 1
            createNewRound()
        }
    }
    
    private func setColorForPlayerAndTarget() {
        if isPaused {
            player?.color = .gray
            target?.color = .gray
        } else {
            player?.color = player!.colorInLevel
            target?.color = target!.colorInLevel
        }
    }
}
