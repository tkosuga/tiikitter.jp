class SitemapController < ApplicationController
  def sitemap
    headers["Content-Type"] = "text/xml"
    headers["Last-Modified"] = Time.now.utc.xmlschema
    render :layout => false
  end
end
