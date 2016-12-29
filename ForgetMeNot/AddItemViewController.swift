import UIKit

class AddItemViewController: UITableViewController {
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var majorIdTextField: UITextField!
    @IBOutlet weak var minorIdTextField: UITextField!
    
    var patternStr = "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
    
    var uuidRegex: NSRegularExpression!
    var nameFieldValid = false
    var UUIDFieldValid = false
    var newItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            uuidRegex = try NSRegularExpression(pattern: patternStr, options: [.caseInsensitive])
        }
        catch {
            
            print("Error while converting regex")
            
        }
        
            
            
        saveBarButtonItem.isEnabled = false
        
        nameTextField.addTarget(self, action: #selector(AddItemViewController.nameTextFieldChanged(_:)), for: .editingChanged)
        uuidTextField.addTarget(self, action: #selector(AddItemViewController.uuidTextFieldChanged(_:)), for: .editingChanged)
    }
    
    func nameTextFieldChanged(_ textField: UITextField) {
        
        nameFieldValid = ((textField.text?.characters.count)! > 0)
        saveBarButtonItem.isEnabled = (UUIDFieldValid && nameFieldValid)
    }
    
    func uuidTextFieldChanged(_ textField: UITextField) {
        
        
        let numberOfMatches = uuidRegex.numberOfMatches(in: textField.text!, options: [], range: NSMakeRange(0, (textField.text?.characters.count)!))
        
        
        UUIDFieldValid = (numberOfMatches > 0)
        
        saveBarButtonItem.isEnabled = (UUIDFieldValid && nameFieldValid)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveItemSegue" {
            
            
            let uuid = UUID(uuidString: uuidTextField.text!)
            
            
            
            let major = UInt16(Int(majorIdTextField.text!)!)
            let minor = UInt16(Int(minorIdTextField.text!)!)
            
            newItem = Item(name: nameTextField.text!, uuid: uuid!, majorValue: major, minorValue: minor)
        }
    }
}
