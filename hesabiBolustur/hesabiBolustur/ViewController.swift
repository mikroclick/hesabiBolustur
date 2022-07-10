//
//  ViewController.swift
//  bolustur
//
//  Created by macbook on 12.02.2022.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var tutar: UITextField!
    @IBOutlet private weak var kisi: UITextField!
    @IBOutlet private weak var bahsis: UITextField!
    @IBOutlet private weak var sonuc: UILabel!
    @IBOutlet private weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named:"image")
        // Do any additional setup after loading the view.
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    @IBAction private func hesapla(_ sender: Any) {
        
        let tutar = tutar.text ??  ""
        let kisi = kisi.text ??  "" 
        let bahsis = bahsis.text ??  ""
        
        guard let t = Float(tutar), let k = Float(kisi)  else {
            sonuc.text = "Eksik tutar veya kişi"
            return
        }
        let kisiBasi = Float(t/k)
        
        if let b = Float(bahsis){
            sonuc.text = String("\(kisiBasi/100*b+kisiBasi) TL")
            return
        }
        
        sonuc.text = String("\(kisiBasi) TL")
    }
    
}

