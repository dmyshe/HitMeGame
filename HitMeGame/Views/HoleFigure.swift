//
//  HoleFigure.swift
//  HitMeGame
//
//  Created by Дмитро  on 12/05/22.
//

import Cocoa

final class HoleFigure: NSView {
    
     enum HoleType {
        case circle, square
    }
    
    private weak var view: NSView?
    
    var figureHole: NSBezierPath!
    
    func configure(with view: NSView) {
        self.frame = view.bounds
        self.view = view
    }
    
    func createHole(with figure: HoleType, atPosition rect: CGRect ) {
        switch figure {
        case .circle:
            figureHole =  NSBezierPath(ovalIn: rect)
            createShapeLayer(with: figureHole)
            
        case .square:
            figureHole = NSBezierPath(rect: rect)
            createShapeLayer(with: figureHole)
        }
    }
    
    private func createShapeLayer(with holeFigure: NSBezierPath) {
        guard let view = view else { return }
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        let path = NSBezierPath(rect: view.bounds)
        path.append(holeFigure)
        shapeLayer.fillRule = .evenOdd
        shapeLayer.path = path.cgPath
        view.layer?.mask = shapeLayer
    }
}
