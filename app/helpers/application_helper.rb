module ApplicationHelper
  

  def iterate_categories category
  	text = category.category_description.name
  	while !category.parent.blank?
  		text.prepend("#{category.parent.category_description.name.html_safe}>")
  		category = category.parent
  	end
  	return text
  end
  
end
