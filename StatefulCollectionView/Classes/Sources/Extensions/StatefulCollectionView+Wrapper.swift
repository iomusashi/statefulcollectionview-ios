//
//  StatefulCollectionView+Wrapper.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 20/08/2019.
//

import Foundation
import UIKit

/**
 Wraps and exposes public functions of UICollectionView.
 */
public protocol StatefulCollectionViewWrapper {
  
  /// Providing collection view data
  var dataSource: UICollectionViewDataSource? { get set }
  
  /// Mananging collection view interactions
  var delegate: UICollectionViewDelegate? { get set }
  
  /// Configuring the background view
  var backgroundView: UIView? { get set }
  
  /// Prefetching collection view cells and data
  @available(iOS 10.0, *)
  var isPrefetchingEnabled: Bool { get set }
  @available(iOS 10.0, *)
  var prefetchDataSource: UICollectionViewDataSourcePrefetching? { get set }
  
  /// Creating collection view cells
  func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier reuseId: String)
  func register(_ nib: UINib?, forCellWithReuseIdentifier reuseId: String)
  
  func register(_ cellClass: AnyClass?,
                forSupplementaryViewOfKind kind: String,
                withReuseIdentifier reuseId: String)
  
  func register(_ nib: UINib?,
                forSupplementaryViewOfKind kind: String,
                withReuseIdentifier reuseId: String)
  
  func dequeueReusableCell(withReuseIdentifier reuseId: String, for index: IndexPath)
  
  func dequeueReusableSupplementaryView(ofKind kind: String,
                                        withReuseIdentifier reuseId: String,
                                        for index: IndexPath)
  
  /// Changing the layout
  var collectionViewLayout: UICollectionViewLayout { get set }
  
  func setCollectionViewLayout(_ layout: UICollectionViewLayout,
                               animated: Bool,
                               completion: ((Bool) -> Void)?)
  
  func startInteractiveTransition(to newLayout: UICollectionViewLayout,
                                  completion: UICollectionView.LayoutInteractiveTransitionCompletion?)
  
  func finishInteractiveTransition()
  func cancelInteractiveTransition()
  
  /// Getting the state of the collection view
  var numberOfSections: Int { get }
  func numberOfItems(inSection section: Int) -> Int
  var visibleCells: [UICollectionViewCell] { get }
  
  /// Managing the selection
  var allowsSelection: Bool { get set }
  func selectItem(at index: IndexPath,
                  animated: Bool,
                  scrollPosition: UICollectionView.ScrollPosition)
  func deselectItem(at index: IndexPath,
                    animated: Bool)
  
  /// Locating items and views in the collection view
  func indexPathForItem(at point: CGPoint) -> IndexPath?
  var indexPathsForVisibleItems: [IndexPath] { get }
  
  func indexPath(for cell: UICollectionViewCell) -> IndexPath?
  func cellForItem(at index: IndexPath) -> UICollectionViewCell?
  
  @available(iOS 9.0, *)
  func indexPathsForVisibleSupplementaryElements(ofKind kind: String) -> [IndexPath]
  @available(iOS 9.0, *)
  func visibleSupplementaryViews(ofKind kind: String) -> [UICollectionReusableView]
  
  /// Getting layout information
  func layoutAttributesForItem(at index: IndexPath) -> UICollectionViewLayoutAttributes?
  func layoutAttributesForSupplementaryElement(ofKind kind: String,
                                               at index: IndexPath) -> UICollectionViewLayoutAttributes?
  
  /// Scrolling an item into view
  func scrollToItem(at index: IndexPath,
                    at position: UICollectionView.ScrollPosition,
                    animated: Bool)
  
  /// Animating multiple changes to the collection view
  func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?)
  
  /// Reloading content
  @available(iOS 11.0, *)
  var hasUncommittedUpdates: Bool { get }
  
  func reloadData()
  func reloadSections(_ indexSet: IndexSet)
  func reloadItems(at indices: [IndexPath])
}

extension StatefulCollectionView: StatefulCollectionViewWrapper {
  
  // MARK: Providing collection view data
  public var dataSource: UICollectionViewDataSource? {
    set { collectionView.dataSource = newValue }
    get { return collectionView.dataSource }
  }
  
  // MARK: Managing collection view interactions
  public var delegate: UICollectionViewDelegate? {
    set { collectionView.delegate = newValue }
    get { return collectionView.delegate }
  }
  
  // MARK: Configuring the background view
  public var backgroundView: UIView? {
    set { collectionView.backgroundView = newValue }
    get { return collectionView.backgroundView }
  }
  
  // MARK: Prefetching collection view cells and data
  @available(iOS 10.0, *)
  public var isPrefetchingEnabled: Bool {
    set { collectionView.isPrefetchingEnabled = newValue }
    get { return collectionView.isPrefetchingEnabled }
  }
  
  @available(iOS 10.0, *)
  public var prefetchDataSource: UICollectionViewDataSourcePrefetching? {
    set { collectionView.prefetchDataSource = newValue }
    get { return collectionView.prefetchDataSource }
  }
  
