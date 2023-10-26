
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //dictionary for seconds
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var secondsRemaining = 60
    var timer = Timer()
    var progressDenom = 0.0
    var progressNumer = 0.0
    var player: AVAudioPlayer!

    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.currentTitle ?? "test")
        mainTitle.text = "How do you like your eggs?"
        
        //reset timer and progress bar
        timer.invalidate()
        progressBar.progress = 0.0
        progressNumer = 0.0
        
        //hold value from the input parameter.text
        //Soft, Medium, Hard
        let hardness = sender.currentTitle!
        
        //hold the value from the key passed to dictionary
        secondsRemaining = eggTimes[hardness]!          //this is an int
        
        //set progressCounter to value in dictionary
        progressDenom = Double(secondsRemaining)
        
        //start timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }//end hardnessSelected()
    
    
    @objc func updateTimer(){
        if secondsRemaining > 0{
            //debug statement
            print(secondsRemaining , "seconds")
            
            //increment
            secondsRemaining -= 1
            progressNumer += 1
            
            //update progressBar
            progressBar.progress = Float(progressNumer / progressDenom);
        }else{
            progressBar.progress = 1.0
            timer.invalidate()
            
            //play alarm sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            //update TextView
            mainTitle.text = "Done!"
        }
    }//end updateTimer()
}//end UIViewController()
