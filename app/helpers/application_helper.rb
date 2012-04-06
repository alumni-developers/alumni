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
    # application_helper.rb
  # https://gist.github.com/1205828
  # Based on https://gist.github.com/1182136
  class BootstrapLinkRenderer < ::WillPaginate::ViewHelpers::LinkRenderer
    protected
 
    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end
 
    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end
 
    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end
 
    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end
 
  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end

end

  