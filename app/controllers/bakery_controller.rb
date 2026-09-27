class BakeryController < ApplicationController
  def home
    @bakery = BakeryProfile.load
  end
end
