//
//  SettingsViewController.swift
//  Tracker
//
//  Created by Sam Gustafsson on 5/13/22.
//

import UIKit

class SettingsViewController: BaseViewContoller {

    @IBOutlet weak var color1: UIButton!
    @IBOutlet weak var color2: UIButton!
    @IBOutlet weak var color3: UIButton!
    @IBOutlet weak var color4: UIButton!
    @IBOutlet weak var color5: UIButton!
    @IBOutlet weak var color6: UIButton!
    @IBOutlet weak var color7: UIButton!
    @IBOutlet weak var color8: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = Primary.shared.uiColor
    }
    
    
    @IBAction func colorOnePressed(_ sender: Any) {
        //for button vibration
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.periWinkle
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
        
    }
    
    @IBAction func colorTwoPressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.exodusFruit
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
        
    }
    @IBAction func colorThreePressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.picoVoid
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
    }
    @IBAction func colorFourPressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.wetAsphalt
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
        
    }
    @IBAction func colorFivePressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.peach
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
        
    }
    @IBAction func colorSixPressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.oldGeranium
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
    }
    @IBAction func colorSevenPressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.aqua
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
    }
    @IBAction func colorEightPressed(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        UIView.animate(withDuration: 0.25) {
            Primary.shared.color = Color.palmSpringsSplash
            //PrimaryTabBar.shared.color = Colors.PalmSpringsSplash
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "colorDidChange"), object: nil)
        }
    }
    
    func configButtons(){
        color1.layer.cornerRadius = 15.0
        color1.layer.borderWidth = 2
        color1.layer.borderColor = UIColor.white.cgColor
        color1.backgroundColor = Colors.PeriWinkle
    
        
        color2.layer.cornerRadius = 15.0
        color2.layer.borderWidth = 2
        color2.layer.borderColor = UIColor.white.cgColor
        color2.backgroundColor = Colors.ExodusFruit
        
        
        color3.layer.cornerRadius = 15.0
        color3.layer.borderWidth = 2
        color3.layer.borderColor = UIColor.white.cgColor
        color3.backgroundColor = Colors.PicoVoid
        
        color4.layer.cornerRadius = 15.0
        color4.layer.borderWidth = 2
        color4.layer.borderColor = UIColor.white.cgColor
        color4.backgroundColor = Colors.WetAsphalt
        
        color5.layer.cornerRadius = 15.0
        color5.layer.borderWidth = 2
        color5.layer.borderColor = UIColor.white.cgColor
        color5.backgroundColor = Colors.Peach
    
        color6.layer.cornerRadius = 15.0
        color6.layer.borderWidth = 2
        color6.layer.borderColor = UIColor.white.cgColor
        color6.backgroundColor = Colors.OldGeranium
        
        color7.layer.cornerRadius = 15.0
        color7.layer.borderWidth = 2
        color7.layer.borderColor = UIColor.white.cgColor
        color7.backgroundColor = Colors.Aqua
        
        color8.layer.cornerRadius = 15.0
        color8.layer.borderWidth = 2
        color8.layer.borderColor = UIColor.white.cgColor
        color8.backgroundColor = Colors.PalmSpringsSplash
    }

}
