//
//  CellGraphObject.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-14.
//  Copyright © 2017 Don. All rights reserved.
//

import Foundation
import UIKit
import Charts

class CellGraphObject: BarChartView {
    
    override init(frame: CGRect){
        super.init(frame : frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")/// Not sure if I need to do this
    }
    
    func formatChartView(chartView: BarChartView) -> BarChartView{
        
        //Just dubuggung
        //chartDataSet.colors = ChartColorTemplates.colorful()
        
        //Chart Layout
        chartView.rightAxis.spaceBottom = 0.0
        chartView.rightAxis.spaceTop = 0.0
        chartView.minOffset = 0
        chartView.backgroundColor = UIColor.clearColor()
        
        //Chart Labels and Values
        
        chartView.drawValueAboveBarEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.descriptionText = ""
        chartView.legend.enabled = false
        
        //Hiding Lines
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.drawBordersEnabled = false
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        
        //        self.chartView.leftAxis.calculate(min: 0.0, max: 10.0)
        //        self.chartView.rightAxis.calculate(min: 0.0, max: 10.0)
        
        //Chart Axis Values
        chartView.leftAxis.axisMinValue = 0
        chartView.rightAxis.axisMinValue = 0
        
        chartView.setScaleEnabled(true)
        
        return chartView
    }

    
}