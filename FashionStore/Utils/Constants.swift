//
//  Constants.swift
//  FashionStore
//
//  Created by Leonardo Augusto N Saragiotto on 29/03/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

let kFashionUrl = "https://raw.githubusercontent.com/saragiotto/FashionStore/develop/FashionStore/Support/Products.json"
let kDefaultLocale = "pt_BR"

let kProductCellIdentifier = "productCell"
let kSizeCellIdentifier = "sizeCell"
let kCartProductCellIdentifier = "cartProductCell"
let kProductDetailSegue = "productDetailSegue"
let kCartSegue = "cartSegue"
let kProductNoImageName = "shoppingBag"

let kHeaderViewIdentifier = "headerView"
let kFilterNotification = "productFilter"
let kSegmentedIndex = "segmentedIndex"

let kNavigationTitle = "AMARO"
let kCartViewTitle = "Sacola"
let kColorLabelName = "Cor"
let kSizeLabelName = "Tamanho"
let kCartDeleteProduct = "Excluir"

let kDiscountCornerRadius = 5.0
let kCountChangeRadius = 8.0
let kSizeCornerRadius = 25.0
let kSizeCellWidth = 50.0
let kSizeCellSpacing = 10.0

let kActionTitle = "AMARO"
let kActionDescription = "Agradecemos a preferencia. Em breve suas compras chegarão ao destino. Até a próxima =D"
let kActionOk = "Ok"

let kShippingStartCost = 10.0
let kShippingCostForProduct = 2.2
let kShippingCostForExtraItem = 1.0

enum ProductCountOperation {
    case add, remove
}
