class V1::BasePresenter < SimpleDelegator

  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def h
    @view
  end
end
