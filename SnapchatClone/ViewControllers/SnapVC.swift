import UIKit
import ImageSlideshow


class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedSnap: SnapModel?
    var selectedTime: Int?
    var inputImageArray = [KingfisherSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = selectedSnap?.date {
            if let difference = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour{
                selectedTime = 24 - difference
            }
        }
        else {
            selectedTime = 0
        }
        
        
        if let time = selectedTime {
            timeLabel.text = "Time Left: \(time)"
        }
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputImageArray.append(KingfisherSource(urlString: imageUrl)!)
            }
            let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: self.view.frame.height * 0.90))
            imageSlideShow.backgroundColor = UIColor.white
            
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor.black
            pageIndicator.pageIndicatorTintColor = UIColor.lightGray
            imageSlideShow.pageIndicator = pageIndicator
            
            imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
            imageSlideShow.setImageInputs(inputImageArray)
            self.view.addSubview(imageSlideShow)
            self.view.bringSubviewToFront(timeLabel)
        }
    }
}
