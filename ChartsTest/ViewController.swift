//
//  ViewController.swift
//  ChartsTest
//
//  Created by admin on 15.11.21.
//

import UIKit
import Charts

class ViewController: UIViewController {
    @IBOutlet var barChartView: BarChartView!
    
    let blueColor = UIColor.rgb(0x002b7f)
    let redCOlor = UIColor.rgb(0xce1126)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let values = [79465, 19947, 51216, 20871, 111461, 96604, 87007, 111461, 96604, 19947, 51216, 110922]
        let years = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021]
        let successCount = [1111, 2222, 3333, 4444, 5555, 6666, 7777, 8888, 9999, 10000, 110011, 1200012]
        
        setChart(values: values, years: years, data: successCount)
    }
    
    private func setChart(values: [Int], years: [Int], data: [Any]){
        var ordinEntries: [BarChartDataEntry] = []

        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(
                x: Double(years[i]),
                y: Double(values[i]),
                data: data[i]
            )
            ordinEntries.append(dataEntry)
        }

        let chartData = BarChartData()
        let dataSet = BarChartDataSet(entries: ordinEntries)
        dataSet.highlightColor = NSUIColor(cgColor: redCOlor.cgColor)
        dataSet.highlightAlpha = 1.0
        dataSet.barBorderWidth = 0
        dataSet.valueFont = UIFont(name: "Rockwell", size: 9)!
        dataSet.colors = [NSUIColor(cgColor: blueColor.cgColor)]
        
        chartData.addDataSet(dataSet)

        barChartView.delegate = self
        barChartView.data = chartData
        barChartView.legend.enabled = false
        barChartView.gridBackgroundColor = NSUIColor.white
        
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.gridLineDashLengths = [4,4]
        barChartView.leftAxis.gridColor = UIColor.rgb(0xc6c6c6)
        barChartView.leftAxis.labelFont = UIFont(name: "Rockwell", size: 9)!
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChartView.xAxis.granularity = 1
        barChartView.setVisibleXRange(minXRange: 6.0, maxXRange: 6.0)
        //barChartView.xAxis.labelRotationAngle = -45.0
        //barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        //barChartView.xAxis.setLabelCount(7, force: false)
        //barChartView.xAxis.axisRange = 7.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        barChartView.highlightValue(x: 0, dataSetIndex: 0)
    }
}

extension UIColor {
    static func rgb(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension ViewController: ChartViewDelegate {
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        print("chartValueSelected: x = \(highlight.x)")
        print(entry.data ?? "")
    }
    
    public func chartValueNothingSelected(_ chartView: ChartViewBase){
        print("chartValueNothingSelected")
    }
}
