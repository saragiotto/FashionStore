//
//  ProductHeaderReusableView.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 3/31/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit

class ProductHeaderReusableView: UICollectionReusableView {
        
    @IBOutlet weak var segmentedHeader: UISegmentedControl!
    @IBAction func segmentedDidChange(_ sender: UISegmentedControl) {
        let object = [kSegmentedIndex: sender.selectedSegmentIndex]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kFilterNotification), object: object)
    }
}
