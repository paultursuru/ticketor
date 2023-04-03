module HomeworksHelper
  def urlify(url)
    return "#" unless url
    case url[0, 3]
    when "htt" then url
    when "www" then "https://#{url}"
    else  "https://www.#{url}"
    end
  end
end
