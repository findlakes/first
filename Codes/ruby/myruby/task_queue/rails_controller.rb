require '/root/Project/first/Codes/ruby/myruby/task_queue/mytask.rb'

#p mytask.list_complete

class SubmainsController < ApplicationController
  before_action :set_submain, only: [:show, :edit, :update, :destroy]

  def initialize
    @mytask = Mytask.new '/root/Project/first/Codes/ruby/myruby/task_queue/task.db'
  end

  # GET /submains
  # GET /submains.json
  def index
    Submain.where("status = 0").each do |item|
      status = @mytask.get_task(item.id)
      status.each do |st|
        status = st[2]
      end
      if status == 100
        my = Submain.find(item.id) 
        my.status = 100
        my.save
      end
    end
    @submains = Submain.all
  end

  # POST /submains
  # POST /submains.json
  def create
    @submain = Submain.new(submain_params)

    respond_to do |format|
      if @submain.save
############
        @mytask.insert(@submain.id,@submain.domain,0)
############
        format.html { redirect_to @submain, notice: 'Submain was successfully created.' }
        format.json { render :show, status: :created, location: @submain }
      else
        format.html { render :new }
        format.json { render json: @submain.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submain
      @submain = Submain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submain_params
      params.require(:submain).permit(:domain, :status)
    end
end
