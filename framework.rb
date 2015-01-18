class Framework
  @@routes = {}
  class << self
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
      req = Rack::Request.new(env)
      p req.host
      [200,
        {"Content-Type" => "text/html"},
        [find_route_and_execute(env)]
      ]
    end
  end
end
