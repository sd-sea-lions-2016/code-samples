helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def titleize_key(key)
    key.to_s.capitalize.split('_').join(' ')
  end
end
