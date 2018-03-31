//
//  CartViewModel.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

class CartViewModel {
    var cart: Cart
    
    var cartItens: Int {
        return cart.products?.reduce(0, { amount, productCart in
            amount + productCart.count
        }) ?? 0
    }
    
    init() {
        cart = Cart()
    }
    
    func addItem(_ productCart: CartProduct) {
        if let prod = cartHasItem(productCart) {
            prod.count += 1
        } else {
            cart.products?.append(productCart)
        }
    }
    
    func removeItem(_ productCart: CartProduct) {
        if let prod = cartHasItem(productCart) {
            if prod.count > 1 {
                prod.count -= 1
            } else {
                removeAllItens(productCart)
            }
        }
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
    
    func removeAllItens(_ productCart: CartProduct) {
        cart.products = cart.products?.filter({$0 != productCart})
    }
    
    private func cartHasItem(_ productCart: CartProduct) -> CartProduct? {
        return cart.products?.filter({$0 == productCart}).first
    }
}
