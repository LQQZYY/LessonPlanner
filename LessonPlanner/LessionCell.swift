//
//  LessionCell.swift
//  LessonPlanner
//
//  Created by Artron_LQQ on 2016/11/17.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class LessionCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    
    var lesson: Lesson? {
        
        didSet {
            if let lesson = lesson {
                
                switch lesson.state {
                
                case .invalid:
                    print("invalid")
                case .busy:
                    print("busy")
                    
                case .unSelected:
                    print("unSelected")
                    self.backgroundColor = UIColor.green
                case .selected:
                    print("selected")
                    self.backgroundColor = UIColor.red
                }
                
                self.titleLabel.text = lesson.time
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textAlignment = .center
        titleLabel.frame = self.bounds
        
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
