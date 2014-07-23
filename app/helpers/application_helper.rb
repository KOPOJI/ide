module ApplicationHelper
  def app_name
    'IDE Online'
  end

  def page_title title=nil
    return app_name if title.nil? or title.empty?
    "#{app_name} - #{title}"
  end

  def home_url
    '/'
  end

  def url_suffix
    '.html'
  end

  def create_url url=nil
    create_uri url
  end

  def create_url *url
    create_uri url.join('/')
  end

  def create_uri url
    url = home_url + url unless url.starts_with? home_url
    url += url_suffix unless url.end_with? url_suffix
    url += '?page=' + params[:page] unless params[:page].nil?
    url
  end
end
