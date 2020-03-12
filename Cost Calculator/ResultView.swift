//
//  Result.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 03/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    init(system: System) {
        super.init(frame: CGRect(x: 17, y: 0, width: 397, height: 344))
        let name = system.name
        let price = system.estimarCusto()
        let note = system.analisarUtilidade()
        let image = system.image
        let Name = UILabel()
        Name.frame = CGRect(x: 79, y: 14, width: 327, height: 54)
        Name.text = name
        Name.font = UIFont(name: "Aspira", size: 42)
        
        
        let Price = UILabel()
        Price.frame = CGRect(x: 200, y: 77, width: 164, height: 53)
        Price.text = "R$ " + String(format: "%.2f", price)
        Price.font = UIFont(name: "Aspira", size: 18)
        
        let Note = UILabel()
        Note.frame = CGRect(x: 8, y: 160, width: 340, height: 165)
        Note.text = note
        Note.numberOfLines = 4
        Note.font = UIFont(name: "Aspira", size: 18)
        
        let Icone = UIImageView(image: UIImage(systemName: image))
        Icone.frame = CGRect(x: 8, y: 8, width: 65, height: 65)
        Icone.tintColor = .black
        Icone.contentMode = .scaleAspectFit
        Icone.layer.masksToBounds = false
        Icone.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        Icone.layer.cornerRadius = Icone.frame.height/4
        Icone.clipsToBounds = true
        
        let Estimate = UILabel()
        Estimate.frame = CGRect(x: 8, y: 76, width: 184, height: 54)
        Estimate.text = "Estimativa \(system.time.getString()):"
        Estimate.font = UIFont(name: "Aspira", size: 18)
        
        let MNote = UILabel()
        MNote.frame = CGRect(x: 8, y: 138, width: 184, height: 54)
        MNote.text = "Recado:"
        MNote.font = UIFont(name: "Aspira", size: 18)
        
        
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/12
        self.clipsToBounds = true
        
        self.addSubview(Name)
        self.addSubview(Price)
        self.addSubview(Note)
        self.addSubview(Icone)
        self.addSubview(Estimate)
        self.addSubview(MNote)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
