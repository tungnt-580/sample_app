module ApplicationHelper
  TUT_LINK = "http://www.railstutorial.org/"
  TUT_AUTHOR = "http://www.michaelhartl.com/"
  TUT_NEW = "http://news.railstutorial.org/"
  def full_title page_title = ""
    base_title = t ".base_title"
    (page_title.empty?? "" : page_title + " | ") + base_title
  end
end
