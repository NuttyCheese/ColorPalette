//
//  MainColorViewController.swift
//  ColorPalette
//
//  Created by Борис Павлов on 28.04.2022.
//

import UIKit

protocol SettingsColorsViewControllerDelegate {
    func newColor(for color: UIColor)
}

class MainColorViewController: UIViewController {
    
    var newColor = UIColor()
    
    override func viewDidLoad() {
        
        newColor = .white
        view.backgroundColor = newColor 
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let settingsColorsVoewController = navigationVC.topViewController as? SettingColorsViewController else { return }
        settingsColorsVoewController.colorPaletteView.backgroundColor = view.backgroundColor
        settingsColorsVoewController.delegate = self
    }
    
}

extension MainColorViewController: SettingsColorsViewControllerDelegate {
    func newColor(for color: UIColor) {
        newColor = color
        view.backgroundColor = newColor
    }
}
