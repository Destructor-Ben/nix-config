print("HELLO!")

-- Watch for both Sinks (Speakers) and Sources (Mics)
om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "media.class", "matches", "Audio/*" },
  }
}

om:connect("object-added", function (om, node)
  node:connect("params-changed", function (n, param_name)
    if param_name == "Props" then
      local mute = n.properties["mute"]
      local m_class = n.properties["media.class"]
      
      -- Only trigger for the Default devices to avoid spamming 
      -- if you have multiple virtual cables/sinks
      if n.properties["node.is-default"] == "true" then
        
        if m_class == "Audio/Source" then
            -- Handle Microphone
            if mute == "true" then
              print("MUTE MIC")
              os.execute("sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_MASK 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DIR 0x16 && sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x00")
            else
              print("UNMUTE MIC")
              os.execute("sudo hda-verb /dev/snd/hwC1D0 0x01 SET_GPIO_DATA 0x04")
            end
        elseif m_class == "Audio/Sink" then
            -- Handle Speakers
            if mute == "true" then
              print("MUTE SPEAKERS")
              os.execute("sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x08")
            else
              print("UnMUTE SPEAKERS")
              os.execute("sudo hda-verb /dev/snd/hwC1D0 0x20 0x500 0x0b && sudo hda-verb /dev/snd/hwC1D0 0x20 0x400 0x00")
            end
        end
        
      end
    end
  end)
end)

om:activate()
