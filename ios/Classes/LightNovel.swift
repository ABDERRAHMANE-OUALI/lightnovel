//
//  LightNovel.swift
//  lightnovel
//
//  Created by ABDERRAHMANE OUALI on 25/6/2022.
//

import Foundation
import SwiftSoup


class LightNovel{
    private func getHtmlContent(url : String) -> Document? {
        var doc: Document?
        do{
            let content = try String(contentsOf: URL(string: url)!)
            doc = try SwiftSoup.parse(content)
        }catch{
            print(error)
        }
        return doc
    }
    
    func getLightNovelInfo(name: String) -> Dictionary<String, Any?>? {
        var lightnovel: Dictionary<String, Any?>?
        do{
            let doc = getHtmlContent(url: "https://octopii.co/novel/\(name)")
            let title = try doc?.select("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-12.col-sm-9 > h3").first?.text()
            let cover = try "https://octopii.co/" + (doc?.select("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-6.col-sm-3.pe-1.image-wrapper > div > img.w-100.h-100.rounded-5.position-absolute").first?.attr("src") ?? "")
            let author = try doc?.select("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-12.col-sm-9 > div.author-container.d-flex.lh-1rem.flex-wrap > div > a").text()
            let description = try doc?.select("#novel-desc").first?.attr("data-desc")
            var chapters: Array<Dictionary<String, Any?>> = []
            try doc?.select("#chapter-list-content > div > div > a").forEach({ element in
                let name = try? element.text()
                let url = try? element.attr("href")
                chapters.append(["name": name, "url": url])
                }
            )
            return ["title": title, "cover": cover, "author": author, "description": description, "chapters": chapters]

        }catch{
            print(error)
        }
        
        return lightnovel
    }
    
    func getChapterContent(url: String) -> String {
        let doc = try getHtmlContent(url: url)
        var content = ""
        try? doc?.select("#chapter-content > div").first()?.children().forEach({element in
            
            content += (try! element.text() + "\n")
        })
        return content
    }
    
    
    func getPopularLightNovel() -> Array<Dictionary<String, Any?>> {
        let doc = try getHtmlContent(url: "https://octopii.co")
        var lightnovels: Array<Dictionary<String, Any?>> = []
        do{
            try doc?.select("#app > main > div > div.row.middle-earth > div.col-12.col-lg-4 > div > div.row").first()?.children().forEach({element in
                let cover = try element.select(".img-container > a > img").first()?.attr("src")
                let url = try element.select(".novel-info > a").first()?.attr("href")
                let name = try element.select(".novel-info > a > h4").first()?.text()
                let author = try element.select(".author-name").first()?.text()
                lightnovels.append(["cover": cover, "url" : url, "name" : name, "author" : author])
            })
            
        }catch{print(error)}
        
        return lightnovels
    }
}
