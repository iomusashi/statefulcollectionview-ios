//
//  UIScrollView+ScrollableContent.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 19/08/2019.
//

import Foundation
import UIKit

/**
 Protocol enforces declaration of UIScrollView accessor/mutator variables for the contained
 UICollectionView.
 */
public protocol StatefulCollectionViewScrollableContent {
  
  var contentOffset: CGPoint { get set }
  var contentSize: CGSize { get set }
  var contentInset: UIEdgeInsets { get set }
}

extension StatefulCollectionView: StatefulCollectionViewScrollableContent {
  
  public var contentOffset: CGPoint {
    set { collectionView.contentOffset = newValue }
    get { return collectionView.contentOffset }
  }
  
  public var contentSize: CGSize {
    set { collectionView.contentSize = newValue }
    get { return collectionView.contentSize }
  }
  
  public var contentInset: UIEdgeInsets {
    set { collectionView.contentInset = newValue }
    get { return collectionView.contentInset }
  }
}
