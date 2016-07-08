class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_tenant_by_header

  private

  def set_current_tenant_by_header
    ActsAsTenant.current_tenant = DawnPatrol::Association.where("host ~ ?", request.host).first
    logger.debug "Found association '#{current_tenant&.acronym}' for host '#{request.host}'"
    current_tenant
  end

  def current_tenant
    ActsAsTenant.current_tenant
  end
end
