class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_association_by_host

  private

  def set_current_association_by_host
    host = forwarded_for_or_request_host
    DawnPatrol::Association.current = DawnPatrol::Association.where("? ~ host", host).order(:position).first!
    logger.debug "Found association '#{current_association&.acronym}' for '#{host}'"
    @association = current_association
  end

  def forwarded_for_or_request_host
    logger.debug "Find association for X-Forwarded-For '#{request.headers["X-Forwarded-For"]}', request host '#{request.host}'"
    request.headers["X-Forwarded-For"] || request.host
  end

  def current_association
    DawnPatrol::Association.current
  end
end
