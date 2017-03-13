# frozen_string_literal: true
require 'application_responder'

class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_user!

  include Admin::Sorting

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  layout 'admin'

  self.responder = ApplicationResponder
  respond_to :html

  private

end
