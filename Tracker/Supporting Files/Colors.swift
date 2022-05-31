//
//  Colors.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//

import Foundation
import UIKit

//For more colors: https://flatuicolors.com & https://www.color-name.com
struct Colors {
    //PeriWinkle from https://flatuicolors.com/palette/gb
    static let PeriWinkle = UIColor(red: 156.0/255.0, green: 136.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    //Exodus Fruit from https://flatuicolors.com/palette/au
    static let ExodusFruit = UIColor(red: 104.0/255.0, green: 109.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    //Pico Void from https://flatuicolors.com/palette/gb
    static let PicoVoid = UIColor(red: 25.0/255.0, green: 42.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    //Wet Asphalt from https://flatuicolors.com/palette/defo
    static let WetAsphalt = UIColor(red: 52.0/255.0, green: 73.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    //Creamy Peach from https://flatuicolors.com/palette/ru
    static let Peach = UIColor(red: 243.0/255.0, green: 166.0/255.0, blue: 131.0/255.0, alpha: 1.0)
    //Old Geranium from https://flatuicolors.com/palette/ru
    static let OldGeranium = UIColor(red: 207.0/255.0, green: 106.0/255.0, blue: 135.0/255.0, alpha: 1.0)
    //Off White from https://www.color-name.com/off-white.color
    static let OffWhite = UIColor(red: 248.0/255.0, green: 240.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    //Turkish Aqua from https://flatuicolors.com/palette/nl
    static let Aqua = UIColor(red: 0.0/255.0, green: 98.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    //Palm Springs Splash from https://flatuicolors.com/palette/es
    static let PalmSpringsSplash = UIColor(red: 33.0/255.0, green: 140.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    //Eggshell from https://encycolorpedia.com/f0ead6
    static let EggShell = UIColor(red: 240.0/255.0, green: 234.0/255.0, blue: 214.0/255.0, alpha: 1.0)
}


enum Color: String {
    case periWinkle
    case exodusFruit
    case picoVoid
    case wetAsphalt
    case peach
    case oldGeranium
    case offWhite
    case aqua
    case palmSpringsSplash
    case unknown
  
  var color: UIColor {
    switch self {
    case .periWinkle: return Colors.PeriWinkle
    case .exodusFruit: return Colors.ExodusFruit
    case .picoVoid: return  Colors.PicoVoid
    case .wetAsphalt: return Colors.WetAsphalt
    case .peach: return Colors.Peach
    case .oldGeranium: return Colors.OldGeranium
    case .offWhite: return Colors.OffWhite
    case .aqua: return Colors.Aqua
    case .palmSpringsSplash: return Colors.PalmSpringsSplash
    case .unknown: return Colors.Peach
    }
  }
}

