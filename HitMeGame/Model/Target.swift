//
//  Target.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Cocoa

protocol TargetDelegate: AnyObject {
    func updatedValue(_ target: Target)
}

class Target: Player {
    enum HoleType {
        case circle, square
    }
    
    override var color: NSColor {
        didSet { targetDelegate?.updatedValue(self) }
    }
    
    var holeType: HoleType = .circle {
        didSet { targetDelegate?.updatedValue(self) }
    }
    
    weak var targetDelegate: TargetDelegate?
    
    init(color: NSColor, size: CGSize, speed: Int, holeType: HoleType) {
        super.init(color: color, size: size, speed: speed)
        self.holeType = holeType
    }
    
    convenience init() {
        self.init(color: NSColor.clear, size: CGSize(width: 100, height: 75), speed: 5, holeType: .circle)
    }
}

