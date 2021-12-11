//
//  Login.swift
//  assignment10
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Login: UIViewController {

    private let lbltitle : UILabel = {
        let l = UILabel()
        l.text = "Sign IN"
        l.font = l.font.withSize(30)
        return l
    }()
    
    private let lbluname : UILabel = {
        let l = UILabel()
        l.text = "UserName :: "
        return l
    }()
    
    private let txtunm : UITextField = {
        let t = UITextField()
        t.borderStyle = .roundedRect
        return t
    }()
        
    private let lblpwd : UILabel = {
        let l = UILabel()
        l.text = "Password :: "
        return l
    }()
    
    private let txtpwd : UITextField = {
        let t = UITextField()
        t.borderStyle = .roundedRect
        t.isSecureTextEntry = true
        return t
    }()
    
    private let btnsignin : UIButton = {
        let b = UIButton()
        b.setTitle("Log IN", for: .normal)
        b.addTarget(self, action: #selector(signin), for: .touchUpInside)
        b.layer.cornerRadius = 6
        b.backgroundColor = .gray
        return b
    }()
    
    @objc private func signin() {
        UserDefaults.standard.setValue(txtunm.text, forKey: "username")
        self.dismiss(animated: true)
        
        let unm = UserDefaults.standard.string(forKey: "username")
        if unm != "" {
            let n = Notestv()
            navigationController?.pushViewController(n, animated: true)
        }
        else {
            let a = UIAlertController(title: "Attention", message: "Please enter Username & Password", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Dissmiss", style: .cancel))
            self.present(a, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(lbltitle)
        view.addSubview(lbluname)
        view.addSubview(lblpwd)
        view.addSubview(txtunm)
        view.addSubview(txtpwd)
        view.addSubview(btnsignin)
    }
    
    override func viewDidLayoutSubviews() {
        lbltitle.frame = CGRect(x: 140, y: view.safeAreaInsets.top + 40, width: 150, height: 50)
        lbluname.frame = CGRect(x: 50, y: lbltitle.bottom + 70, width: 150, height: 30)
        lblpwd.frame = CGRect(x: 50, y: lbluname.bottom + 40, width: 150, height: 30)
        
        txtunm.frame = CGRect(x: 150, y: lbltitle.bottom + 70, width: 170, height: 30)
        txtpwd.frame = CGRect(x: 150, y: txtunm.bottom + 40, width: 170, height: 30)
        btnsignin.frame = CGRect(x: 115, y: lblpwd.bottom + 50, width: 150, height: 40)
    }
}
