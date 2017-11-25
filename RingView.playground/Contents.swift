//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


class AnimatedRingView: UIView {
    private static let animationDuration = CFTimeInterval(2)
    private let π = CGFloat.pi
    private let startAngle = 1.5 * CGFloat.pi
    private let strokeWidth = CGFloat(8)
    var proportion = CGFloat(0.5) {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = self.strokeWidth
        self.layer.addSublayer(circleLayer)
        return circleLayer
    }()
    
    private lazy var ringlayer: CAShapeLayer = {
        let ringlayer = CAShapeLayer()
        ringlayer.fillColor = UIColor.clear.cgColor
        ringlayer.strokeColor = self.tintColor.cgColor
        ringlayer.lineCap = kCALineCapRound
        ringlayer.lineWidth = self.strokeWidth
        self.layer.addSublayer(ringlayer)
        return ringlayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = (min(frame.size.width, frame.size.height) - strokeWidth - 2)/2
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle + 2 * π, clockwise: true)
        circleLayer.path = circlePath.cgPath
        ringlayer.path = circlePath.cgPath
        ringlayer.strokeEnd = proportion
    }
    
    func animateRing(From startProportion: CGFloat, To endProportion: CGFloat, Duration duration: CFTimeInterval = animationDuration) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = startProportion
        animation.toValue = endProportion
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        ringlayer.strokeEnd = endProportion
        ringlayer.strokeStart = startProportion
        ringlayer.add(animation, forKey: "animateRing")
    }
    
}

let view = AnimatedRingView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
PlaygroundPage.current.liveView = view
view.animateRing(From: 0, To: 1)
PlaygroundPage.current.needsIndefiniteExecution = true




