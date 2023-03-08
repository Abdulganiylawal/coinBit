//
//  CoinObject.swift
//  ByteCoin
//
//  Created by Lawal Abdulganiy on 08/03/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation
struct CoinObject{
    let value:Double
    var rate:String{
       return String(format: "%0.f", value)
    }
}
