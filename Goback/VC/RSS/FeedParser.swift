//
//  XMLParser.swift
//  Goback
//
//  Created by Julian Wright on 3/3/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation

struct RSSItem {
    var title: String
    var description: String
    var pubDate: String
    var link: String
}

class FeedParser: NSObject, XMLParserDelegate
{
    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink: String = ""
    
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?)
    {
        self.parserCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            // parse
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentLink = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "pubDate": currentPubDate += string
        case "link": currentLink += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate: currentPubDate, link: currentLink)
            
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
    
    
}

