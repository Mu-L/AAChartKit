//
//  JSFunctionBeforeAndAfterRenderingComposer.m
//  AAChartKitDemo
//
//  Created by AnAn on 2024/10/25.
//  Copyright © 2024 An An. All rights reserved.
//

#import "JSFunctionBeforeAndAfterRenderingComposer.h"
#import "AAChartKit.h"


@implementation JSFunctionBeforeAndAfterRenderingComposer

///**
// * Get the current time
// */
//const getNow = () => {
//    const now = new Date();
//
//    return {
//        date: now,
//        hours: now.getHours() + now.getMinutes() / 60,
//        minutes: now.getMinutes() * 12 / 60 + now.getSeconds() * 12 / 3600,
//        seconds: now.getSeconds() * 12 / 60
//    };
//};
//
//let now = getNow();
//
//// Create the chart
//Highcharts.chart('container', {
//
//    chart: {
//        type: 'gauge',
//   
//        plotShadow: false,
//        height: '80%'
//    },
//
//    credits: {
//        enabled: false
//    },
//
//    title: {
//        text: 'The Highcharts clock'
//    },
//
//    pane: {
//        background: [{
//            // default background
//        }, {
//            // reflex for supported browsers
//            backgroundColor: {
//                radialGradient: {
//                    cx: 0.5,
//                    cy: -0.4,
//                    r: 1.9
//                },
//                stops: [
//                    [0.5, 'rgba(255, 255, 255, 0.2)'],
//                    [0.5, 'rgba(200, 200, 200, 0.2)']
//                ]
//            }
//        }]
//    },
//
//    yAxis: {
//        labels: {
//            distance: -23,
//            style: {
//                fontSize: '18px'
//            }
//        },
//        min: 0,
//        max: 12,
//        lineWidth: 0,
//        showFirstLabel: false,
//
//        minorTickInterval: 'auto',
//        minorTickWidth: 3,
//        minorTickLength: 5,
//        minorTickPosition: 'inside',
//        minorGridLineWidth: 0,
//        minorTickColor: '#666',
//
//        tickInterval: 1,
//        tickWidth: 4,
//        tickPosition: 'inside',
//        tickLength: 10,
//        tickColor: '#666',
//        title: {
//            text: 'Powered by<br/>Highcharts',
//            style: {
//                color: '#BBB',
//                fontWeight: 'normal',
//                fontSize: '10px',
//                lineHeight: '10px'
//            },
//            y: 10
//        }
//    },
//
//    tooltip: {
//        format: '{series.chart.tooltipText}'
//    },
//
//    series: [{
//        data: [{
//            id: 'hour',
//            y: now.hours,
//            dial: {
//                radius: '60%',
//                baseWidth: 4,
//                baseLength: '95%',
//                rearLength: 0
//            }
//        }, {
//            id: 'minute',
//            y: now.minutes,
//            dial: {
//                baseLength: '95%',
//                rearLength: 0
//            }
//        }, {
//            id: 'second',
//            y: now.seconds,
//            dial: {
//                radius: '100%',
//                baseWidth: 1,
//                rearLength: '20%'
//            }
//        }],
//        animation: false,
//        dataLabels: {
//            enabled: false
//        }
//    }]
//},
//
//// Move
//function (chart) {
//    setInterval(function () {
//
//        now = getNow();
//
//        if (chart.axes) { // not destroyed
//            const hour = chart.get('hour'),
//                minute = chart.get('minute'),
//                second = chart.get('second');
//
//            // Cache the tooltip text
//            chart.tooltipText = Highcharts.dateFormat('%H:%M:%S', now.date);
//
//            hour.update(now.hours, true, false);
//            minute.update(now.minutes, true, false);
//
//            // Move to 59 sec without animation ...
//            if (now.seconds === 0) {
//                second.update(-0.2, true, false);
//            }
//            // ... then bounce to next second
//            second.update(now.seconds, true, {
//                easing: 'easeOutBounce'
//            });
//        }
//
//    }, 1000);
//
//});
//
///**
// * Easing function from https://github.com/danro/easing-js/blob/master/easing.js
// */
//Math.easeOutBounce = function (pos) {
//    if ((pos) < (1 / 2.75)) {
//        return (7.5625 * pos * pos);
//    }
//    if (pos < (2 / 2.75)) {
//        return (7.5625 * (pos -= (1.5 / 2.75)) * pos + 0.75);
//    }
//    if (pos < (2.5 / 2.75)) {
//        return (7.5625 * (pos -= (2.25 / 2.75)) * pos + 0.9375);
//    }
//    return (7.5625 * (pos -= (2.625 / 2.75)) * pos + 0.984375);
//};

