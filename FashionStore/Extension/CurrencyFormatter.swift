//
//  CurrencyFormatter.swift
//  FashionStore
//
//  Created by Leonardo Saragiotto on 4/1/18.
//  Copyright © 2018 Leonardo Augusto N Saragiotto. All rights reserved.
//

import Foundation

extension NumberFormatter {
    func currencyWith(_ amount: Double) -> String {
        self.numberStyle = .currency
        self.locale = Locale(identifier: kDefaultLocale)
        self.currencySymbol = String(format: "%@ ", self.currencySymbol)
        
        return self.string(for: amount) ?? ""
    }
}
