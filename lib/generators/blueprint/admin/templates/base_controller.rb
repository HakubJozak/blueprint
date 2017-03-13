# frozen_string_literal: true
require 'application_responder'

class Admin::BaseController < ApplicationController
  # before_action :authenticate_admin_user!

  layout 'admin'

  self.responder = ApplicationResponder
  respond_to :html

end
