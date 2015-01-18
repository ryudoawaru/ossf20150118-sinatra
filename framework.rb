class Framework
  @@routes = {}
  class << self
    def params
      @@params
    end

    def request
      @@request
    end

    DEFAULT_LAYOUT_PATH = 'views/layout.erb'
    # render('index, foo: "bar")
    def render(view_path, options = {})
      layout_path = options.delete(:layout_path) || DEFAULT_LAYOUT_PATH
      locals_hash = options.delete(:locals) || {}
      template_path = File.join("views", "#{view_path}.erb")
      view_buffer = Tilt::ERBTemplate.new(template_path).render(self, locals_hash)
      Tilt::ERBTemplate.new(layout_path).render(self, locals_hash) do
	view_buffer
      end
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
