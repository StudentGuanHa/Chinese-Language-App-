//
//  ViewController.swift
//  Random
//
//  Created by Harry Guan on 8/7/21.
//

import UIKit
import SwiftUI


//Combine them into a dictionary
var userName: [String: String] = [:]

class ViewController: UIViewController {
    //IBOutlets
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passWordField: UITextField!
    @IBOutlet var button: UIButton!
    @IBOutlet var singUpButton: UIButton!
    @IBOutlet var showingButton : UIButton!

    // Class Scope Variable Declaration
    let textObject = UILabel()
    private var isInvisible = true
    private var isOriginal = ""
    @objc func textFieldDidChange(_ sender : UITextField){
//        if isInvisible{
//            let originalText = passWordField.text
//            passWordField.text = originalText
//        }

    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        passWordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.

    }
    
    
    
    @IBAction func passWordControl(_ sender: UITextField) {
        if sender.text?.count == 0 {
            passWordField.text = "Password"

        }
    }
    
    @IBAction func passWordHandler(_ sender: UITextField){
        passWordField.clearsOnBeginEditing = false
    }
    
    
    @IBAction func singUp(){
        present(SecondViewController(), animated: true)
    }
    
    @IBAction func userNameControl (_ sender: UITextField){
        if sender.text?.count == 0 {
            userNameField.text = "Username"
        }
    }
    
    
    @IBAction func isShowing (){        
        isInvisible = !isInvisible
        if isInvisible {
            //Assigning Password text
            showingButton.setImage(UIImage(named: "Show"), for: .normal)
            passWordField.isSecureTextEntry = true
            isOriginal = passWordField.text!
            
        }
        else{
            showingButton.setImage(UIImage(named: "Hide"), for: .normal)
            passWordField.isSecureTextEntry = false
        }
    }
    
    @IBAction func buttonTapped(){
        // usernames, 0 = Fullname , 1 = Username , 2 = Password
        print(userName)
        guard let vc = storyboard?.instantiateViewController(identifier: "HubView") as? HubViewController else{
            print("Failed to get vc")
            return
        }
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        present(vc, animated: true)
        if userName.keys.contains(userNameField.text!) && userName[userNameField.text!] == passWordField.text!{
            //Load to the hub page of the app
            print("Navigate to Hub page")
            let storyboard = UIStoryboard(name: "Hub", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HubViewController") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}

class SecondViewController: UIViewController {
    //Initialising fields
    var bgImage : UIImageView?
    var usernameField : UITextField?
    var passwordField : UITextField?
    struct Message {
        static var message = UILabel()
    }
    
    let WARNINGCOLOR =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    let VALIDCOLOR =  #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    @objc private func emailHandler(_ sender : UITextField){
        // do something
        if !(sender.text?.contains("@") ?? false){
            sender.backgroundColor = WARNINGCOLOR
        }
        else {
            sender.backgroundColor = VALIDCOLOR
        }
        let warningEmail : UILabel = {
            let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:100))
            label.highlightedTextColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            return label
        }()
        
        view.addSubview(warningEmail)
//        guard ((sender.text?.contains("@")) != nil) else{
//        }
    }
    
  
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        //Logo has a 1 to 1 pixel density ratio
        let image: UIImage = UIImage(named: "thumbnail_love language")!
        
        Message.message.text = "watashi wa"
        Message.message.isHidden = true
        Message.message.translatesAutoresizingMaskIntoConstraints = false
        Message.message.isHighlighted = true
        Message.message.font = UIFont(name: "Arial", size: 15)
        Message.message.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        bgImage = UIImageView(image: image)
        bgImage?.translatesAutoresizingMaskIntoConstraints = false
        
        usernameField = UITextField()
        usernameField?.addTarget(self, action: #selector(usernameHandler), for: .editingChanged)
        
        passwordField = UITextField()
        passwordField?.addTarget(self, action: #selector(passwordHandler), for: .editingChanged)
        
        //bgImage!.frame = CGRect(x:150, y:50, width:150, height:150)
        //Create your Password
        
        let label : UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:100))
        label.font = UIFont(name: "Arial", size: 25)
        label.text = "Create"
        return label
        }()
        
