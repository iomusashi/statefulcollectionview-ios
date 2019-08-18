//
//  StatefulCollectionView+ContentManagement.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

/**
 Protocol that should enforce the default content for collectionView states.
 */
internal protocol StatefulCollectionViewContentManagement {
  
  var viewForInitialLoad: UIView { get }
  
  func resetDynamicContentView(withChildView childView: UIView?)
  func viewForEmptyInitialLoad(withError errorOrNil: NSError?) -> UIView
}

extension StatefulCollectionView: StatefulCollectionViewContentManagement {
  
  internal var viewForInitialLoad: UIView {
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    activityIndicatorView.startAnimating()
    guard let customization = customization else {
      return activityIndicatorView
    }
    return customization.statefulCollection(self, viewForInitialLoad: activityIndicatorView)
  }

  internal func resetDynamicContentView(withChildView childView: UIView?) {
    dynamicContentView.subviews.forEach { $0.removeFromSuperview() }
    guard let childView = childView else { return }
    
    dynamicContentView.addSubview(childView)
    childView.translatesAutoresizingMaskIntoConstraints = false
    pinView(childView, toContainer: dynamicContentView)
  }
  
  internal func viewForEmptyInitialLoad(withError errorOrNil: NSError?) -> UIView {
    let errorView = InitialLoadErrorView(error: errorOrNil, delegate: self)
    guard let customization = customization else { return errorView }
    return customization.statefulCollection(self,
                                            errorAtInitialLoad: errorOrNil,
                                            errorView: errorView)
  }
}

extension StatefulCollectionView: InitialLoadErrorViewDelegate {
  
  public func initialLoad(errorView: InitialLoadErrorView,
                          didTapErrorButton sender: UIButton) {
    triggerInitialLoad()
  }
}
