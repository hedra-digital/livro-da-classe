module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      controller.stub :current_user => nil
    else
      controller.stub :current_user => user
    end
  end
end
