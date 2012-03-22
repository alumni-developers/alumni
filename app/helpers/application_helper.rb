module ApplicationHelper
  #return a title on a per-page basis
  def title
    base_title="CFIS Alumni"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("logo.jpg",:alt=>"Lo jefe",:class=>"round")
  end

## For bootstrap compatible pagination  
#  def paginate *params
#    params[1] = {} if params[1].nil?
#    params[1][:renderer] = BootstrapPaginationHelper::LinkRenderer
#    will_paginate *params
#  end
end

