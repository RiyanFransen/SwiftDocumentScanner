//
//  VisionImageRectangleDetector.swift
//  DocumentScanner
//
//  Created by Jonas Beckers on 25/02/18.
//

import Foundation

import UIKit
import Vision

@available(iOS 11.0, *)
public final class VisionImageRectangleDetector: ImageRectangleDetector {

	private var completionHandler: Completion?

	public var roi: CGRect

	public init(roi: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) {
		self.roi = roi
	}

	public func detect(image: UIImage, completion: @escaping Completion) {
		guard let cgImage = image.cgImage else { return }

		let request = VNDetectRectanglesRequest(completionHandler: handleRequest)
		request.quadratureTolerance = 45
		request.minimumAspectRatio = VNAspectRatio(0.6)
		request.minimumAspectRatio = VNAspectRatio(0.7)
		request.maximumObservations = 1
		request.regionOfInterest = roi

		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

		do {
			completionHandler = completion
			try handler.perform([request])
		} catch {
			print(error)
		}
	}

	@available(iOS 11.0, *)
	private func handleRequest(request: VNRequest, error: Error?) {
		guard let observations = request.results as? [VNRectangleObservation] else { return }
		let sortedByConfidence = observations.sorted { $0.confidence > $1.confidence }

		if let observation = sortedByConfidence.first {
			let quad = Quad(obvservation: observation)

			DispatchQueue.main.async { [weak self] in
				self?.completionHandler?(quad)
			}
		} else {
			DispatchQueue.main.async { [weak self] in
				self?.completionHandler?(nil)
			}
		}
	}

}
