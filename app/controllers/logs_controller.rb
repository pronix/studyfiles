class LogsController < ApplicationController
  before_filter :authorize

  def index
    @logs = SiteLog.all
  end

  private

  def authorize
    authorize! :manage, SiteLog
  end
end
