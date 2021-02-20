//
//  ViewController.swift
//  WebKitTest
//
//  Created by Irish on 2/20/21.
//

import UIKit
import JavaScriptCore
import WebKit

class ViewController: UIViewController {

    private weak var webView: WKWebView!

    private var userContentController: WKUserContentController!

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()

        loadPage(urlString: "https://mm.qa/demosite/about-us", partialContentQuerySelector: ".post-2")
    }

    private func createViews() {
         userContentController = WKUserContentController()

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true


        self.webView = webView
    }

    private func loadPage(urlString: String, partialContentQuerySelector selector: String) {
        userContentController.removeAllUserScripts()
        let userScript = WKUserScript(source: scriptWithDOMSelector(selector: selector), injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true)

        userContentController.addUserScript(userScript)

        let url = NSURL(string: urlString)!
        webView.load(NSURLRequest(url: url as URL) as URLRequest)
    }

    private func scriptWithDOMSelector(selector: String) -> String {
        let script =
        "var selectedElement = document.querySelector('\(selector)');" +
        "document.body.innerHTML = selectedElement.innerHTML;"
        return script
    }

}
