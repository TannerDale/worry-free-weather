class ApplicationController < ActionController::API
  include ParamValidator
  include ExceptionHandler
end
