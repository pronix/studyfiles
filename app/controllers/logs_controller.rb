class LogsController < ApplicationController
  before_filter :authorize

  def index
    @logs = SiteLog.top_level
  end

  private

  def authorize
    authorize! :manage, SiteLog
  end
end
