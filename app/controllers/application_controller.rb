# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protected

  def new_comment
    @comment = Comment.new
  end
end
