class Framework
  @@routes = {}
  class << self
    def params
      @@params
    end

    def request
      @@request
    end

    # render('index, foo: "bar")
    def render(view_path, locals_hash = {})
      template_path = File.join("views", "#{view_path}.erb")
      Tilt::ERBTemplate.new(template_path).render(self, locals_hash)
    end

    def find_route_and_execute(env)
      path = env['PATH_INFO']
      @@routes.each do |path_exp, code_block|
	var_arr = path.scan(path_exp).flatten
	unless var_arr.empty?
	  return code_block.call(*var_arr)
	end
      end
      ""
    end
    
    def get(path, &block)
      @@routes[path] = block
    end
    
    def call(env)
      @@request = Rack::Request.new(env)
      @@params = @@request.params
      [200,
        {"Content-Type" => "text/html"},
        [find_route_and_execute(env)]
      ]
    end
  end
end
