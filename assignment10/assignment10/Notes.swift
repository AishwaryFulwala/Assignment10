//
//  Notes.swift
//  assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Notes: UIViewController {

    var name: String?
    
    private let txtnm : UITextField = {
        let t = UITextField()
        t.placeholder = "File Name"
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        return t
    }()
    
    private let tvcontent : UITextView = {
        let t = UITextView()
        t.text = ""
        t.layer.borderWidth = 0.2
        t.layer.cornerRadius = 7
        t.textAlignment = .center
        return t
    }()
    
    private let btnsave : UIButton = {
        let b = UIButton()
        b.setTitle("Save Notes", for: .normal)
        b.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        b.layer.cornerRadius = 6
        b.backgroundColor = .gray
        b.tintColor = .white
        return b
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(txtnm)
        view.addSubview(tvcontent)
        view.addSubview(btnsave)
   
        if(name != "") {
            txtnm.text = name
        }
        else {
            txtnm.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(txtnm.text != "") {
            do {
                let nm = txtnm.text!
                let path = File.getDocDir().appendingPathComponent("\(nm)")
                tvcontent.text = try String(contentsOf: path)
            }
            catch {
                let a = UIAlertController(title: "Attention", message: "\(error)", preferredStyle: .alert)
                a.addAction(UIAlertAction(title: "Dissmiss", style: .cancel))
                self.present(a, animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        txtnm.frame = CGRect(x: 40, y: 70, width: view.width - 80, height: 40)
        tvcontent.frame = CGRect(x: 40, y: txtnm.bottom + 20, width: view.width - 80, height: 300)
        btnsave.frame = CGRect(x: 40, y: tvcontent.bottom + 20, width: view.width - 80 , height: 40)
    }
    
    @objc private func saveNote() {
        let nm = txtnm.text!
        let con = tvcontent.text!
        var path = File.getDocDir().appendingPathComponent("\(nm).txt")
        
        if (name == "") {
            path = File.getDocDir().appendingPathComponent("\(nm).txt")
        }
        else {
            path = File.getDocDir().appendingPathComponent("\(nm)")
        }
        
        do {
            try con.write(to: path, atomically: true, encoding: .utf8)
            
            txtnm.text = ""
            tvcontent.text = ""
            
            let nn = Notestv()
            navigationController?.pushViewController(nn, animated: true)
        }
        catch {
            let a = UIAlertController(title: "Attention", message: "\(error)", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Dissmiss", style: .cancel))
            self.present(a, animated: true)
        }
    }
}
