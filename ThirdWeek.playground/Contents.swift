import UIKit
import Foundation

//作业一：显示时间日期
func getDateTime(data: Date,zone: Int = 0)->String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa HH:mm" //自定义时间日期的格式
    formatter.locale = Locale.current                    //设置当前位置，可以显示中文
    if zone >= 0{                                        //zone>0时区在东半区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone)00")
    }
    else{                                                //zone<0时区在西半区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone)00")
    }
    let dateString = formatter.string(from: now)         //将传入的日期转换为字符串(Date -> String)
    return dateString
}

let now = Date()                               //获取当前时间（零时区）
print(now)
let beijing = getDateTime(data: now, zone: +8) //北京在东八区
print("北京：\(beijing)")
let tokoy = getDateTime(data: now, zone: +9)   //东京在东九区
print("东京：\(tokoy)")
let newYork = getDateTime(data: now, zone: -5) //纽约在西五区
print("纽约：\(newYork)")
let london = getDateTime(data: now)            //伦敦在零时区
print("伦敦：\(london)")



//作业二：字符串和文件操作
//(1)
let str = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS."
let newstr1 = str[str.index(str.startIndex,offsetBy:6)...str.index(str.startIndex,offsetBy:20)]
print(newstr1)

let newstr2 = str.replacingOccurrences(of:"OS",with:"")                    //用""替换"OS"
print(newstr2)

//(2)
let dic = [["beijing":beijing,"tokoy":tokoy,"newYork":newYork,"london":london],["string":str]] as? AnyObject//将字典转换成任意类型以方便后面写入文件
let fileManager = FileManager.default    //获取默认的工作路径
var url1 = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
url1.appendPathComponent("test.txt")//在获取到的文件夹下增加一个文本文件
print(try? dic.write(toFile:url1,atomically:true))

//(3)
let path = URL(string:"http://img.game333.net/uploads/news/2015/05/26/20150526115723423.jpg")//通过执行url获取图片，并转换为二进制数
var url2 = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
url2.appendPathComponent("image.png")
try? image.write(to:url2)//将二进制数据存储为png图

//(4)
let url = URL(string: "http://www.weather.com.cn/data/sk/101110101.html")!         //api的路径
print(str)                 //显示json数据内容
let data = try Data(contentsOf: url)      //将json转换为二进制数据
let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)      //序列化json


if let dic = json as? [String: Any] {    //解析json数据
    if let weather = dic["weatherinfo"] as? [String: String] {
        let city = weather["city"]!
        let temp = weather["temp"]!
        print("城市: \(city), 温度: \(temp)")
    }
}
