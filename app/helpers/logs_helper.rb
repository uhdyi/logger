module LogsHelper

def sort_td_class_helper(param)
  result = 'class="sortup"' if params[:sort] == param
  result = 'class="sortdown"' if params[:sort] == param + "_reverse"
  return result
end

def sort_link_helper(text, param)
  key = param
  key += "_reverse" if params[:sort] == param
  options = {
    :url => {:action => 'index', :params => params.merge({:sort => key, :page => nil})},
    :update => 'table', 
  }
  html_options = {
    :title => "Sort by this field",
    :href => url_for(:action => 'index', :params => params.merge({:sort => key, :page => nil}))
  }
  link_to_remote(text, options, html_options)
end

end
