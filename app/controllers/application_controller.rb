class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include Authorization
end
