import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = NSLocalizedString("HOMEPAGE-PLACEHOLDER", comment: "Homepage - placeholder")
    }


}

