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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configureView()
        self.populateView()
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
    }
    
    private func populateView() {
        let cartModel = CartViewModel.shared.getCartModel()

        self.subTotalLabel.text = cartModel.subTotalCost
        self.shippingCostLabel.text = cartModel.shippingCost
        self.totalCartLabel.text = cartModel.totalCost
    }

    @IBAction func closeCartView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func processUsersCart(_ sender: Any) {
        if CartViewModel.shared.numberOfCells == 0 {
            return
        }
        
        let alertController = UIAlertController(title: kActionTitle, message: kActionDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: kActionOk, style: .default) { (action: UIAlertAction) in
            CartViewModel.shared.resetCart()
            self.updateCart()
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func emptyCartMessage() {
        let hidden = (CartViewModel.shared.numberOfCells != 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.emptyCartView.isHidden = hidden
        })
    }
    
    private func updateCart() {
        self.cartTableView.reloadData()
        self.emptyCartMessage()
        self.populateView()
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
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return kCartDeleteProduct
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            CartViewModel.shared.removeAllItens(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateCart()
        }
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
            self.updateCart()
        }
    }
}
