//
//  SettingColorsViewController.swift
//  ColorPalette
//
//  Created by Борис Павлов on 21.04.2022.
//

import UIKit

class SettingColorsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var colorPaletteView: UIView!
    
    @IBOutlet weak var redColorLabel: UILabel!
    @IBOutlet weak var numberRedLabel: UILabel!
    
    @IBOutlet weak var greenColorLabel: UILabel!
    @IBOutlet weak var numberGreenLabel: UILabel!
    
    @IBOutlet weak var blueColorLabel: UILabel!
    @IBOutlet weak var numberBlueLabel: UILabel!
    
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var numberAlphaLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    
    //MARK: - Private properties
    private var colors = UIColor()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        settingUpScreenItems()
    }

    //MARK: - IB Actions
    @IBAction func settingColors() {
        numberRedLabel.text = String(Int(redSlider.value))
        numberGreenLabel.text = String(Int(greenSlider.value))
        numberBlueLabel.text = String(Int(blueSlider.value))
        numberAlphaLabel.text = String(format: "%.2f", alphaSlider.value)
        
        colors = UIColor(
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255),
            alpha: CGFloat(alphaSlider.value)
        )
        
        colorPaletteView.backgroundColor = colors
        
    }
    
    //MARK: - Private methods
    private func settingUpScreenItems() {
        // views
        view.backgroundColor = .black
        colorPaletteView.layer.cornerRadius = 10
        colorPaletteView.backgroundColor = colorPaletteView.backgroundColor?.withAlphaComponent(0)
        
        // sliders
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        alphaSlider.value = 0
        
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        redSlider.minimumTrackTintColor = .red
        redSlider.maximumTrackTintColor = .darkGray
        redSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        greenSlider.minimumTrackTintColor = .green
        greenSlider.maximumTrackTintColor = .darkGray
        greenSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        blueSlider.minimumTrackTintColor = .blue
        blueSlider.maximumTrackTintColor = .darkGray
        blueSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        
        alphaSlider.minimumValue = 0
        alphaSlider.maximumValue = 1
        alphaSlider.minimumTrackTintColor = .white
        alphaSlider.maximumTrackTintColor = .darkGray
        alphaSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))

        // label colors
        redColorLabel.textColor = .red
        greenColorLabel.textColor = .green
        blueColorLabel.textColor = .blue
        
        // number colors
        numberRedLabel.text = "0"
        numberGreenLabel.text = "0"
        numberBlueLabel.text = "0"
        numberAlphaLabel.text = "0.00"
    }
}

