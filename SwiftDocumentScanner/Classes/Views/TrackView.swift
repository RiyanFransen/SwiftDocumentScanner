//
//  TrackView.swift
//  DocumentScanner
//
//  Created by Jonas Beckers on 25/02/18.
//

import UIKit

public final class TrackView: UIView {

	public static var lineColor: UIColor = UIColor(red:1.00, green:0.49, blue:0.49, alpha:1.0)
	public static var fillColor: UIColor = UIColor(red:0.44, green:0.30, blue:0.89, alpha:0.3)
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
			let roundedPath = UIBezierPath(roundedRect: path.bounds, cornerRadius: 10)
			shape.path = roundedPath.cgPath
		} else {
			shape.path = nil
		}
	}

}
