//
//  StatefulCollectionView+InitialLoad.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

public protocol StatefulCollectionViewInitialLoad {
  
  /**
   Signals the collectionView to start the initial load sequence.
   
   - Parameter showCollectionView: Describe whether to show the collectionView or not during initial
   load. Defaults to `false`.
   
   - Returns: Boolean indicating a successful trigger.
   */
  func triggerInitialLoad(_ showCollectionView: Bool) -> Bool
}

extension StatefulCollectionView: StatefulCollectionViewInitialLoad {
  
  @discardableResult
  @objc
  public func triggerInitialLoad(_ showCollectionView: Bool = false) -> Bool {
    guard !state.isLoading else { return false }
    
    let transitionState: StatefulCollectionViewState = showCollectionView ?
      .collectionViewLoadingInitially : .loadingInitially
    setState(transitionState)

    guard let delegate = statefulDelegate else { return true }
    delegate.statefulCollection(self, didCompleteInitialLoad: { isEmpty, errorOrNil in
      DispatchQueue.main.async { [weak self] in
        self?.setHasFinishedInitialLoad(isEmpty: isEmpty, errorOrNil: errorOrNil)
      }
    })
    return true
  }
  
  private func setHasFinishedInitialLoad(isEmpty: Bool, errorOrNil: NSError?) {
    guard state.isLoadingInitially else { return }
    let newState: StatefulCollectionViewState = isEmpty ? .emptyOrError : .idle
    setState(newState)
  }
}
