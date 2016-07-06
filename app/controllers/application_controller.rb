class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_tenant_by_header

  private

  def set_current_tenant_by_header
    if default_to_first_association?
      ActsAsTenant.current_tenant = DawnPatrol::Association.order(:created_at).first
    else
      ActsAsTenant.current_tenant = DawnPatrol::Association.where(key: headers[:association]).first
    end
  end

  def default_to_first_association?
    headers[:association].blank? && (Rails.env.test? || Rails.env.development?)
  end

  def current_tenant
    ActsAsTenant.current_tenant
  end
end
