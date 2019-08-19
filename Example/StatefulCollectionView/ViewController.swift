//
//  ViewController.swift
//  StatefulCollectionView
//
//  Created by iomusashi on 08/18/2019.
//  Copyright (c) 2019 iomusashi. All rights reserved.
//

import StatefulCollectionView
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var statefulCollection: StatefulCollectionView!
  
  var items = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    statefulCollection.canPullToRefresh = true
    
    statefulCollection.statefulDelegate = self
    statefulCollection.dataSource = self
    statefulCollection.delegate = self
    statefulCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.itemSize = CGSize(width: statefulCollection.bounds.size.width,
                                 height: 40.0)
    flowLayout.minimumLineSpacing = 1.0
    flowLayout.minimumInteritemSpacing = 1.0
    
    statefulCollection.setCollectionViewLayout(flowLayout, animated: false)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    statefulCollection.triggerInitialLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

extension ViewController: StatefulCollectionViewDelegate {
  
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          didCompleteInitialLoad completion: @escaping LoadCompletion) {
    items = Int(arc4random_uniform(15))
    let empty = items == 0
    
    let time = DispatchTime.now() + Double(Int64(3 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time) {
      let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
      collectionView.reloadData()
      completion(empty, error)
    }
  }
  
  func statefulCollection(_ collectionView: StatefulCollectionView,
                          didCompletePullToRefresh completion: @escaping LoadCompletion) {
    items = Int(arc4random_uniform(15))
    let empty = items == 0
    
    let time = DispatchTime.now() + Double(Int64(3 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time) {
      let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
      collectionView.reloadData()
      completion(empty, error)
    }
  }
}

extension ViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return items
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath)
  }
}

extension ViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    cell.contentView.subviews.forEach { subview in
      subview.removeFromSuperview()
    }
    cell.contentView.backgroundColor = UIColor.white
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 40))
    titleLabel.text = "\(indexPath.item)"
    cell.contentView.addSubview(titleLabel)
  }
}
