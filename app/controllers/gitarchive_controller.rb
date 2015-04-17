class GitarchiveController < ApplicationController
	def archive
    Resque.enqueue(Worker)
    render :text => "working ..."
  end
end
