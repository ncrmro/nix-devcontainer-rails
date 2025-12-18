class HelloController < ApplicationController
  def index
    what = params[:what].presence || "World"
    render plain: "Hello, #{what}!"
  end
end
