//
//  StatefulCollectionView.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

/**
 Drop-in replacement for `UICollectionView` that supports pull-to-refresh, load-more,
 initial load, and empty states.
 */
public final class StatefulCollectionView: UIView {
  
  // MARK: - Public properties
  
  /// Accessor to the contained collectionView
  public var innerCollection: UICollectionView { return collectionView }
  
  /// Determines whether to enable/disable pull-to-refresh support
  public var canPullToRefresh = false

  // MARK: - Stateful delegate
  public var statefulDelegate: StatefulCollectionViewDelegate?
  
  // MARK: - Customization delegate
  public var customization: StatefulCollectionViewCustomization?

  // MARK: Internal properties
  internal lazy var collectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
  
  internal lazy var dynamicContentView: UIView = { [unowned self] in
    let view = UIView(frame: self.bounds)
    view.backgroundColor = self.backgroundColor
    view.isHidden = true
    return view
  }()
  
  internal lazy var refreshControl = UIRefreshControl()

  internal var state: StatefulCollectionViewState = .idle
  
  internal var viewMode: StatefulCollectionViewMode = .collection {
    didSet {
      let hidden = viewMode == .collection
      guard dynamicContentView.isHidden != hidden else { return }
      dynamicContentView.isHidden = hidden
    }
  }

  /**
   Creates a StatefulCollectionView from data in a given unarchiver
   
   - Parameter aDecoder: An unarchiver object
   
   - Returns: An instance of StatefulCollectionView.
   */
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInternalViews()
  }
  
  /**
   Creates a StatefulCollectionView with a specified frame rectangle
   
   - Parameter frame: The frame rectangle for the view, measured in points.
   
   - Returns: An instance of StatefulCollectionView
   */
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupInternalViews()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = bounds
    dynamicContentView.frame = bounds
  }
  
  internal func setupInternalViews() {
    addSubview(collectionView)
    addSubview(dynamicContentView)
    
    collectionView.backgroundColor = UIColor.white
    collectionView.backgroundView = UIView(frame: .zero)

    guard #available(iOS 10.0, *) else { return }
    refreshControl.addTarget(self,
                             action: #selector(refreshControlValueChanged),
                             for: .valueChanged)
    collectionView.refreshControl = refreshControl
  }
}

internal enum StatefulCollectionViewState {
  
  case idle
  case loadingInitially
  case collectionViewLoadingInitially
  case emptyOrError
  case pullToRefreshLoading

  var isLoading: Bool {
    switch self {
    case .loadingInitially: fallthrough
    case .collectionViewLoadingInitially: fallthrough
    case .pullToRefreshLoading: return true

    default: return false
    }
  }
  
  var isLoadingInitially: Bool {
    switch self {
    case .loadingInitially: fallthrough
    case .collectionViewLoadingInitially: return true
      
    default: return false
    }
  }
}

internal enum StatefulCollectionViewMode {
  
  case collection
  case `static`
}
