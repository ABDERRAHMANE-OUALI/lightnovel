package com.abderrahmaneouali.novely.lightnovel

import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jsoup.Jsoup
import org.jsoup.nodes.Document

class LightNovel {

    private suspend fun getHtmlDocuments(url: String): Document{
        val doc: Document
        withContext(Dispatchers.IO){
            doc =  Jsoup.connect(url).get()
        }
        return  doc
    }


    suspend fun getLightNovelInfo(name: String): Map<String, Any?> {
            val doc =  getHtmlDocuments("https://octopii.co/novel/" + name)
            val title = doc.selectFirst("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-12.col-sm-9 > h3")?.text()
            val cover = "https://octopii.co/" + doc.selectFirst("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-6.col-sm-3.pe-1.image-wrapper > div > img.w-100.h-100.rounded-5.position-absolute")?.attr("src")
            val author = doc.selectFirst("#app > main > div > div > div.col-12.col-lg-9.pr-0 > div > div.col-12.col-sm-9 > div.author-container.d-flex.lh-1rem.flex-wrap > div > a")?.text()
            val description = doc.selectFirst("#novel-desc")?.attr("data-desc")
            val chapters = mutableListOf<Map<String, String>>()
            doc.select("#chapter-list-content > div > div > a").forEach{element ->
                val name = element.text()
                val url = element.attr("href")
                chapters.add(mapOf("name" to name, "url" to url))
            }
        return mutableMapOf<String, Any?>("title" to title, "cover" to cover,"author" to author, "description" to description, "chapters" to chapters)
    }

    suspend fun getChapterContent(url: String): String{
        val doc = getHtmlDocuments(url)
        var content = ""
        doc.selectFirst("#chapter-content > div")?.children()?.forEach { element -> content += element.text() + "\n" }
        return content
    }


    suspend fun getPopularLightNovels(): MutableList<Map<String, Any?>> {
        val doc = getHtmlDocuments("https://octopii.co")
        var lightnovels = mutableListOf<Map<String, Any?>>()
        doc.selectFirst("#app > main > div > div.row.middle-earth > div.col-12.col-lg-4 > div > div.row")?.children()?.forEach { element ->
            val cover = element.select(".img-container > a > img").attr("src")
            val url = element.select(".novel-info > a").attr("href")
            val name = element.select(".novel-info > a > h4").text()
            val author = element.select(".author-name").text()
            lightnovels.add(mapOf("cover" to cover, "url" to url, "name" to name, "author" to author))
        }
        return lightnovels
    }
}