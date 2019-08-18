//
//  StatefulCollectionView+UIView.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

internal protocol ConstraintsUtility {
  
  /// Pins the view edges to its container view edges.
  func pinView(_ view: UIView, toContainer container: UIView)
  
  /// Add center (horizontal+vertical) constraints to the view to its container.
  func centerView(_ view: UIView, inContainer container: UIView)
  
  /// Add horizontal center constraint to the view to its container.
  func centerViewHorizontally(_ view: UIView, inContainer container: UIView)
  
  /// Add vertical center constraints to the view to its container.
  func centerViewVertically(_ view: UIView, inContainer container: UIView)
  
  /// Apply constraints to view attributes
  func apply(_ attributes: [NSLayoutConstraint.Attribute],
             ofView childView: UIView, toView containerView: UIView)
  
  /// Add width constraints to its superview
  func setWidthConstraintToCurrent()

  /// Add height constraints to its superview
  func setHeightConstraintToCurrent()
}

extension UIView: ConstraintsUtility {
  
  func pinView(_ view: UIView, toContainer container: UIView) {
    let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
    apply(attributes, ofView: view, toView: container)
  }
  
  func centerView(_ view: UIView, inContainer container: UIView) {
    let attributes: [NSLayoutConstraint.Attribute] = [.centerX, .centerY]
    apply(attributes, ofView: view, toView: container)
  }
  
  func centerViewHorizontally(_ view: UIView, inContainer container: UIView) {
    apply([.centerX], ofView: view, toView: container)
  }
  
  func centerViewVertically(_ view: UIView, inContainer container: UIView) {
    apply([.centerY], ofView: view, toView: container)
  }
  
  func apply(_ attributes: [NSLayoutConstraint.Attribute],
             ofView childView: UIView, toView containerView: UIView) {
    let constraints = attributes.map {
      return NSLayoutConstraint(item: childView, attribute: $0, relatedBy: .equal,
                                toItem: containerView, attribute: $0, multiplier: 1, constant: 0)
    }
    containerView.addConstraints(constraints)
  }
  
  func setWidthConstraintToCurrent() {
    setWidthConstraint(bounds.width)
  }
  
  func setHeightConstraintToCurrent() {
    setHeightConstraint(bounds.height)
  }
  
  func setWidthConstraint(_ width: CGFloat) {
    addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil,
                                     attribute: .notAnAttribute, multiplier: 1, constant: width))
  }
  
  func setHeightConstraint(_ height: CGFloat) {
    addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil,
                                     attribute: .notAnAttribute, multiplier: 1, constant: height))
  }
}
