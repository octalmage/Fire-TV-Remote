//
//  ComplicationController.swift
//  Fire TV Remote WatchKit Extension
//
//  Created by Jason Stallings on 10/28/18.
//  Copyright © 2018 Jason Stallings. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let template = getTemplate(complication: complication)
        
        let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template!)
        handler(timelineEntry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }

    func getTemplate(complication: CLKComplication?) -> CLKComplicationTemplate? {
        // This method will be called once per supported complication, and
        // the results will be cached
        
        var template: CLKComplicationTemplate?
        switch complication!.family {
        case .modularSmall:
            let modularSmallTemplate =
                CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider =
                CLKSimpleTextProvider(text: "F")
            modularSmallTemplate.fillFraction = 100
            modularSmallTemplate.ringStyle = CLKComplicationRingStyle.closed
            template = modularSmallTemplate
        case .utilitarianSmall:
            template = nil
        case .utilitarianLarge:
            template = nil
        case .circularSmall:
            template = nil
        case .utilitarianSmallFlat:
            template = nil
        case .extraLarge:
            template = nil
        case .graphicCorner:
            if #available(watchOSApplicationExtension 5.0, *) {
                let graphicCornerTemplate = CLKComplicationTemplateGraphicCornerStackText()
                graphicCornerTemplate.outerTextProvider = CLKSimpleTextProvider(text: "Get")
                graphicCornerTemplate.innerTextProvider = CLKSimpleTextProvider(text: "Money")
                template = graphicCornerTemplate
            } else {
                template = nil
            }
        case .graphicBezel:
            template = nil
        case .graphicCircular:
            template = nil
        case .graphicRectangular:
            template = nil
        case .modularLarge:
            template = nil
        }
        return template
        
    }
    
    func getPlaceholderTemplateForComplication(
        complication: CLKComplication,
        withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        handler(getTemplate(complication: complication))
    }
    
}
