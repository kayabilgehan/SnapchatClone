import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func SignUpClicked(_ sender: Any) {
        if usernameText.text != "" && emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "An Error Occured 1.")
                }
                else {
                    let fireStore  = Firestore.firestore()
                    
                    let userDictionary = ["email": self.emailText.text!, "username": self.usernameText.text!] as [String: Any]
                    
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "An Error Occured 2.")
                        }
                        else {
                            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                        }
                    }
                    
                }
            }
        }
        else {
            makeAlert(title: "Error", message: "Email/Username/Password Error")
        }
    }
    @IBAction func SignInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "An Error Occured 1.")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else {
            makeAlert(title: "Error", message: "Email/Username/Password Error")
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

