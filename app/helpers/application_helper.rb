module ApplicationHelper
  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true, strikethrough: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end



  def create_collection_column(collection, label, &block)        
    haml_tag :div, class: "col-sm-4 text-center outline" do
      haml_tag :h6, label, class: "underline"

      collection.each_with_index do |item, count|
        haml_tag :div, class: (count > 0 ? (count == @users.size - 1 ? 'no_border_bottom' : 'border_bottom') : 'border_bottom') do
          block.call(item)
        end
      end
    end
  end
end