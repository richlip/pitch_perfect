//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Richard Lipski on 29.12.20.
//  Copyright © 2020 Richard Lipski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recordAudio(_ sender: Any) {
        print("record Button was pressed")
        recordingLabel.text = "Recording in progress"
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop recording Button was pressed")
        recordingLabel.text = "Press Record again if you want it"
    }
}

