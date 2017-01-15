//
//  ChartsTestViewController.swift
//  ProtoTwo
//
//  Created by Don on 2017-01-10.
//  Copyright © 2017 Don. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartsTestViewController: UIViewController {
    
    @IBOutlet weak var chartView: BarChartView!
    
    //properties
    var xAxis = ["Y","N"]
    var yAxis = [3.0,6.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart(xAxis, values: yAxis)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("The view was refreshed")
      
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        self.chartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "")
        let chartData = BarChartData(xVals: xAxis, dataSet: chartDataSet)
        
        
        //Just dubuggung
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        //Chart Layout
        chartDataSet.barSpace = 0.1 // percent of view that is space between bars
        self.chartView.rightAxis.spaceBottom = 0.0
        self.chartView.rightAxis.spaceTop = 0.0
        chartView.minOffset = 0
        chartView.backgroundColor = UIColor.clearColor()
        
        //Chart Labels and Values
        chartData.setDrawValues(false)// Hide chart value numerals on chart
        self.chartView.drawValueAboveBarEnabled = false
        self.chartView.leftAxis.drawLabelsEnabled = false
        self.chartView.rightAxis.drawLabelsEnabled = false
        self.chartView.drawGridBackgroundEnabled = false
        self.chartView.xAxis.drawLabelsEnabled = false
        self.chartView.descriptionText = ""
         self.chartView.legend.enabled = false
        
        //Hiding Lines
        self.chartView.xAxis.drawGridLinesEnabled = false
        self.chartView.drawBordersEnabled = false
        self.chartView.leftAxis.drawAxisLineEnabled = false
        self.chartView.rightAxis.drawAxisLineEnabled = false
        self.chartView.leftAxis.drawGridLinesEnabled = false
        self.chartView.rightAxis.drawGridLinesEnabled = false
        
//        self.chartView.leftAxis.calculate(min: 0.0, max: 10.0)
//        self.chartView.rightAxis.calculate(min: 0.0, max: 10.0)

        //Chart Axis Values
        chartView.leftAxis.axisMinValue = 0
        chartView.rightAxis.axisMinValue = 0

        chartView.setScaleEnabled(true)
       
        
        chartView.data = chartData
        
    }
    
  
    
//    @IBAction func prepareForUnwindToHelp(sender: UIStoryboardSegue) {
//    }
//    
}

