# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken  
end
