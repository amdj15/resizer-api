class V1::ImageSizePresenter < V1::BasePresenter
  def link
    h.base_url + @model.image.link_path(@model.width, @model.height)
  end
end