+ (AAOptions *)clockChart {
    AAChart *chart = AAChart.new
        .typeSet(AAChartTypeGauge)
    .eventsSet(AAChartEvents.new
               .loadSet(@AAJSFunc(
                                  // Move
                                  function (chart) {
                                      /**
                                        * Easing function from https://github.com/danro/easing-js/blob/master/easing.js
                                        */
                                       Math.easeOutBounce = function (pos) {
                                           if ((pos) < (1 / 2.75)) {
                                               return (7.5625 * pos * pos);
                                           }
                                           if (pos < (2 / 2.75)) {
                                               return (7.5625 * (pos -= (1.5 / 2.75)) * pos + 0.75);
                                           }
                                           if (pos < (2.5 / 2.75)) {
                                               return (7.5625 * (pos -= (2.25 / 2.75)) * pos + 0.9375);
                                           }
                                           return (7.5625 * (pos -= (2.625 / 2.75)) * pos + 0.984375);
                                       };
                                      
                                      function getNow() {
                                          var now = new Date();
                                          var timeInfo = {}; // 创建一个空对象

                                          // 逐步添加属性
                                          timeInfo.date = now;
                                          timeInfo.hours = now.getHours() + now.getMinutes() / 60;
                                          timeInfo.minutes = (now.getMinutes() * 12 / 60) + (now.getSeconds() * 12 / 3600);
                                          timeInfo.seconds = now.getSeconds() * 12 / 60;

                                          return timeInfo;
                                      }
                                      
                                      console.log("✈️-------------------");
                                      
                                      setInterval(function () {

                                          now = getNow();

                                              const hour = chart.get('hour'),
                                                  minute = chart.get('minute'),
                                                  second = chart.get('second');

                                              // Cache the tooltip text
                                              chart.tooltipText = Highcharts.dateFormat('%H:%M:%S', now.date);

                                              hour.update(now.hours, true, false);
                                              minute.update(now.minutes, true, false);

                                              // Move to 59 sec without animation ...
                                              if (now.seconds === 0) {
                                                  second.update(-0.2, true, false);
                                              }
                                              // ... then bounce to next second
                                              second.update(now.seconds, true, {
                                                  easing: 'easeOutBounce'
                                              });
                                              console.log("🕙时钟时间刷新正常-------------------");

                                          
                                          
                                          console.log("⏰定时器工作正常-------------------");


                                      }, 1000);

                                  })))
//        .plotShadowSet(NO)
//        .heightSet(@"80%")
    ;

    AACredits *credits = AACredits.new
        .enabledSet(NO);

    AATitle *title = AATitle.new
        .textSet(@"The Highcharts clock");

    AAGradientColor *backgroundGradient = AAGradientColor.new
        .radialGradientSet(AARadialGradient.new
                           .cxSet(@0.5)
                           .cySet(@-0.4)
                           .rSet(@1.9))
        .stopsSet(@[
            @[@0.5, @"rgba(255, 255, 255, 0.2)"],
            @[@0.5, @"rgba(200, 200, 200, 0.2)"]
        ]);

    AAPane *pane = AAPane.new
        .backgroundSet(@[
            AABackgroundElement.new,
            AABackgroundElement.new
                .backgroundColorSet((id)backgroundGradient)
        ]);

    AAYAxis *yAxis = AAYAxis.new
        .labelsSet(AALabels.new
            .distanceSet(@(-23))
            .styleSet(AAStyle.new
                .fontSizeSet(@"18px")
            )
        )
        .minSet(@0)
        .maxSet(@12)
        .lineWidthSet(@0)
//        .showFirstLabelSet(NO)
        .minorTickIntervalSet((id)@"auto")
        .minorTickWidthSet(@3)
        .minorTickLengthSet(@5)
        .minorTickPositionSet(@"inside")
        .minorGridLineWidthSet(@0)
        .minorTickColorSet(@"#666")
        .tickIntervalSet(@1)
        .tickWidthSet(@4)
        .tickPositionSet(@"inside")
        .tickLengthSet(@10)
        .tickColorSet(@"#666")
        .titleSet(AAAxisTitle.new
            .textSet(@"Powered by<br/>Highcharts")
            .styleSet(AAStyle.new
                .colorSet(@"#BBB")
                .fontWeightSet(AAChartFontWeightTypeRegular)
                .fontSizeSet(@"10px")
//                .lineHeightSet(@"10px")
            )
            .ySet(@10)
        );

    AATooltip *tooltip = AATooltip.new
        .formatSet(@"{series.chart.tooltipText}")
    ;
    
    AASeriesElement *hourSeries = AASeriesElement.new
        .dataSet(({
            // 获取当前时间
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];

            // 计算小时、分钟和秒针的位置
            double hours = components.hour + components.minute / 60.0;
            double minutes = components.minute * 12.0 / 60.0 + components.second * 12.0 / 3600.0;
            double seconds = components.second * 12.0 / 60.0;

            // 构造数据字典
            NSArray *dataArr = @[
                @{@"id"  : @"hour",
                  @"y"   : @(hours),
                  @"dial": @{
                      @"radius"    : @"60%",
                      @"baseWidth" : @4,
                      @"baseLength": @"95%",
                      @"rearLength": @0}
                },
                
                @{@"id"  : @"minute",
                  @"y"   : @(minutes),
                  @"dial": @{
                      @"baseLength": @"95%",
                      @"rearLength": @0}
                },
                
                @{@"id"  : @"second",
                  @"y"   : @(seconds),
                  @"dial": @{
                      @"radius"    : @"100%",
                      @"baseWidth" : @1,
                      @"rearLength": @"20%"}
                }
            ];

            // 打印结果
            NSLog(@"Series: %@", dataArr);
            
            dataArr;
        }))
    //        .animationSet(NO)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(NO));

    AAOptions *aaOptions = AAOptions.new
        .chartSet(chart)
        .creditsSet(credits)
        .titleSet(title)
        .paneSet(pane)
        .yAxisSet(yAxis)
        .tooltipSet(tooltip)
        .seriesSet(@[hourSeries]);
    
