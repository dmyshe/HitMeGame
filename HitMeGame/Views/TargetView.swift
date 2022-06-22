//
//  TargetView.swift
//  HitMeGame
//
//  Created by Дмитро  on 11/05/22.
//

import Cocoa

final class TargetView: NSView {
    
    var target = Target()
    
    var hole = HoleFigure()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        target.targetDelegate = self
        hole.configure(with: self)
        configureView()
        configureHole()
    }

    private func configureView() {
        self.layer?.backgroundColor = target.color.cgColor
        self.frame.size = target.size
    }
    
    private func configureHole() {
        let top =  CGRect(origin: CGPoint(x: self.bounds.minX + self.bounds.size.width / 4, y: self.bounds.minY + self.bounds.height / 4), size: CGSize(width: self.bounds.width / 2, height: self.bounds.height / 2))
        
        switch target.holeType {
        case .circle:
           hole.createHole(with: .circle, atPosition: top)
            
        case .square:
          hole.createHole(with: .square, atPosition: top)
        }
    }
}

// MARK: - TargetDelegate
extension TargetView: TargetDelegate {
    func updatedValue(_ target: Target) {
        self.needsDisplay = true
    }
}


