//
//  Result.swift
//  Cost Calculator
//
//  Created by Samuel Brasileiro on 03/03/20.
//  Copyright © 2020 Samuel Brasileiro. All rights reserved.
//

import UIKit

class Result: UIView {
    
    init(nome: String, preco: String, recado: String, image: String) {
        
        let Nome = UILabel()
        Nome.frame = CGRect(x: 79, y: 14, width: 327, height: 54)
        Nome.text = nome
        Nome.font = UIFont(name: Nome.font.fontName, size: 36)
        
        let Preco = UILabel()
        Preco.frame = CGRect(x: 200, y: 77, width: 164, height: 53)
        Preco.text = "R$ " + preco
        
        let Recado = UILabel()
        Recado.frame = CGRect(x: 8, y: 189, width: 390, height: 165)
        Recado.text = recado
        Recado.numberOfLines = 4
        
        let Icone = UIImageView(image: UIImage(named: image))
        Icone.frame = CGRect(x: 8, y: 8, width: 65, height: 65)
        Icone.layer.masksToBounds = false
        Icone.layer.backgroundColor = CGColor(srgbRed: 158/256, green: 189/256, blue: 221/256, alpha: 1)
        Icone.layer.cornerRadius = Icone.frame.height/4
        Icone.clipsToBounds = true
        
        let Estimativa = UILabel()
        Estimativa.frame = CGRect(x: 8, y: 76, width: 184, height: 54)
        Estimativa.text = "Estimativa do mês:"
        
        let MRecado = UILabel()
        MRecado.frame = CGRect(x: 8, y: 138, width: 184, height: 54)
        MRecado.text = "Recado:"
        
        super.init(frame: CGRect(x: 17, y: 0, width: 397, height: 344))
        
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/12
        self.clipsToBounds = true
        
        self.addSubview(Nome)
        self.addSubview(Preco)
        self.addSubview(Recado)
        self.addSubview(Icone)
        self.addSubview(Estimativa)
        self.addSubview(MRecado)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
