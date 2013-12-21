module UsersHelper
  def gravatar_for(user, options = {:size => 50})#options gets overWrited when passing a parameter in show.html
    gravatar_image_tag(user.email.downcase, :alt => user.nombre,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
