Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:5600', 'http://localhost:5500','localhost:5600','localhost:5500', 'http://192.168.1.72:5600'
      resource(
            '/api/*', #we want them only to have the access to localhost:3000/api/something/etc
            headers: :any, #all the requests can contain any headers
            credentials: true, #because we are sending cookies with the requests
            methods: [:get, :post, :patch, :put, :delete] #allow for all of there http verbs
            #for these types of request to be sent to your api
            #options verb is being usefd under the hood for CORS to work, and must be present
        )
    end
  end