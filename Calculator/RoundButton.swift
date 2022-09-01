//
//  RoundButton.swift
//  Calculator
//
//  Created by Yongwoo Yoo on 2022/02/23.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
	@IBInspectable var isRound: Bool = false {
		didSet {
			if isRound {
				self.layer.cornerRadius = self.frame.height / 2
			}
		}
	}
    
}
