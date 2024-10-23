//
//  ColorExtension.swift
//  News ToDay
//
//  Created by Danila Okuneu on 20.10.24.
//


import UIKit



extension UIColor {
	
	enum AppColor {
		case purpleDark
		case purpleLight
		case purpleLighter
		case purplePrimary
		
		case blackDark
		case blackLight
		case blackLighter
		case blackPrimary
		
		case greyDark
		case greyLight
		case greyLighter
		case greyPrimary
        
        case purpleBright
		
		var value: UIColor {
			switch self {
			case .purpleDark:
				return getColor(37, 54, 167)
			case .purpleLight:
				return getColor(138, 150, 229)
			case .purpleLighter:
				return getColor(238, 240, 251)
			case .purplePrimary:
				return getColor(71, 90, 215)
				
			case .blackDark:
				return getColor(24, 36, 47)
			case .blackLight:
				return getColor(68, 72, 95)
			case .blackLighter:
				return getColor(85, 90, 119)
			case .blackPrimary:
				return getColor(51, 54, 71)
				
			case .greyDark:
				return getColor(102, 109, 142)
			case .greyLight:
				return getColor(172, 175, 195)
			case .greyLighter:
				return getColor(243, 244, 246)
			case .greyPrimary:
				return getColor(124, 130, 161)
            
            case .purpleBright:
                return getColor(101, 99, 255)
			}
			
		}
	}


	/// Returns
	static func app(_ color: AppColor) -> UIColor {
		return color.value
	}
	
}


private func getColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
	return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
}






