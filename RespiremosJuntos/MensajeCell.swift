//
//  MensajeCell.swift
//  RespiremosJuntos
//
//  Created by Gabriel Castañaza on 10/2/15.
//  Copyright (c) 2015 Ministerio de Salud. All rights reserved.
//

import UIKit

class MensajeCell: UITableViewCell {
    
    @IBOutlet weak var heightAnswerText: NSLayoutConstraint!
    
    @IBOutlet weak var heightAnswerButton: NSLayoutConstraint!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var smileButton: UIButton!
    @IBOutlet weak var sendAnswerText: UITextView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var mensajeLabel: UILabel!
    
    
    var mensajesController: MensajesViewController!
    
    var height:CGFloat = 0.0

    
    var message = Message()
    
    @IBAction func sad(sender: AnyObject) {
        
        loading.startAnimating()
        loading.hidden = false
        
        message.parseObject[Message.ACCEPTED] = false
        message.parseObject.saveInBackgroundWithBlock { (end: Bool, error: NSError!) -> Void in
            if(error==nil){
                self.loading.stopAnimating()
                self.loading.hidden = true
                
                self.mensajesController.deleteMensaje(self.message)
            }
            
            
        }
        
        
    }
    
    @IBAction func smile(sender: AnyObject) {
        
        loading.startAnimating()
        loading.hidden = false
        
        message.parseObject[Message.ACCEPTED] = true
        message.parseObject.saveInBackgroundWithBlock { (end: Bool, error: NSError!) -> Void in
            
            if(error == nil){
                self.message.aceptado = true
                
                self.loading.stopAnimating()
                self.loading.hidden = true
                
                self.mensajesController.tableView.reloadData()
                
            }
            
           
            
        }
        
        
    }
    
    @IBAction func answer(sender: AnyObject) {
        
        let answer = sendAnswerText.text
        
        if(answer != ""){
            
            loading.startAnimating()
            loading.hidden = false
            
            message.parseObject[Message.ANSWER] = answer
            message.parseObject.saveInBackgroundWithBlock { (end: Bool, error: NSError!) -> Void in
                
                if(error==nil){
                    self.loading.stopAnimating()
                    self.loading.hidden = true
                    
                    self.message.answer = answer
                    
                    self.mensajesController.tableView.reloadData()
                }
                
                
                
            }
        }
        
        
        
        
    }
    
    func fill(){
        
        loading.hidden = true
        
        self.mensajeLabel?.text = message.text
        self.fromLabel.text = message.from.nombre
        self.answerLabel.text = message.answer
        
        if(message.aceptado){
            smileButton.hidden = true
            sadButton.hidden = true
            smileButton.frame = CGRectMake(smileButton.frame.origin.x, smileButton.frame.origin.y, smileButton.frame.width, 0)
            sadButton.frame = CGRectMake(sadButton.frame.origin.x, sadButton.frame.origin.y, sadButton.frame.width, 0)
        }else{
            smileButton.hidden = false
            sadButton.hidden = false
            smileButton.frame = CGRectMake(smileButton.frame.origin.x, smileButton.frame.origin.y, smileButton.frame.width, 36)
            sadButton.frame = CGRectMake(sadButton.frame.origin.x, sadButton.frame.origin.y, sadButton.frame.width, 36)
        }
        
        if(message.answer != ""){
            sendAnswerText.hidden = true
            heightAnswerText.constant = 0
            sendAnswerText.sizeToFit()
            answerView.hidden = false
            answerButton.hidden = true
            
        }else{
            sendAnswerText.hidden = false
            heightAnswerText.constant = 60
            answerButton.hidden = false
            answerView.hidden = true
        }
        
        if(message.answer != "" && message.aceptado){
            heightAnswerButton.constant = 0
        }else{
            heightAnswerButton.constant = 36
        }
        
        
        sizeToFit()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        height = sendAnswerText.frame.height
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
