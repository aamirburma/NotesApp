//
//  NotesVC.swift
//  NotesApp
//
//  Created by Aamir Burma on 08/07/21.
//

import UIKit

class NotesVC: UIViewController {

    private var notesArray = [String]()
    private let notestbl = UITableView()
    // make instance
    let service = DataService()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NOTES"
        print(getDocDir())
        view.backgroundColor = .systemTeal
        let additem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem1, animated: true)
        let additem2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNotes))
        navigationItem.setLeftBarButton(additem2, animated: true)
        setuptbl()
        // Do any additional setup after loading the view.
    }
       
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "sessionToken")
        checkAuth()
    }
        
    // extract notes from directory
    private func fetchNotes(){
        
        
        
        let path = getDocDir()
        do{
            let item = try FileManager.default.contentsOfDirectory(at : path, includingPropertiesForKeys: nil)
            notesArray.removeAll()
            for i in item{
                notesArray.append(i.lastPathComponent)
            }
        }catch{
            print(error)
        }
        
    
        notestbl.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotes()
        checkAuth()
        
    }
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "sessionToken"),
        let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(name) | \(token)")
            
        }
        else{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
            
        }
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        notestbl.frame = view.bounds
    }
        
    // create document directory
    @objc private func openNotes(){
        let vc = NewNotesVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension NotesVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for : indexPath)
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
        
    private func setuptbl(){
        
        notestbl.register(UITableViewCell.self, forCellReuseIdentifier: "notesCell")
        notestbl.delegate = self
        notestbl.dataSource = self
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNotesVC()
        vc.updatefile = notesArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
        
    private func getDocDir() -> URL
    {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("path::  \(path[0])")
        return path[0]
    }
}