        let signUpButton : UIButton = UIButton()
        signUpButton.addTarget(self,action: #selector(signUpHandler), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        let email : UITextField = UITextField()
        email.addTarget(self, action: #selector(emailHandler), for: .editingChanged)
        
        view.addSubview(Message.message)
        view.addSubview(passwordField!)
        view.addSubview(usernameField!)
        view.addSubview(email)
        view.addSubview(label)
        self.view.addSubview(bgImage!)
        
        addConstraints(label: label, emailAddress: email, signUpButton: signUpButton)
    }
    
    @objc private func usernameHandler(_ sender: UITextField){
        if(sender.text!.count < 5){
            sender.backgroundColor = WARNINGCOLOR
        }
        else{
            sender.backgroundColor = VALIDCOLOR
        }
    }
    func checkTextSufficientComplexity(_ text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        var texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        var capitalresult = texttest.evaluate(with: text)

        let numberRegEx  = ".*[0-9]+.*"
        var texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        var numberresult = texttest1.evaluate(with: text)


        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        var texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

        var specialresult = texttest2.evaluate(with: text)

        return capitalresult && numberresult || specialresult

    }
    
    @objc private func passwordHandler(_ sender : UITextField){
        //Must include 8 word long password, must Have capital letter,
        if sender.text!.count < 8 || !checkTextSufficientComplexity(sender.text!) {
            sender.backgroundColor = WARNINGCOLOR
            
        }
        else{
            sender.backgroundColor = VALIDCOLOR
        }
    }
    
    @objc private func signUpHandler(){
        guard usernameField!.text! != "" && passwordField!.text! != "" else{
            Message.message.isHidden = false
            Message.message.text = "At least one of the fields are not completed"
            print("At least one of the fields \r\n nare not completed")
            return
        }
        if (userName.keys.contains(usernameField!.text!)){
            //Make this into real life
            Message.message.isHidden = false
            Message.message.text = "Your Username already exist, please try logging in"
            print("Your Username already exist, please try logging in")
        }
        else{
            userName[usernameField!.text!] = passwordField!.text
            Message.message.isHidden = false
            Message.message.textColor = VALIDCOLOR
            Message.message.text = "You have successfully made an account"
        }
    }
    
    private func addConstraints(label : UILabel, emailAddress : UITextField, signUpButton : UIButton){
        var constraints = [NSLayoutConstraint]()
        
        //add Logo Object
        constraints.append(bgImage!.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(bgImage!.heightAnchor.constraint(equalToConstant: 150))
        constraints.append(bgImage!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150))
        constraints.append(NSLayoutConstraint(item: bgImage!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        //add Label Object
        label.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(label.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(label.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(label.topAnchor.constraint(equalTo: bgImage!.bottomAnchor, constant: 20))
        constraints.append(label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -120))
        
        //warning message
        constraints.append(Message.message.widthAnchor.constraint(equalToConstant: 500))
        constraints.append(Message.message.heightAnchor.constraint(equalToConstant: 200))
        constraints.append(Message.message.topAnchor.constraint(equalTo: label.bottomAnchor,
                                                constant: -100))
        constraints.append(NSLayoutConstraint(item: Message.message, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 100))
        
        // ---------------------  UI Textfields ------------------------------- \\
        //width 314 Height 50
        emailAddress.translatesAutoresizingMaskIntoConstraints = false
        emailAddress.placeholder = "Email Address"
        emailAddress.font = UIFont.systemFont(ofSize: 23)
        constraints.append(NSLayoutConstraint(item: emailAddress, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 314))
        constraints.append(NSLayoutConstraint(item: emailAddress, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        constraints.append(NSLayoutConstraint(item: emailAddress, attribute: .top, relatedBy: .equal, toItem: label, attribute: .bottom, multiplier: 1, constant: 25))
        constraints.append(NSLayoutConstraint(item: emailAddress, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50))
        
        //Adding UsernameField
        usernameField?.translatesAutoresizingMaskIntoConstraints = false
        usernameField?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        usernameField?.placeholder = "Username"
        usernameField?.font = UIFont.systemFont(ofSize: 23)
        constraints.append(NSLayoutConstraint(item: usernameField, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 314))
        constraints.append(NSLayoutConstraint(item: usernameField, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        constraints.append(NSLayoutConstraint(item: usernameField, attribute: .top, relatedBy: .equal, toItem: emailAddress, attribute: .bottom, multiplier: 1, constant: 25))
        constraints.append(NSLayoutConstraint(item: usernameField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50))
        //Adding PsssowrdField
        passwordField?.translatesAutoresizingMaskIntoConstraints = false
        passwordField?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordField?.placeholder = "Password"
        passwordField?.font = UIFont.systemFont(ofSize: 23)
        passwordField?.isSecureTextEntry = true
        constraints.append(NSLayoutConstraint(item: passwordField, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 314))
        constraints.append(NSLayoutConstraint(item: passwordField, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 50))
        constraints.append(NSLayoutConstraint(item: passwordField, attribute: .top, relatedBy: .equal, toItem: usernameField, attribute: .bottom, multiplier: 1, constant: 25))
        constraints.append(NSLayoutConstraint(item: passwordField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50))
        
        //Sign Up Button attributes
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        signUpButton.titleLabel?.font = UIFont(name: "Arial", size: 23)
        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 226))
        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 55))
        constraints.append(signUpButton.topAnchor.constraint(equalTo: passwordField!.bottomAnchor, constant: 50))
//        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: .top, relatedBy: .equal, toItem: passwordField, attribute: .bottom, multiplier: 1, constant: 50))
        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    
        //activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
}


class HubViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")

    }
    
    

}