  // MARK: Creating collection view cells
  public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier reuseId: String) {
    collectionView.register(cellClass, forCellWithReuseIdentifier: reuseId)
  }
  
  public func register(_ nib: UINib?, forCellWithReuseIdentifier reuseId: String) {
    collectionView.register(nib, forCellWithReuseIdentifier: reuseId)
  }
  
  public func register(_ cellClass: AnyClass?,
                       forSupplementaryViewOfKind kind: String,
                       withReuseIdentifier reuseId: String) {
    collectionView.register(cellClass,
                            forSupplementaryViewOfKind: kind,
                            withReuseIdentifier: reuseId)
  }
  
  public func register(_ nib: UINib?,
                       forSupplementaryViewOfKind kind: String,
                       withReuseIdentifier reuseId: String) {
    collectionView.register(nib,
                            forSupplementaryViewOfKind: kind,
                            withReuseIdentifier: reuseId)
  }
  
  public func dequeueReusableCell(withReuseIdentifier reuseId: String, for index: IndexPath) {
    collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: index)
  }
  
  public func dequeueReusableSupplementaryView(ofKind kind: String,
                                               withReuseIdentifier reuseId: String,
                                               for index: IndexPath) {
    collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                    withReuseIdentifier: reuseId,
                                                    for: index)
  }
  
  // MARK: Changing the layout
  public var collectionViewLayout: UICollectionViewLayout {
    set { collectionView.collectionViewLayout = newValue }
    get { return collectionView.collectionViewLayout }
  }
  
  public func setCollectionViewLayout(_ layout: UICollectionViewLayout,
                                      animated: Bool,
                                      completion: ((Bool) -> Void)? = nil) {
    collectionView.setCollectionViewLayout(layout,
                                           animated: animated,
                                           completion: completion)
  }
  
  public func startInteractiveTransition(to newLayout: UICollectionViewLayout,
                                         completion: UICollectionView.LayoutInteractiveTransitionCompletion?) {
    collectionView.startInteractiveTransition(to: newLayout,
                                              completion: completion)
  }
  
  public func finishInteractiveTransition() {
    collectionView.finishInteractiveTransition()
  }
  
  public func cancelInteractiveTransition() {
    collectionView.cancelInteractiveTransition()
  }
  
  // MARK: Getting the state of the collection view
  public var numberOfSections: Int {
    get { return collectionView.numberOfSections }
  }
  
  public func numberOfItems(inSection section: Int) -> Int {
    return collectionView.numberOfItems(inSection: section)
  }
  
  public var visibleCells: [UICollectionViewCell] {
    get { return collectionView.visibleCells }
  }
  
  // MARK: Managing the selection
  public var allowsSelection: Bool {
    set { collectionView.allowsSelection = newValue }
    get { return collectionView.allowsSelection }
  }
  
  public func selectItem(at index: IndexPath,
                         animated: Bool,
                         scrollPosition: UICollectionView.ScrollPosition) {
    collectionView.selectItem(at: index,
                              animated: animated,
                              scrollPosition: scrollPosition)
  }
  
  public func deselectItem(at index: IndexPath, animated: Bool) {
    collectionView.deselectItem(at: index, animated: animated)
  }
  
  // MARK: Locating items and views in the collection view
  public func indexPathForItem(at point: CGPoint) -> IndexPath? {
    return collectionView.indexPathForItem(at: point)
  }
  
  public var indexPathsForVisibleItems: [IndexPath] {
    get { return collectionView.indexPathsForVisibleItems }
  }
  
  public func indexPath(for cell: UICollectionViewCell) -> IndexPath? {
    return collectionView.indexPath(for: cell)
  }
  
  public func cellForItem(at index: IndexPath) -> UICollectionViewCell? {
    return collectionView.cellForItem(at: index)
  }
  
  @available(iOS 9.0, *)
  public func indexPathsForVisibleSupplementaryElements(ofKind kind: String) -> [IndexPath] {
    return collectionView.indexPathsForVisibleSupplementaryElements(ofKind: kind)
  }
  
  @available(iOS 9.0, *)
  public func visibleSupplementaryViews(ofKind kind: String) -> [UICollectionReusableView] {
    return collectionView.visibleSupplementaryViews(ofKind: kind)
  }
  
  // MARK: Getting layout information
  public func layoutAttributesForItem(at index: IndexPath) -> UICollectionViewLayoutAttributes? {
    return collectionView.layoutAttributesForItem(at: index)
  }
  
  public func layoutAttributesForSupplementaryElement(ofKind kind: String,
                                                      at index: IndexPath) -> UICollectionViewLayoutAttributes? {
    return collectionView.layoutAttributesForSupplementaryElement(ofKind: kind,
                                                                  at: index)
  }
  
  // MARK: Scrolling an item into view
  public func scrollToItem(at index: IndexPath,
                           at position: UICollectionView.ScrollPosition,
                           animated: Bool) {
    collectionView.scrollToItem(at: index,
                                at: position,
                                animated: animated)
  }
  
  // MARK: Animating multiple changes to the collection view
  public func performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
    collectionView.performBatchUpdates(updates, completion: completion)
  }
  
  // MARK: Reloading content
  @available(iOS 11.0, *)
  public var hasUncommittedUpdates: Bool {
    get { return collectionView.hasUncommittedUpdates }
  }
  
  public func reloadData() {
    collectionView.reloadData()
  }
  
  public func reloadSections(_ indexSet: IndexSet) {
    collectionView.reloadSections(indexSet)
  }
  
  public func reloadItems(at indices: [IndexPath]) {
    collectionView.reloadItems(at: indices)
  }
}
