//
//  StatefulCollectionView+StateManagement.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

internal protocol StatefulCollectionViewStateManagement {
  
  /**
   Updates the state machine of the collection view.
   The default state is `idle`.
   
   - Parameter newState: The new state to transition the collectionView into.
   - Parameter updateMode: Describes whether to update the view mode of the collectionView upon
   state transition. Defaults to `true`.
   - Parameter errorOrNil: Can include an error payload during state transition. Defaults to `nil`.
   */
  func setState(_ newState: StatefulCollectionViewState,
                updateMode: Bool,
                errorOrNil: NSError?)
}

extension StatefulCollectionView: StatefulCollectionViewStateManagement {
  
  func setState(_ newState: StatefulCollectionViewState,
                updateMode: Bool = true,
                errorOrNil: NSError? = nil) {
    state = newState
    
    switch state {
    case .loadingInitially:
      resetDynamicContentView(withChildView: viewForInitialLoad)
    case .emptyOrError:
      resetDynamicContentView(withChildView: viewForEmptyInitialLoad(withError: errorOrNil))
      
    default: break
    }

    if updateMode {
      let mode: StatefulCollectionViewMode
      
      switch state {
      case .loadingInitially: fallthrough
      case .emptyOrError:
        mode = .static
      default: mode = .collection
      }
      
      viewMode = mode
    }
  }
}
