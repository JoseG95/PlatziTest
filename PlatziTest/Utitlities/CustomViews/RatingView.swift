//
//  RatingView.swift
//  PlatziTest
//
//  Created by Jose Gutierrez on 08/03/21.
//

import Foundation
import UIKit

final class RatingView: UIView {
    private var progressLayer = CAShapeLayer()
    private var backgroundLayer = CAShapeLayer()
    
    private func makeCircularPath(value: Float) {
        let progressColor = value > 0.5 ? Colors.green : Colors.yellow
        let trackColor = value > 0.5 ? Colors.darkGreen : Colors.darkYellow
        
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2),
                                      radius: (frame.size.width) / 2, startAngle: CGFloat(-0.5 * .pi),
                                      endAngle: CGFloat(1.5 * .pi), clockwise: true)
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = trackColor.cgColor
        backgroundLayer.lineWidth = 4.0
        backgroundLayer.strokeEnd = 1.0
        layer.addSublayer(backgroundLayer)
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 4.0
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
    }
    
    private func setRatingLabel(rating: Int) {
        subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        let font = Fonts.ratingRegular
        let superFont = Fonts.ratingSuperscript
        let attributedString = NSMutableAttributedString(string: "\(rating)%",
                                                         attributes: [.font: font])
        attributedString.setAttributes([.font: superFont,
                                        .baselineOffset: 10],
                                       range: NSRange(location: String(rating).count, length: 1))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    func setProgressWithAnimation(duration: TimeInterval = 0.5, value: Float) {
        makeCircularPath(value: value)
        setRatingLabel(rating: Int(value * 100))
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
}
