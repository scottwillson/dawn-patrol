class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_association_by_host

  private

  def set_current_association_by_host
    logger.debug "Find association for request host '#{request.host}'"
    DawnPatrol::Association.current = DawnPatrol::Association.where("? ~ host", request.host).order(:position).first!
    logger.debug "Found association '#{current_association&.acronym}' for '#{request.host}'"
    @association = current_association
  end

  def current_association
    DawnPatrol::Association.current
  end
end
