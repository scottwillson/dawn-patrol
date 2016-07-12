class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_tenant_by_host

  private

  def set_current_tenant_by_host
    host = forwarded_for_or_request_host
    ActsAsTenant.current_tenant = DawnPatrol::Association.where("? ~ host", host).first!
    logger.debug "Found association '#{current_tenant&.acronym}' for '#{host}'"
    current_tenant
  end

  def forwarded_for_or_request_host
    logger.debug "Find association for X-Forwarded-For '#{request.headers["X-Forwarded-For"]}', request host '#{request.host}'"
    request.headers["X-Forwarded-For"] || request.host
  end

  def current_tenant
    ActsAsTenant.current_tenant
  end
end
