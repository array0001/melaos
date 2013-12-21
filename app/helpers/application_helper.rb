module ApplicationHelper
  def title
    base_title = "Endulza tus sentidos"
    if( @title.nil? )
    base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("MelaosLogo.png", :alt => "Melaos Del Valle", :class => "img-responsive")
  end

end
