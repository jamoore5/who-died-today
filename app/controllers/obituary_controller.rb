class ObituaryController < ApplicationController
  def index
    @obits = Obituary.order('dod DESC').first(50)
  end
end
