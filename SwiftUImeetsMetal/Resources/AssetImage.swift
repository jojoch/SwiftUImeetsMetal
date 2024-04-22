//
//  AssetImage.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

import UIKit
import SwiftUI

enum AssetImage: String {
    case logo = "mDevCampLogo"
    case header
}

extension UIImage {
    convenience init?(assetImage: AssetImage) {
        self.init(named: assetImage.rawValue)
    }
}

extension Image {
    init?(assetImage: AssetImage) {
        self.init(assetImage.rawValue)
    }
}
