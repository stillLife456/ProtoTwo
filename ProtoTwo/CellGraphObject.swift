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
    
    //Colours for graph
    let didNotSmokeColor = UIColor(hue: 0.2917, saturation: 0.4, brightness: 0.85, alpha: 1.0)
    let didSmokeColor = UIColor(hue: 0.9972, saturation: 0.52, brightness: 0.95, alpha: 1.0)
    
    var dataArray = [JournalEntry]()
    var xAxisArray = ["Y","N"]
    var yAxisArray = [3.0, 6.0]
    
    
    override init(frame: CGRect){
        super.init(frame : frame)
        
        
//        //Just dubuggung
//        //chartDataSet.colors = ChartColorTemplates.colorful()
//        
//        //Chart Layout
//        self.rightAxis.spaceBottom = 0.0
//        self.rightAxis.spaceTop = 0.0
//        self.minOffset = 0
//        self.backgroundColor = UIColor.clearColor()
//        
//        //Chart Labels and Values
//        
//        self.drawValueAboveBarEnabled = false
//        self.leftAxis.drawLabelsEnabled = false
//        self.rightAxis.drawLabelsEnabled = false
//        self.drawGridBackgroundEnabled = false
//        self.xAxis.drawLabelsEnabled = false
//        self.descriptionText = ""
//        self.legend.enabled = false
//        
//        //Hiding Lines
//        self.xAxis.drawGridLinesEnabled = false
//        self.drawBordersEnabled = false
//        self.leftAxis.drawAxisLineEnabled = false
//        self.rightAxis.drawAxisLineEnabled = false
//        self.leftAxis.drawGridLinesEnabled = false
//        self.rightAxis.drawGridLinesEnabled = false
//        
//        //        self.chartView.leftAxis.calculate(min: 0.0, max: 10.0)
//        //        self.chartView.rightAxis.calculate(min: 0.0, max: 10.0)
//        
//        //Chart Axis Values
//        self.leftAxis.axisMinValue = 0
//        self.rightAxis.axisMinValue = 0
//        
//        self.setScaleEnabled(true)
//        print("Styling Cell?")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // fatalError("init(coder:) has not been implemented")/// Not sure if I need to do this
    }
    
//    func formatChartView(chartView: BarChartView) -> BarChartView{
//        
//        //Just dubuggung
//        //chartDataSet.colors = ChartColorTemplates.colorful()
//        
//        //Chart Layout
//        chartView.rightAxis.spaceBottom = 0.0
//        chartView.rightAxis.spaceTop = 0.0
//        chartView.minOffset = 0
//        chartView.backgroundColor = UIColor.clearColor()
//        
//        //Chart Labels and Values
//        
//        chartView.drawValueAboveBarEnabled = false
//        chartView.leftAxis.drawLabelsEnabled = false
//        chartView.rightAxis.drawLabelsEnabled = false
//        chartView.drawGridBackgroundEnabled = false
//        chartView.xAxis.drawLabelsEnabled = false
//        chartView.descriptionText = ""
//        chartView.legend.enabled = false
//        
//        //Hiding Lines
//        chartView.xAxis.drawGridLinesEnabled = false
//        chartView.drawBordersEnabled = false
//        chartView.leftAxis.drawAxisLineEnabled = false
//        chartView.rightAxis.drawAxisLineEnabled = false
//        chartView.leftAxis.drawGridLinesEnabled = false
//        chartView.rightAxis.drawGridLinesEnabled = false
//        
//        //        self.chartView.leftAxis.calculate(min: 0.0, max: 10.0)
//        //        self.chartView.rightAxis.calculate(min: 0.0, max: 10.0)
//        
//        //Chart Axis Values
//        chartView.leftAxis.axisMinValue = 0
//        chartView.rightAxis.axisMinValue = 0
//        
//        chartView.setScaleEnabled(true)
//        
//        return chartView
//    }
//    
    func getChartData(dataPoints: [String], values: [Double]) -> BarChartData{ ////////////
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "")
        let chartData = BarChartData(xVals: xAxisArray, dataSet: chartDataSet)
        
        
        //Formatting?
        chartData.setDrawValues(false)// Hide chart value numerals on chart
        
        
        chartDataSet.barSpace = 0.1 // percent of view that is space between bars
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        chartDataSet.colors = [didSmokeColor,didNotSmokeColor]
        
        return chartData
        
        
    }

    
}