//    aaOptions.beforeDrawChartJavaScriptSet(@AAJSFunc(/** Get the current time
//                                                      */
//                                                      function getNow() {
//                                                          var now = new Date();
//                                                          var timeInfo = {}; // 创建一个空对象
//
//                                                          // 逐步添加属性
//                                                          timeInfo.date = now;
//                                                          timeInfo.hours = now.getHours() + now.getMinutes() / 60;
//                                                          timeInfo.minutes = (now.getMinutes() * 12 / 60) + (now.getSeconds() * 12 / 3600);
//                                                          timeInfo.seconds = now.getSeconds() * 12 / 60;
//
//                                                          return timeInfo;
//                                                      }
//
//                                                      alert("😄just test");
//
//                                                      var now = getNow();
//                                                      console.log(now); // 输出现在的日期时间信息
//                                                      )
//                                           );
    
//    aaOptions.afterDrawChartJavaScriptSet(@AAJSFunc(
//                                                    // Easing function from https://github.com/danro/easing-js/blob/master/easing.js
//                                                    Math.easeOutBounce = function (pos) {
//                                                        if (pos < (1 / 2.75)) {
//                                                            return (7.5625 * pos * pos);
//                                                        } else if (pos < (2 / 2.75)) {
//                                                            return (7.5625 * (pos -= (1.5 / 2.75)) * pos + 0.75);
//                                                        } else if (pos < (2.5 / 2.75)) {
//                                                            return (7.5625 * (pos -= (2.25 / 2.75)) * pos + 0.9375);
//                                                        } else {
//                                                            return (7.5625 * (pos -= (2.625 / 2.75)) * pos + 0.984375);
//                                                        }
//                                                    };
//                                                    )
//                                          );

    return aaOptions;
}

