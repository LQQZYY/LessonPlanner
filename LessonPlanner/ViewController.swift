//
//  ViewController.swift
//  LessonPlanner
//
//  Created by Artron_LQQ on 2016/11/17.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collection: UICollectionView!
    var dataSource: [Lesson] = []
    var selected: [Lesson] = []
    
    var selectedLesson: [SelectedLesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0...200 {
            
            let less = Lesson()
            less.time = "\(i)"
            less.state = .unSelected
            self.dataSource.append(less)
        }
        
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 50, height: 30)
        layout.sectionInset = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        
        let collec = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collec.delegate = self
        collec.dataSource = self
        
        self.view.addSubview(collec)
        self.collection = collec
        
        collec.register(LessionCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        collec.backgroundColor = UIColor.white
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 50)
        button.setTitle("确认", for: .normal)
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.addSubview(button)
        button.backgroundColor = UIColor.orange
    }

    func btnClick() {
        
        if self.selectedLesson.count > 0 {
            
            self.selectedLesson.removeAll()
        }
        
        // 排序
        let arr = self.selected.sorted { (first, second) -> Bool in
            
            return Int(first.time!)! < Int(second.time!)!
        }
        
        for lesson in arr {
            // 输出排序后的数组
            print("\(lesson.time)")
        }
        
        // 记录当前比较的值的索引
        var index: Int = 0

        // 当索引小于数组长度时,继续比较
        while index < arr.count {
            
            // 取出第一个值
            var first = arr[index]
            // 取出在大数组中的索引
            var index1: Int = self.dataSource.index(of: first)!
            // 记录在大数组中的索引
            var range = NSRange()
            range.location = index1
            // 数组索引+1 ,从下一个开始判断
            index += 1
            for i in index..<arr.count {
                // 这里又取一次,是为了for循环内的比较
                first = arr[i-1]
                // 取出下一个元素
                let second = arr[i]
                // 比较差值
                if Int(second.time!)! - Int(first.time!)! == 1{
                // 差值为1,代表连续, 大数组索引+1,  小数组索引+1
                    index1 += 1
                    index += 1
                } else {
                    // 当不为1时,不连续,跳出循环
                    break
                }
            }
            // 一次遍历结束, 创建最终的model
            let select = SelectedLesson()
            // 计算长度
            range.length = index1 - range.location + 1
            
            select.range = range
            // 记录选中的连续区间
            self.selectedLesson.append(select)
        }
        
        print("******************************")
        for selec in self.selectedLesson {
            
            print("\(selec.range) + \(selec.range?.location) + \(selec.range?.length)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! LessionCell
        
        
        cell.lesson = self.dataSource[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! LessionCell
        let lesson = self.dataSource[indexPath.row]
        if lesson.state == .selected {
            
            lesson.state = .unSelected
        } else if lesson.state == .unSelected{
            
            lesson.state = .selected
        }
        
        cell.lesson = lesson
        
        if self.selected.contains(lesson) {
            let index = self.selected.index(of: lesson)
            
            self.selected.remove(at: index!)
        } else {
            
            self.selected.append(lesson)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

