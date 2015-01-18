class Framework
  @@routes = {}
  class << self
    
    def find_route_and_execute(env)
      path = env['PATH_INFO']
      if @@routes.has_key?(path)
        @@routes[path].call
      else
        nil
      end
    end
    
    def get(path, &block)
      @@routes[path.to_s] = block
    end
    
    def call(env)
      [200,
        {"Content-Type" => "text/html"},
        [find_route_and_execute(env)]
      ]
    end
  end
end