/**
 Highcharts.chart('container', {

     chart: {
         type: 'gauge',
         plotBackgroundColor: null,
         plotBackgroundImage: null,
         plotBorderWidth: 0,
         plotShadow: false,
         height: '80%'
     },

     title: {
         text: 'Speedometer'
     },

     pane: {
         startAngle: -90,
         endAngle: 89.9,
         background: null,
         center: ['50%', '75%'],
         size: '110%'
     },

     // the value axis
     yAxis: {
         min: 0,
         max: 200,
         tickPixelInterval: 72,
         tickPosition: 'inside',
         tickColor: Highcharts.defaultOptions.chart.backgroundColor || '#FFFFFF',
         tickLength: 20,
         tickWidth: 2,
         minorTickInterval: null,
         labels: {
             distance: 20,
             style: {
                 fontSize: '14px'
             }
         },
         lineWidth: 0,
         plotBands: [{
             from: 0,
             to: 130,
             color: '#55BF3B', // green
             thickness: 20,
             borderRadius: '50%'
         }, {
             from: 150,
             to: 200,
             color: '#DF5353', // red
             thickness: 20,
             borderRadius: '50%'
         }, {
             from: 120,
             to: 160,
             color: '#DDDF0D', // yellow
             thickness: 20
         }]
     },

     series: [{
         name: 'Speed',
         data: [80],
         tooltip: {
             valueSuffix: ' km/h'
         },
         dataLabels: {
             format: '{y} km/h',
             borderWidth: 0,
             color: (
                 Highcharts.defaultOptions.title &&
                 Highcharts.defaultOptions.title.style &&
                 Highcharts.defaultOptions.title.style.color
             ) || '#333333',
             style: {
                 fontSize: '16px'
             }
         },
         dial: {
             radius: '80%',
             backgroundColor: 'gray',
             baseWidth: 12,
             baseLength: '0%',
             rearLength: '0%'
         },
         pivot: {
             backgroundColor: 'gray',
             radius: 6
         }

     }]

 });

 // Add some life
 setInterval(() => {
     const chart = Highcharts.charts[0];
     if (chart && !chart.renderer.forExport) {
         const point = chart.series[0].points[0],
             inc = Math.round((Math.random() - 0.5) * 20);

         let newVal = point.y + inc;
         if (newVal < 0 || newVal > 200) {
             newVal = point.y - inc;
         }

         point.update(newVal);
     }

 }, 3000);
 */
