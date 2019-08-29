//
//  TrackView.swift
//  DocumentScanner
//
//  Created by Jonas Beckers on 25/02/18.
//

import UIKit

public final class TrackView: UIView {

	public static var lineColor: UIColor = .blue
	public static var fillColor: UIColor = UIColor.blue.withAlphaComponent(0.5)
	public static var lineWidth: CGFloat = 2

	private var shape = CAShapeLayer()
	private var updated: Double = 0

	override init(frame: CGRect) {
		super.init(frame: frame)

		setup()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setup()
	}

	private func setup() {
		shape.strokeColor = TrackView.lineColor.cgColor
		shape.fillColor = TrackView.fillColor.cgColor
		shape.lineWidth = TrackView.lineWidth
		shape.cornerRadius = 10

		layer.addSublayer(shape)
	}

	override public func layoutSubviews() {
		super.layoutSubviews()

		shape.frame = bounds
		shape.strokeColor = TrackView.lineColor.cgColor
		shape.fillColor = TrackView.fillColor.cgColor
		shape.lineWidth = TrackView.lineWidth
	}

	func update(path: UIBezierPath?) {
		if let path = path {
			let animation = CABasicAnimation(keyPath: "animate")
			animation.duration = CFTimeInterval(0.2)
			animation.fromValue = shape.path
			animation.toValue = path.cgPath

			shape.animation(forKey: "animate")
//			shape.path = path.cgPath
		} else {
			shape.path = nil
		}
	}

}
