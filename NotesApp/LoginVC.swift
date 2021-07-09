//
//  LoginVC.swift
//  NotesApp
//
//  Created by Aamir Burma on 08/07/21.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Login"
        title = "LOGIN"
        view.addSubview(myPassword)
        view.addSubview(myTextField)
        view.addSubview(myBtn)
        view.backgroundColor = .systemTeal
    }
    
    /** Adjust layout*/
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTextField.frame = CGRect(x: 20,y: 300, width: view.width - 40, height: 50)
        myPassword.frame = CGRect(x: 20,y: myTextField.bottom + 10, width: view.width - 40, height: 50)
        myBtn.frame = CGRect(x: 20,y: myPassword.bottom + 10, width: view.width - 40, height: 50)
        
    }

    /** Textbox for taking user name*/
    private let myTextField:UITextField = {
        let myUITextField = UITextField()
        myUITextField.placeholder = "ENTER USER NAME"
        myUITextField.textColor = .systemGreen
        myUITextField.autocorrectionType = .no
        myUITextField.autocapitalizationType = .none
        myUITextField.borderStyle = .roundedRect
        myUITextField.textAlignment = .center
        myUITextField.borderStyle = .roundedRect
        return myUITextField
    }()
    
    /** Textbox for password input*/
    private let myPassword:UITextField = {
        let myUITextField = UITextField()
        myUITextField.placeholder = "ENTER PASSWORD "
        myUITextField.textColor = .systemGreen
        myUITextField.isSecureTextEntry = true
        myUITextField.autocorrectionType = .no
        myUITextField.autocapitalizationType = .none
        myUITextField.borderStyle = .roundedRect
        myUITextField.textAlignment = .center
        myUITextField.borderStyle = .roundedRect
        return myUITextField
    }()
    
    /** Login btn*/
    private let myBtn: UIButton = {
        let myBtn = UIButton()
        myBtn.setTitle("LOGIN", for: .normal)
        myBtn.setTitleColor(.white, for: .normal)
        myBtn.layer.borderWidth = 5
        myBtn.addTarget(self, action: #selector(loginfunc), for: .touchUpInside)
        myBtn.backgroundColor = .systemGray
        myBtn.layer.cornerRadius = 27
        return myBtn
    }()
    
    /** Login check function*/
    @objc private func loginfunc(){
        
        /** If user authonicate currectly than jump out next view controller */
        if myTextField.text == "aamir" && myPassword.text == "aamir"{
            UserDefaults.standard.setValue("aamirLogin", forKey: "sessionToken")
            UserDefaults.standard.setValue(myTextField.text, forKey: "username")
            self.dismiss(animated: true)
            print("True")
            let vc = NotesVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        /** If user authentication become fail then prompt a message*/
        else{
            let  alert = UIAlertController(title: "Sorry!", message: "Incorrect username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true, completion: nil)
            print("False")
        }
    }
}
