//
//  StatefulCollectionView+PullToRefresh.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 19/08/2019.
//

import Foundation
import UIKit

public protocol StatefulCollectionViewPullToRefresh {
  
  /**
   Signals the collectionView to trigger refresh programatically.
   
   Also called when the user pulls down to refresh the collectionView.
   
   - Returns: Boolean indicating a successful trigger.
   */
  func triggerPullToRefresh() -> Bool
}

extension StatefulCollectionView: StatefulCollectionViewPullToRefresh {
  
  @discardableResult
  public func triggerPullToRefresh() -> Bool {
    guard !state.isLoading && canPullToRefresh else { return false }
    
    setState(.pullToRefreshLoading, updateMode: false, errorOrNil: nil)
    
    guard let delegate = statefulDelegate else { return true }
    delegate.statefulCollection(self, didCompletePullToRefresh: { isEmpty, errorOrNil in
      DispatchQueue.main.async { [weak self] in
        self?.setHasFinishedLoadingFromPullToRefresh(isEmpty: isEmpty, errorOrNil: errorOrNil)
      }
    })
    DispatchQueue.main.async { [weak self] in
      self?.refreshControl.beginRefreshing()
    }
    
    return true
  }
  
  @objc
  internal func refreshControlValueChanged() {
    if state != .pullToRefreshLoading && !state.isLoading {
      if (!triggerPullToRefresh()) {
        refreshControl.endRefreshing()
      }
    } else {
      refreshControl.endRefreshing()
    }
  }
  
  private func setHasFinishedLoadingFromPullToRefresh(isEmpty: Bool, errorOrNil: NSError?) {
    guard state == .pullToRefreshLoading else { return }
    
    refreshControl.endRefreshing()
    
    if isEmpty {
      setState(.emptyOrError, updateMode: true, errorOrNil: errorOrNil)
    } else {
      setState(.idle)
    }
  }
}
