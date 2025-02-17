function ssid_changed_callback()
	ssid = hs.wifi.currentNetwork()
	if ssid ~= nil then
		print("ssid: " .. ssid)
	end
end

wifi_watcher = hs.wifi.watcher.new(ssid_changed_callback)
wifi_watcher:start()
