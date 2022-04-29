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
    @IBOutlet weak var redTextField: UITextField!
    
    @IBOutlet weak var greenColorLabel: UILabel!
    @IBOutlet weak var numberGreenLabel: UILabel!
    @IBOutlet weak var greenTextField: UITextField!
    
    @IBOutlet weak var blueColorLabel: UILabel!
    @IBOutlet weak var numberBlueLabel: UILabel!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var numberAlphaLabel: UILabel!
    @IBOutlet weak var alphaTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    //MARK: - Public properties
    var delegate: SettingsColorsViewControllerDelegate!
    
    //MARK: - Private properties
    private var colorsSlider = UIColor()
    private var colorsTextField = UIColor()
    private let toolBar = UIToolbar()
    
    //MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        settingUpScreenItems()
        settingsToolBarItems()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        alphaTextField.delegate = self
        
        
    }

    //MARK: - IB Actions
    @IBAction func settingColors() {
        numberRedLabel.text = String(Int(redSlider.value))
        numberGreenLabel.text = String(Int(greenSlider.value))
        numberBlueLabel.text = String(Int(blueSlider.value))
        numberAlphaLabel.text = String(format: "%.2f", alphaSlider.value)
        
        redTextField.text = String(Int(redSlider.value))
        greenTextField.text = String(Int(greenSlider.value))
        blueTextField.text = String(Int(blueSlider.value))
        alphaTextField.text = String(format: "%.2f", alphaSlider.value)
        
        colorsSlider = UIColor(
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255),
            alpha: CGFloat(alphaSlider.value)
        )
        
        colorPaletteView.backgroundColor = colorsSlider
        
    }
    
    @IBAction func saveNewColor() {
        
        colorPaletteView.backgroundColor = colorsSlider
        print("RS:\(redSlider.value),GS:\(greenSlider.value),BS:\(blueSlider.value)")
        
        delegate.newColor(for: colorsSlider)
        
        dismiss(animated: true)
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
        
        // text filed colors
        redTextField.keyboardType = .decimalPad
        redTextField.inputAccessoryView = toolBar
        
        greenTextField.keyboardType = .decimalPad
        greenTextField.inputAccessoryView = toolBar
        
        blueTextField.keyboardType = .decimalPad
        blueTextField.inputAccessoryView = toolBar
        
        alphaTextField.keyboardType = .decimalPad
        alphaTextField.inputAccessoryView = toolBar
    }
    
    private func settingsToolBarItems() {
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, doneButtonItem], animated: true)
    }
    
    //MARK: - Objective-C methods
    @objc private func donePressed() {
        
        view.endEditing(true)
        
        
        print("RT:\(redTextField.text!),GT:\(greenTextField.text!),BT:\(blueTextField.text!)")
        
        colorPaletteView.backgroundColor = colorsTextField
        
        delegate.newColor(for: colorsTextField)
        
        dismiss(animated: true)
    }
}

extension SettingColorsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        guard let redValue = redTextField.text else { return }
        guard let red = Float(redValue) else { return }
        
        guard let greenValue = greenTextField.text else { return }
        guard let green = Float(greenValue) else { return }
        
        guard let blueValue = blueTextField.text else { return }
        guard let blue = Float(blueValue) else { return }
        
        guard let alphaValue = alphaTextField.text else { return }
        guard let alpha = Float(alphaValue) else { return }
        
        if textField == redTextField {
            redTextField.text = ""
            redSlider.value = red
        }else if textField == greenTextField {
            greenTextField.text = ""
            greenSlider.value = green
        }else if textField == blueTextField {
            blueTextField.text = ""
            blueSlider.value = blue
        }else if textField == alphaTextField {
            alphaTextField.text = ""
            alphaSlider.value = alpha
        }
        
        colorsTextField = UIColor(
            red: CGFloat(red / 255),
            green: CGFloat(green / 255),
            blue: CGFloat(blue / 255),
            alpha: CGFloat(alpha)
        )
        
        colorPaletteView.backgroundColor = colorsTextField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let redValue = redTextField.text else { return }
        guard let red = Float(redValue) else { return }
        
        guard let greenValue = greenTextField.text else { return }
        guard let green = Float(greenValue) else { return }
        
        guard let blueValue = blueTextField.text else { return }
        guard let blue = Float(blueValue) else { return }
        
        guard let alphaValue = alphaTextField.text else { return }
        guard let alpha = Float(alphaValue) else { return }
        
        if textField == redTextField {
            redSlider.value = red
        }else if textField == greenTextField {
            greenSlider.value = green
        }else if textField == blueTextField {
            blueSlider.value = blue
        }else if textField == alphaTextField {
            alphaSlider.value = alpha
        }
        
        colorsTextField = UIColor(
            red: CGFloat(red / 255),
            green: CGFloat(green / 255),
            blue: CGFloat(blue / 255),
            alpha: CGFloat(alpha)
        )
        
        colorPaletteView.backgroundColor = colorsTextField
    }
}

