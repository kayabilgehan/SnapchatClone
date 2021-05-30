import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        }
        catch{
            print("Logout Error")
        }
        
    }
}
