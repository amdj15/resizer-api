module Api::V1::ApplicationHelper
  def present(model)
    klass = "Api::V1::#{model.class}Presenter".constantize
    presenter = klass.new(model, self)

    yield presenter if block_given?
  end
end