function usb_device_callback(data)
	print("usb_device_callback: " .. hs.inspect(data))
end

usb_watcher = hs.usb.watcher.new(usb_device_callbacK)
usb_watcher:start()
