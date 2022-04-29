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


    override func viewDidLoad() {
        view.backgroundColor = .black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsColorsViewController = segue.destination as? SettingColorsViewController else { return }
        settingsColorsViewController.newColor = view.backgroundColor ?? .white
        settingsColorsViewController.delegate = self
        view.backgroundColor = settingsColorsViewController.newColor
        
    }
}

extension MainColorViewController: SettingsColorsViewControllerDelegate {
    func newColor(for color: UIColor) {
        view.backgroundColor = color
    }
}
