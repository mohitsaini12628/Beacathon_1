import UIKit
import CoreLocation

class ItemCell: UITableViewCell {
    @IBOutlet weak var valueTextView: UITextView!
    
    var item: Item? {
        didSet {
            
            item?.addObserver(self, forKeyPath: "lastSeenBeacon", options: [.new], context: nil)
            textLabel!.text = item?.name
        }
        
        willSet {
            if let thisItem = item {
                thisItem.removeObserver(self, forKeyPath: "lastSeenBeacon")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func nameForProximity(proximity: CLProximity) -> String {
        switch proximity {
        case .unknown:
            return "Unknown"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        case .far:
            return "Far"
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let anItem = object as? Item, anItem == item && keyPath == "lastSeenBeacon" {
            let proximity = nameForProximity(proximity: anItem.lastSeenBeacon!.proximity)
            let accuracy = String(format: "%.2f", anItem.lastSeenBeacon!.accuracy)
            detailTextLabel!.text = "Location: \(proximity) (approx. \(accuracy)m)"
        }
    }
    
    deinit {
        item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
    }
    
}
