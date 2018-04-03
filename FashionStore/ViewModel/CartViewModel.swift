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
    
    var numberOfCells: Int {
        return cart.products?.count ?? 0
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
    
    private func getCartItem(at indexPath:IndexPath) -> CartProduct? {
        return (cart.products?.indices.contains(indexPath.row) ?? false) ? cart.products?[indexPath.row] : nil
    }
    
    func getCartProduct(at indexPath:IndexPath) -> CartProductCellModel? {
        guard let cartProduct = cart.products?[indexPath.row] else { return nil }
        
        let itemPrice = (cartProduct.product.productPrice ?? 0.0) * Double(cartProduct.count)
        
        return CartProductCellModel(imageUrl: cartProduct.product.image ?? "",
                                    name: cartProduct.product.name ?? "",
                                    price: NumberFormatter().currencyWith(itemPrice),
                                    size: cartProduct.size.size ?? "",
                                    count: String(cartProduct.count),
                                    color: cartProduct.product.color ?? "")
    }
    
    func addProduct(_ product: Product, of size: ProductSize) {
        let cartItem = CartProduct(product, size: size, color: product.color ?? "")
        
        if let prod = cartHasItem(cartItem) {
            prod.count += 1
        } else {
            cart.products?.append(cartItem)
        }
    }
    
    func addItem(at indexPath: IndexPath) {
        guard let productCart = self.getCartItem(at: indexPath) else { return }
        productCart.count += 1
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
    
    var subTotalCost: Double {
        let amount = cart.products?.reduce(0.0, { amount, productCart in
            amount + ((productCart.product.productPrice ?? 0.0) * Double(productCart.count))
        })
        
        return amount ?? 0.0
    }
    
    /* This is just for simulation proposals
     
     Every new product cost R$ 2,20 for shipping
     Every product additional item cost R$ 1,00 for shipping
     
     Shipping cost start at R$ 10,00
     */
    var shippingCost: Double {
        let numberOfItens = self.cartItens
        let numberOfCells = self.numberOfCells
        let shippingCostForCell = Double(numberOfCells) * kShippingCostForProduct
        let shippingCostForExtraItem = Double(numberOfItens - numberOfCells) * kShippingCostForExtraItem
        let startCost = (self.numberOfCells == 0) ? 0.0 : kShippingStartCost
        
        return startCost + shippingCostForCell + shippingCostForExtraItem
    }
    
    func getCartModel() -> CartModel {
        let subTotal = self.subTotalCost
        let shipping = self.shippingCost
        let total = subTotal + shipping
        
        return CartModel(subTotalCost: NumberFormatter().currencyWith(subTotal),
                         shippingCost: NumberFormatter().currencyWith(shipping),
                         totalCost: NumberFormatter().currencyWith(total))
    }
}

struct CartModel {
    let subTotalCost: String
    let shippingCost: String
    let totalCost: String
}

struct CartProductCellModel {
    let imageUrl: String
    let name: String
    let price: String
    let size: String
    let count: String
    let color: String
}
