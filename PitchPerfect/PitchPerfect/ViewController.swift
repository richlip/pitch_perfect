//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Richard Lipski on 29.12.20.
//  Copyright © 2020 Richard Lipski. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        configureUI(RecordingState.recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print (filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print ("Started Recording")
    }
    
    // Stop Recording Button Tapped
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(RecordingState.notRecording)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    enum RecordingState {
       case  recording
      case notRecording
    }

    func  configureUI(_ recordingState: RecordingState) {
         switch recordingState {
               case .recording:
          stopRecordingButton.isEnabled = true
          recordButton.isEnabled = false
            recordingLabel.text = "Recording your audio...."
            
               case .notRecording:
         stopRecordingButton.isEnabled = false
          recordButton.isEnabled = true
         recordingLabel.text = "Tap to start recording"
    }
    }


    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)} else {
                    print ("Recording not finished")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

