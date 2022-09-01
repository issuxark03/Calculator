//
//  ViewController.swift
//  Calculator
//
//  Created by Yongwoo Yoo on 2022/02/23.
//

import UIKit

enum Operation {
	case Add
	case Subtract
	case Divide
	case Multiply
	case unknown
}


class ViewController: UIViewController {

	@IBOutlet weak var numberOutputLabel: UILabel!
	
	var displayNumber = ""
	var firstOperand = ""
	var secondOperand = ""
	var result = ""
	var currentOperation: Operation = .unknown
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	//숫자버튼
	@IBAction func tabNumberButton(_ sender: UIButton) {
		guard let numberValue = sender.titleLabel?.text else { return } //선택한 버튼의 title
		
		if self.displayNumber.count < 9 {
			self.displayNumber += numberValue
			self.numberOutputLabel.text = self.displayNumber
		}
	}
	//초기화
	@IBAction func tabClearButton(_ sender: UIButton) {
		self.displayNumber = ""
		self.firstOperand = ""
		self.secondOperand = ""
		self.result = ""
		self.currentOperation = .unknown
		self.numberOutputLabel.text = "0"
	}
	@IBAction func tabDotButton(_ sender: UIButton) {
		if self.displayNumber.count < 8, !self.displayNumber.contains(".") {
			self.displayNumber += self.displayNumber.isEmpty ? "0." : "." //비어있으면 0. 아니면 .
			self.numberOutputLabel.text = displayNumber
		}
	}
	@IBAction func tabDivideButton(_ sender: UIButton) {
		self.operation(.Divide)
	}
	@IBAction func tabMultiplyButton(_ sender: UIButton) {
		self.operation(.Multiply)
	}
	@IBAction func tabSubtractButton(_ sender: UIButton) {
		self.operation(.Subtract)
	}
	@IBAction func tabAddButton(_ sender: UIButton) {
		self.operation(.Add)
	}
	@IBAction func tabEqualButton(_ sender: UIButton) {
		self.operation(self.currentOperation)
	}
	
	func operation(_ operation: Operation){
		if self.currentOperation != .unknown {
			if !self.displayNumber.isEmpty {
				self.secondOperand = self.displayNumber
				self.displayNumber = ""
				
				guard let firstOperand = Double(self.firstOperand) else { return }
				guard let secondOperand = Double(self.secondOperand) else { return }
				
				switch self.currentOperation {
					case .Add:
						self.result = "\(firstOperand + secondOperand)"
					case .Subtract:
						self.result = "\(firstOperand - secondOperand)"
					case .Divide:
						self.result = "\(firstOperand / secondOperand)"
					case .Multiply:
						self.result = "\(firstOperand * secondOperand)"
					default:
						break;
				}
				
				if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 { //1로 나눴을때 나머지가 0이면 인트로변환
					self.result = "\(Int(result))"
				}
				
				self.firstOperand = result
				self.numberOutputLabel.text = result
			}
			
			self.currentOperation = operation
			
		} else { //unknown
			self.firstOperand = self.displayNumber
			self.currentOperation = operation
			self.displayNumber = "" //기호이후 숫자초기화
		}
			
		
	}
}

