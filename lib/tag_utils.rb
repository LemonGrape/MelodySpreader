module CustomTag
  def audio_tag url
    "<audio src='#{url}' controls><audio>"
  end
end
