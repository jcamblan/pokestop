module AdminHelper
  def nav_link(text,target_path,icon_class = "fa-angle-right")
    content_tag :li, class: "nav-item #{"active" if current_page?(target_path)}" do
      link_to target_path, class: "nav-link" do
        concat content_tag :i, "", class: "fas fa-fw #{icon_class}"
        concat content_tag :span, text
      end
    end
  end
end