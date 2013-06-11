class ExceptionsController < Application::BaseController
  def unauthenticated
	  "You no belong here."
	end
end
