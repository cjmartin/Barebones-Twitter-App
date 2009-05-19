module TwitterHelper
  def linkup_mentions(text)    
    text.gsub!(/@([\w]+)(\W)?/, '@<a href="/twitter/\1">\1</a>\2')
    text
  end
end
