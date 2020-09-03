class ObituaryController < ApplicationController
  def index
    @recent_obits = Obituary.recent
    @past_obits = Obituary.past.first(25)
  end
end
