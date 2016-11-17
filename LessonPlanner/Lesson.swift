//
//  Lesson.swift
//  LessonPlanner
//
//  Created by Artron_LQQ on 2016/11/17.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

enum LessonState {
    case invalid, busy, unSelected, selected
}

class Lesson: NSObject {

    var time: String?
    
    var state: LessonState = .unSelected
}
