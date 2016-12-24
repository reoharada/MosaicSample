//
//  ViewController.swift
//  imageMosaicSample
//
//  Created by REO HARADA on 2016/12/24.
//  Copyright © 2016年 REO HARADA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var filterPickerView: UIPickerView!
    @IBOutlet weak var rasterizationSlideBar: UISlider!
    
    var filter = [
        kCAFilterTrilinear,
        kCAFilterLinear,
        kCAFilterNearest
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ガウシアンフィルタ
        // レイヤーをラスタライズする
        mainImageView.layer.shouldRasterize = true
        // ラスタライズの縮小率
        mainImageView.layer.rasterizationScale = 0.005
        rasterizationSlideBar.value = 0.005
        // 縮小時のフィルタの種類
        mainImageView.layer.minificationFilter = kCAFilterTrilinear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func slideBar(_ sender: Any) {
        let slideBar = sender as? UISlider
        if let value = slideBar?.value {
            mainImageView.layer.rasterizationScale = CGFloat(value)
        }
    }
    
    @IBAction func playMosaic(_ sender: Any) {
        mainImageView.layer.magnificationFilter = kCAFilterNearest
    }
    
    @IBAction func tapResetButton(_ sender: Any) {
        mainImageView.layer.magnificationFilter = kCAFilterLinear
    }
    
    @IBAction func resetMosaicFade(_ sender: Any) {
        let count = 0.001
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.mainImageView.layer.rasterizationScale = self.mainImageView.layer.rasterizationScale + CGFloat(count)
            self.rasterizationSlideBar.value = Float(self.mainImageView.layer.rasterizationScale)
            if self.mainImageView.layer.rasterizationScale >= 1.0 {
                timer.invalidate()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filter.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filter[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mainImageView.layer.minificationFilter = filter[row]
    }
    
}

