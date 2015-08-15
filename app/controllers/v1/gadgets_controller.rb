class V1::GadgetsController < V1::BaseController
  skip_before_filter :check_access_token!, only: [:new]

  def new
    @gadget = Gadget.create!(token: Gadget.generate_token)
  end
end
