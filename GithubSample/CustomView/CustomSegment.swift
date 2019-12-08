//
//  CustomSegment.swift
//  GithubSample
//
//  Created by Ezhil Adhavan on 12/6/19.
//  Copyright © 2019 Ezhil. All rights reserved.
//

import Foundation
import UIKit

protocol SegmentValueChangedDelegate: NSObjectProtocol {
    func segmentValueChanged(segmentControl: UISegmentedControl)
}

class CustomSegment: UIView {
    
    weak var delegate: SegmentValueChangedDelegate?
    
    var customSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.backgroundColor = .clear
        control.tintColor = .clear
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .normal)
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .selected)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    var segmentItems: [String]! {
        didSet {
            guard segmentItems.count > 0 else { return }
            setupSegmentItems()
        }
    }
        
    var selectedItem: Int = 0 {
        didSet{
            customSegmentControl.selectedSegmentIndex = selectedItem
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(customSegmentControl)
        customSegmentControl.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        customSegmentControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        customSegmentControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customSegmentControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        customSegmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
    }
    
    private func setupSegmentItems() {
        for (index, value) in segmentItems.enumerated() {
            customSegmentControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        customSegmentControl.selectedSegmentIndex = 0
    }
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.segmentValueChanged(segmentControl: sender)
    }
}

