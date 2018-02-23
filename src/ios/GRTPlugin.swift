@objc(GRTPlugin) class GRTPlugin : CDVPlugin {
    override func pluginInitialize() {
        // if let scheme = self.commandDelegate.settings["Scheme".lowercased()] as? String {
        //     ContentURLProtocol.scheme = scheme
        // }

        var val = CPP_Wrapper().lol()
        print("GRTPlugin loaded \(val)")
    }
}