+ (AAOptions *)speedometerChart {
    AAChart *chart = AAChart.new
        .typeSet(AAChartTypeGauge)
    //        .plotBackgroundColorSet(@"null")
            .plotBackgroundImageSet((id)NSNull.null)
//            .plotBorderWidthSet(@0)
    //        .plotShadowSet(NO)
//            .heightSet(@"80%")
    ;
    
    AATitle *title = AATitle.new
        .textSet(@"Speedometer");
    
    AAPane *pane = AAPane.new
        .startAngleSet(@(-90))
        .endAngleSet(@89.9)
        .backgroundSet((id)NSNull.null)
        .centerSet(@[@"50%", @"75%"])
        .sizeSet((id)@"110%");
    
    AAYAxis *yAxis = AAYAxis.new
        .minSet(@0)
        .maxSet(@200)
    //        .tickPixelIntervalSet(@72)
        .tickPositionSet(@"inside")
        .tickColorSet(@"#FFFFFF")
        .tickLengthSet(@20)
        .tickWidthSet(@2)
        .minorTickIntervalSet((id)NSNull.null)
        .labelsSet(AALabels.new
                   .distanceSet(@20)
                   .styleSet(AAStyle.new
                             .fontSizeSet(@"14px")
                             )
                   )
        .lineWidthSet(@0)
        .plotBandsSet(@[
            AAPlotBandsElement.new
                .fromSet(@0)
                .toSet(@130)
                .colorSet(@"#55BF3B")
                .thicknessSet(@20)
                .borderRadiusSet((id)@"50%")
            ,
            AAPlotBandsElement.new
                .fromSet(@150)
                .toSet(@200)
                .colorSet(@"#DF5353")
                .thicknessSet(@20)
                .borderRadiusSet((id)@"50%")
            ,
            AAPlotBandsElement.new
                .fromSet(@120)
                .toSet(@160)
                .colorSet(@"#DDDF0D")
                .thicknessSet(@20)
        ]);
    
    //https://github.com/AAChartModel/AAChartKit/issues/1589
    AAPlotOptions *aaPlotOptions = AAPlotOptions.new  // 创建图表配置对象
        .gaugeSet(AAGauge.new                         // 配置仪表盘类型
            .dialSet(AADial.new                       // 设置指针样式
                .radiusSet(@"80%")                    // 指针长度（容器宽度的80%）
                .backgroundColorSet(AAColor.grayColor)// 指针颜色（灰色）
                .baseWidthSet(@12)                    // 指针基部宽度（12像素）
                .baseLengthSet(@"0%")                 // 指针基部长度（0%不显示）
                .rearLengthSet(@"0%"))                // 指针尾部长度（0%不显示）
            .pivotSet(AAPivot.new                     // 设置中心轴点样式
                .backgroundColorSet(AAColor.grayColor)// 轴点颜色（灰色）
                .radiusSet(@6))                       // 轴点半径（6像素）
        );
    
    
    AASeriesElement *series = AASeriesElement.new
        .nameSet(@"Speed")
        .dataSet(@[@80])
        .tooltipSet(AATooltip.new
                    .valueSuffixSet(@" km/h"))
        .dataLabelsSet(AADataLabels.new
                       .formatSet(@"{y} km/h")
                       .borderWidthSet(@0)
                       .colorSet((id)@"#333333")
                       .styleSet(AAStyle.new
                                 .fontSizeSet(@"16px")
                                 ))
    //        .dialSet(AADial.new
    //                    .radiusSet(@"80%")
    //                    .backgroundColorSet(@"gray")
    //                    .baseWidthSet(@12)
    //                    .baseLengthSet(@"0%")
    //                    .rearLengthSet(@"0%"))
    //        .pivotSet(AAPivot.new
    //                    .backgroundColorSet(@"gray")
    //                    .radiusSet(@6))
    ;
    
    AAOptions *aaOptions = AAOptions.new
        .chartSet(chart)
        .titleSet(title)
        .paneSet(pane)
        .yAxisSet(yAxis)
        .plotOptionsSet(aaPlotOptions)
        .seriesSet(@[series]);
    
    aaOptions
        .afterDrawChartJavaScriptSet(@AAJSFunc(
                                               // Add some life
                                               setInterval(() => {
                                                   const chart = Highcharts.charts[0];
                                                   if (chart && !chart.renderer.forExport) {
                                                       const point = chart.series[0].points[0],
                                                       inc = Math.round((Math.random() - 0.5) * 60);
                                                       
                                                       let newVal = point.y + inc;
                                                       if (newVal < 0 || newVal > 200) {
                                                           newVal = point.y - inc;
                                                       }
                                                       
                                                       point.update(newVal);
                                                   }
                                                   
                                               }, 500);
                                               ));
    
    return aaOptions;
}


/**
 Highcharts.chart('container', {

     chart: {
         type: 'gauge',
         alignTicks: false,
         plotBackgroundColor: null,
         plotBackgroundImage: null,
         plotBorderWidth: 0,
         plotShadow: false
     },

     title: {
         text: 'Speedometer with dual axes'
     },

     pane: {
         startAngle: -150,
         endAngle: 150
     },

     yAxis: [{
         min: 0,
         max: 200,
         lineColor: '#339',
         tickColor: '#339',
         minorTickColor: '#339',
         offset: -25,
         lineWidth: 2,
         labels: {
             distance: -20,
             rotation: 'auto'
         },
         tickLength: 5,
         minorTickLength: 5,
         endOnTick: false
     }, {
         min: 0,
         max: 124,
         tickPosition: 'outside',
         lineColor: '#933',
         lineWidth: 2,
         minorTickPosition: 'outside',
         tickColor: '#933',
         minorTickColor: '#933',
         tickLength: 5,
         minorTickLength: 5,
         labels: {
             distance: 12,
             rotation: 'auto'
         },
         offset: -20,
         endOnTick: false
     }],

     series: [{
         name: 'Speed',
         data: [80],
         dataLabels: {
             format: '<span style="color:#339">{y} km/h</span><br/>' +
                 '<span style="color:#933">{(multiply y 0.621):.0f} mph</span>',
             backgroundColor: {
                 linearGradient: {
                     x1: 0,
                     y1: 0,
                     x2: 0,
                     y2: 1
                 },
                 stops: [
                     [0, '#DDD'],
                     [1, '#FFF']
                 ]
             }
         },
         tooltip: {
             valueSuffix: ' km/h'
         }
     }]

 },
 // Add some life
 function (chart) {
     setInterval(function () {
         if (chart.axes) { // not destroyed
             const point = chart.series[0].points[0],
                 inc = Math.round((Math.random() - 0.5) * 20);
             let newVal;

             newVal = point.y + inc;
             if (newVal < 0 || newVal > 200) {
                 newVal = point.y - inc;
             }

             point.update(newVal);
         }
     }, 3000);

 });

 */
