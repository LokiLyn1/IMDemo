//
//  ChatMyVoiceCell.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit
import AVFoundation

protocol ChatMyVoiceCellDelegate {
    func voiceContentDidPressed(indexPath: IndexPath)
}

class ChatMyVoiceCell: UITableViewCell {

    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var chatContentView: UIControl!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var playingImageView: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    
    private var audioPath: String?
    private var indexPath: IndexPath?
    
    // MARK: Public
    
    
    public var animationSwitch: Bool = false {
        didSet{
            if animationSwitch {
                playingImageView.startAnimating()
            } else {
                playingImageView.stopAnimating()
            }
        }
    }
    
    public var delegate: ChatMyVoiceCellDelegate?
    
    func configWith(message: IMMessage, indexPath: IndexPath) {
        
        self.indexPath = indexPath
        nickNameLabel.text = message.from
        audioPath = message.audioObject.path
        timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        
        switch message.deliveryState {
        case .MessageDeliveryStateDeliveried:
            retryButton.isHidden = true
            timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateFailed:
            retryButton.isHidden = false
            timeLabel.text = "\(message.audioObject.duration!/1000 + 1)\""
        case .MessageDeliveryStateDelivering:
            retryButton.isHidden = true
            timeLabel.text = "Delivering"
        }
    }
    
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: Events
    
    @IBAction func voiceContentPressed(_ sender: UIControl) {
        playingImageView.animationImages = [#imageLiteral(resourceName: "MyVoicePlaying1"),#imageLiteral(resourceName: "MyVoicePlaying2"),#imageLiteral(resourceName: "MyVoicePlaying3")]
        playingImageView.animationDuration = 2
        animationSwitch = true
        if self.delegate != nil {
            self.delegate?.voiceContentDidPressed(indexPath: self.indexPath!)
        }
    }
    
}
