//
//  StatefulCollectionViewCustomization.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

/**
 Protocol that exposes UI customization options for StatefulCollectionView.
 */
public protocol StatefulCollectionViewCustomization {
  
  /**
   Called when the collectionView is in need to load data initially.
   
   - Parameter collectionView: StatefulCollectionView instance
   - Parameter defaultView: UIActivityIndicatorView which you can freely return as is,
   or customize (change tintColor, etc); You may also opt to return a UIView subclass of your own.
   (ie. UIView that shows a GIF as a loader instead of the stock UIActivityIndicatorView).
   
   - Returns: The UIView to show during initial load.
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          viewForInitialLoad defaultView: UIActivityIndicatorView) -> UIView
  
  /**
   Called when the collectionView encountered an error after initial load.
   
   - Parameter collectionView: StatefulCollectionView instance.
   - Parameter errorAtInitialLoad: The error that occured after initial load.
   - Parameter errorView: The default view which you can customize, or return as is.
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          errorAtInitialLoad errorOrNil: NSError?,
                          errorView: InitialLoadErrorView) -> UIView
  
  /**
   Called when the collectionView failed to load a paged request.
   
   - Parameter collectionView: StatefulCollectionView instance.
   - Parameter errorAtLoadingPage: The error that occured after loading more pages.
   - Parameter errorView: The default view which you can customize, or return as is.
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          errorAtLoadingPages errorOrNil: NSError?,
                          errorView: PagingLoadErrorView) -> UIView
}

public extension StatefulCollectionViewCustomization {
  
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          viewForInitialLoad defaultView: UIActivityIndicatorView) -> UIView {
    return defaultView
  }
  
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          errorAtInitialLoad errorOrNil: NSError?,
                          errorView: InitialLoadErrorView) -> UIView {
    return errorView
  }
  
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          errorAtLoadingPages errorOrNil: NSError?,
                          errorView: PagingLoadErrorView) -> UIView {
    return errorView
  }
}
