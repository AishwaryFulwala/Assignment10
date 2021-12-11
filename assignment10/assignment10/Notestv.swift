//
//  Notestv.swift
//  assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Notestv: UIViewController {

    private let lbluname : UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let btnlo : UIButton = {
        let b = UIButton()
        b.setTitle("Log Out", for: .normal)
        b.addTarget(self, action: #selector(logout), for: .touchUpInside)
        b.layer.cornerRadius = 6
        b.backgroundColor = .gray
        b.tintColor = .white
        return b
    }()
    
    private let tb = UITableView()
    
    private var file = [String]()

    @objc private func handleNotes() {
        let nn = Notes()
        navigationController?.pushViewController(nn, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let notes = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleNotes))
        
        navigationItem.setRightBarButton(notes, animated: true)
        
        view.addSubview(lbluname)
        view.addSubview(tb)
        view .addSubview(btnlo)
        setupTableView()
        
        file = File.getfilenm()
        
        log()
    }
    
    
    override func viewDidLayoutSubviews() {
         lbluname.frame = CGRect(x: 50, y: 70, width: 150, height: 30)
         btnlo.frame = CGRect(x: 250, y: 70, width: 100, height: 30)
         tb.frame = CGRect(x: 0,
                          y: 110,
                          width: view.width,
                          height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    @objc private func logout() {
        UserDefaults.standard.setValue(nil, forKey: "username")
        log()
    }
    
    func log() {
        if let unm = UserDefaults.standard.string(forKey: "username") {
            lbluname.text = "Welcome \(unm)"
        }
        else {
            let l = Login()
            navigationController?.pushViewController(l, animated: true)
        }
    }
}

extension Notestv : UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tb.dataSource = self
        tb.delegate = self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return file.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = file[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nn = Notes()
        nn.name = file[indexPath.row]
        navigationController?.pushViewController(nn, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.file.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        let nm = file[indexPath.row]
        
        let path = File.getDocDir().appendingPathComponent("\(nm).txt")
        
        do {
            try FileManager.default.removeItem(at: path)
            
            let a = UIAlertController(title: "Attention", message: "\(nm) is Deleted", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Dissmiss", style: .cancel))
            self.present(a, animated: true)
        }
        catch {
            let a = UIAlertController(title: "Attention", message: "\(error)", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Dissmiss", style: .cancel))
            self.present(a, animated: true)
        }
    }
}
