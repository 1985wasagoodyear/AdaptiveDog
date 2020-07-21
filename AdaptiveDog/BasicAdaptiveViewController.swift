//
//  BasicAdaptiveViewController.swift
//  Created 7/16/20
//  Using Swift 5.0
// 
//  Copyright © 2020 yu. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

/*
 
 Inspired by this guy:
 https://stackoverflow.com/questions/25685829/programmatically-implementing-two-different-layouts-using-size-classes
 
 From this WWDC:
 https://developer.apple.com/videos/play/wwdc2016/222/
 
 */

import UIKit

class BasicAdaptiveViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let images: [UIImage] = {
        [
            UIImage(named: "dog"),
            UIImage(named: "ratatouille")
        ].compactMap { $0 }
    }()
    
    
    lazy var imageView: UIImageView = {
        let image = self.images.first
        let imageView = UIImageView(image: image)
        imageView.tag = 0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var  textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "I have no idea what I'm doing"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// constraints for landscape orientation
    private var compactConstraints: [NSLayoutConstraint] = []
    
    /// constraints for portrait orientation
    private var regularConstraints: [NSLayoutConstraint] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        buildConstraints()
        toggleConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        imageView.tag = (imageView.tag == 0) ? 1 : 0
        imageView.image = images[imageView.tag]
    }
    
    // MARK: - Setup Methods
    
    private func addSubviews() {
        view.addSubview(textLabel)
        view.addSubview(imageView)
    }
    
    private func buildConstraints() {
        let margin: CGFloat = 20.0
        
        regularConstraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: margin),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
        
        compactConstraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            imageView.trailingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -margin),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin),
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
        ]
        
        // will always be a square
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    
    // MARK: - Respond to Layout Changes
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        toggleConstraints()
    }
    
    /// enables the correct constraints for the current Size Class
    func toggleConstraints() {
        let sizeClass = (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass)
        
        // activate the constraints for the designated size class
        switch sizeClass {
        case (.compact, .regular):
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        case (.compact, .compact):
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        case (.regular, .compact):
            fallthrough
        case (.regular, .regular):
            fallthrough
        default:
            print("unhandled size class: \(sizeClass)")
        }
    }


}

