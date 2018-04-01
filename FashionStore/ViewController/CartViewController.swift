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
    
    private var shippingCost: Double? {
        didSet {
            self.shippingCostLabel.text = NumberFormatter().currencyWith(shippingCost ?? 0.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    private func configureView() {
        self.title = kCartViewTitle
        
        let cartProductCellNib = UINib.init(nibName: "CartProductViewCell", bundle: nil)
        self.cartTableView.register(cartProductCellNib, forCellReuseIdentifier: kCartProductCellIdentifier)
        
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        processCart.layer.cornerRadius = CGFloat(kDiscountCornerRadius)
        processCart.clipsToBounds = true
        
        calculateShippingCost()
        
        let totalCart = CartViewModel.shared.totalCart()
        self.subTotalLabel.text = NumberFormatter().currencyWith(totalCart)
        self.totalCartLabel.text = NumberFormatter().currencyWith(totalCart + (shippingCost ?? 0.0))
    }

    private func calculateShippingCost() {
        let numberOfItens = CartViewModel.shared.cartItens
        let numberOfCells = CartViewModel.shared.numberOfCells
        
        let shippingCostForCell = Double(numberOfCells) * 2.2
        let shippingCostForExtraItem = Double(numberOfItens - numberOfCells) * 1.0
        
        shippingCost = 10.0 + shippingCostForCell + shippingCostForExtraItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeCartView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartViewModel.shared.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kCartProductCellIdentifier) as? CartProductViewCell {
            
            if let cellModel = CartViewModel.shared.getCartProduct(at: indexPath) {
                cell.configure(cellModel)
            }
            return cell
        }
        
        return UITableViewCell()
    }
}