+ (AAOptions *)speedometerWithDualAxesChart {
    AAChart *chart = AAChart.new
        .typeSet(AAChartTypeGauge)
    //        .alignTicksSet(NO)
    //        .plotBackgroundColorSet((id)NSNull.null)
        .plotBackgroundImageSet((id)NSNull.null)
    //        .plotBorderWidthSet(@0)
    //        .plotShadowSet(NO)
    ;
    
    AATitle *title = AATitle.new
        .textSet(@"Speedometer with dual axes");
    
    AAPane *pane = AAPane.new
        .startAngleSet(@(-150))
        .endAngleSet(@150);
    
    AAYAxis *yAxis1 = AAYAxis.new
        .minSet(@0)
        .maxSet(@200)
        .lineColorSet(@"#339")
        .tickColorSet(@"#339")
        .minorTickColorSet(@"#339")
        .offsetSet(@(-25))
        .lineWidthSet(@2)
        .labelsSet(AALabels.new
                   .distanceSet(@(-20))
                   .rotationSet((id)@"auto"))
        .tickLengthSet(@5)
        .minorTickLengthSet(@5)
        .endOnTickSet(NO);
    
    AAYAxis *yAxis2 = AAYAxis.new
        .minSet(@0)
        .maxSet(@124)
        .tickPositionSet(@"outside")
        .lineColorSet(@"#933")
        .lineWidthSet(@2)
        .minorTickPositionSet(@"outside")
        .tickColorSet(@"#933")
        .minorTickColorSet(@"#933")
        .tickLengthSet(@5)
        .minorTickLengthSet(@5)
        .labelsSet(AALabels.new
                   .distanceSet(@12)
                   .rotationSet((id)@"auto"))
        .offsetSet(@(-20))
        .endOnTickSet(NO);
    
    AASeriesElement *series = AASeriesElement.new
        .nameSet(@"Speed")
        .dataSet(@[@80])
        .dataLabelsSet(AADataLabels.new
                       .formatSet(@"<span style=\"color:#339\">{y} km/h</span><br/>\
                                <span style=\"color:#933\">{(multiply y 0.621):.0f} mph</span>".aa_toPureJSString)
                       
                       .backgroundColorSet((id)AAGradientColor.new
                                           .linearGradientSet(AALinearGradient.new
                                                              .x1Set(@0)
                                                              .y1Set(@0)
                                                              .x2Set(@0)
                                                              .y2Set(@1))
                                           .stopsSet(@[
                                            @[@0, @"#DDD"],
                                            @[@1, @"#FFF"]
                                           ])))
        .tooltipSet(AATooltip.new
                    .valueSuffixSet(@" km/h")
                    )
                       ;
    
    AAOptions *aaOptions = AAOptions.new
        .chartSet(chart)
        .titleSet(title)
        .paneSet(pane)
        .yAxisSet((id)@[yAxis1, yAxis2])
        .seriesSet(@[series]);
    
    aaOptions
        .afterDrawChartJavaScriptSet(@AAJSFunc(
                                               // Add some life
                                               setInterval(() => {
                                                   const chart = Highcharts.charts[0];
                                                   if (chart && !chart.renderer.forExport) {
                                                       const point = chart.series[0].points[0],
                                                       inc = Math.round((Math.random() - 0.5) * 60);
                                                       
                                                       let newVal = point.y + inc;
                                                       if (newVal < 0 || newVal > 200) {
                                                           newVal = point.y - inc;
                                                       }
                                                       
                                                       point.update(newVal);
                                                   }
                                                   
                                               }, 500);
                                               ));
    
    return aaOptions;
}

@end
