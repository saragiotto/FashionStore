//
//  CartViewModel.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

class CartViewModel {
    private var cart: Cart
    
    var cartItens: Int {
        return cart.products?.reduce(0, { amount, productCart in
            amount + productCart.count
        }) ?? 0
    }
    
    public static let shared: CartViewModel = {
        let instance = CartViewModel()
        
        return instance
    }()
    
    private init() {
        cart = Cart()
    }
    
    func resetCart() {
        cart = Cart()
    }
    
    func getCartItem(at indexPath:IndexPath) -> CartProduct? {
        return (cart.products?.indices.contains(indexPath.row) ?? false) ? cart.products?[indexPath.row] : nil
    }
    
    func addProduct(_ product: Product, of size: ProductSize) {
        let cartItem = CartProduct(product, size: size, color: product.color ?? "")
        
        if let prod = cartHasItem(cartItem) {
            prod.count += 1
        } else {
            cart.products?.append(cartItem)
        }
    }
    
    func removeItem(at indexPath:IndexPath) {
        guard let productCart = self.getCartItem(at: indexPath) else { return }
        
        if let prod = cartHasItem(productCart) {
            if prod.count > 1 {
                prod.count -= 1
            } else {
                removeAllItens(at: indexPath)
            }
        }
    }
    
    func removeAllItens(at indexPath:IndexPath) {
        guard let productCart = self.getCartItem(at: indexPath) else { return }
        
        cart.products = cart.products?.filter({$0 != productCart})
    }
    
    private func cartHasItem(_ productCart: CartProduct) -> CartProduct? {
        return cart.products?.filter({$0 == productCart}).first
    }
    
    func totalCart() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: kDefaultLocale)
        formatter.currencySymbol = String(format: "%@%@", formatter.currencySymbol, " ")
        
        let amount = cart.products?.reduce(0.0, { amount, productCart in
            amount + ((productCart.product.productPrice ?? 0.0) * Double(productCart.count))
        })
        
        return formatter.string(for: amount) ?? ""
    }
}
