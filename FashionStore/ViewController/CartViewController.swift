//
//  CartViewController.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 4/1/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var totalCartLabel: UILabel!
    @IBOutlet weak var processCart: UIButton!
    
    @IBOutlet weak var emptyCartView: UIView!
    private var shippingCost: Double? {
        didSet {
            self.shippingCostLabel.text = NumberFormatter().currencyWith(shippingCost ?? 0.0)
        }
    }
    
    private var totalCart: Double? {
        didSet {
            self.subTotalLabel.text = NumberFormatter().currencyWith(totalCart ?? 0.0)
            calculateShippingCost()
            self.totalCartLabel.text = NumberFormatter().currencyWith((totalCart ?? 0.0) + (shippingCost ?? 0.0))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emptyCartMessage()
    }
    
    private func configureView() {
        self.title = kCartViewTitle
        
        let cartProductCellNib = UINib.init(nibName: "CartProductViewCell", bundle: nil)
        self.cartTableView.register(cartProductCellNib, forCellReuseIdentifier: kCartProductCellIdentifier)
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        self.cartTableView.tableFooterView = UIView()
        
        processCart.layer.cornerRadius = CGFloat(kDiscountCornerRadius)
        processCart.clipsToBounds = true
        
        totalCart = CartViewModel.shared.totalCart()
    }

    /* This is just for somulation proposals
     
     Every new product cost R$ 2,20 for shipping
     Every product additional item cost R$ 1,00 for shipping
     
     Shipping cost start at R$ 10,00
    */
    private func calculateShippingCost() {
        let numberOfItens = CartViewModel.shared.cartItens
        let numberOfCells = CartViewModel.shared.numberOfCells
        let shippingCostForCell = Double(numberOfCells) * 2.2
        let shippingCostForExtraItem = Double(numberOfItens - numberOfCells) * 1.0
        let startCost = (CartViewModel.shared.numberOfCells == 0) ? 0.0 : 10.0
        
        shippingCost = startCost + shippingCostForCell + shippingCostForExtraItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeCartView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func emptyCartMessage() {
        let hidden = (CartViewModel.shared.numberOfCells != 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.emptyCartView.isHidden = hidden
        })
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewModel.shared.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCartProductCellIdentifier) as? CartProductViewCell {
            
            if let cellModel = CartViewModel.shared.getCartProduct(at: indexPath) {
                cell.configure(cellModel)
                cell.delegate = self
            }
            return cell
        }
        
        return UITableViewCell()
    }
}

extension CartViewController: CartProductCellDelegate {
    func changeProductCount(_ sender: UITableViewCell, operation: ProductCountOperation) {
        if let indexPath = self.cartTableView.indexPath(for: sender) {
            switch operation {
            case .add:
                CartViewModel.shared.addItem(at: indexPath)
                break
            case .remove:
                CartViewModel.shared.removeItem(at: indexPath)
                break
            }
            self.cartTableView.reloadData()
            self.emptyCartMessage()
            totalCart = CartViewModel.shared.totalCart()
        }
    }
}
