//
//  StatefulCollectionViewDelegate.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 18/08/2019.
//

import Foundation
import UIKit

/**
 Closure describing a loading event has completed.
 
 This is the completion block used for `Loading initially`, or for `Loading from Pull-to-Refresh`.
 
 - Parameter isEmpty: Describes whether the data to show for this collection view is empty.
 - Parameter errorOrNil: Describes whether the request being loaded has an error to show.
 */
public typealias LoadCompletion = (_ isEmpty: Bool, _ errorOrNil: NSError?) -> Void

/**
 Closure describing a paged loading event has completed.
 
 This is the completion block used for `Paged Loading (ie. Loading the next pages of a paged
 request).
 
 - Parameter canLoadMore: Describes whether their are next pages available to load or request.
 - Parameter errorOrNil: Describes whether the request being loaded has an error.
 - Parameter showError: In case there are errors supplied, determine whether to show it or not.
 */
public typealias PagedCompletion = (_ canLoadMore: Bool, _ errorOrNil: NSError?, _ showError: Bool) -> Void

/**
 Protocol describing different collectionView loading state transitions
 */
public protocol StatefulCollectionViewDelegate {
  
  // MARK: - State management
  
  /**
   Called when the collectionView has finished loading its initial dataset.
   
   - Parameter collectionView: The collectionView instance calling this delegate.
   - Parameter didCompleteInitialLoad: The completion block (isEmpty, errorOrNil).
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          didCompleteInitialLoad completion: @escaping LoadCompletion)
  
  /**
   Called when the collectionView has finished loading from pull-to-refresh.
   
   - Parameter collectionView: The collectionView instance calling this delegate.
   - Parameter didCompletePullToRefresh: The completion block (isEmpty, errorOrNil).
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          didCompletePullToRefresh completion: @escaping LoadCompletion)
  
  /**
   Called when the collectionView has finished loading a paged-request.
   
   - Parameter collectionView: The collectionView instance calling this delegate.
   - Parameter didCompleteLoadingMorePages: Completion block (canLoadMore, errorOrNil, showError)
   */
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          didCompleteLoadingMorePages completion: @escaping PagedCompletion)
}
