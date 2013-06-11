module Application
  class BaseController
		def call(env)
		  @request = Rack::Request.new(env)
			@response = Rack::Response.new
			resp_text = self.send(env['x-rack.action-name'])
			@response.write(resp_text)
			@response.finish
		end

		def self.action(name)
		 lambda do |env|
		   env['x-rack.action-name'] = name
			 self.new.call(env)
		 end
		end

		def status=(code); @response.status = code; end
		def headers; @response.header; end
		def session; @request.env['rack.session']; end
		def flash; @request.env['x-rack.flash']; end
		
		def url(name, opts={});
		  Router.generate(name, opts)
		end

		def redirect_to(url)
		  status = 302
			headers['Location'] = url
			"You are being redirected"
		end

		def render(template=nil)
		  template ||= @request.env['x-rack.action-name']
			views_path = "#{APP_ROOT}/app/views"
			template_path = "#{views_path}/#{self.class.to_s.underscore}/#{template}.html.erb"
		  layout_path = "#{views_path}/layouts/application.html.erb"
			Tilt.new(layout_path).render(self) do
			  Tilt.new(template_path).render(self)
			end
		end
		
	end
end
