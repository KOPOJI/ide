class DirectoriesController < ApplicationController

  include DirectoriesHelper

  #before_action :set_directory, only: [:show, :edit, :update]

  # GET /directories
  # GET /directories.json
  def index
    params[:project] = URI.parse(URI.encode(params[:project])).to_s if params[:project]
    if session[:project_id].present?
      if params[:project].present?
        @project = Project.find_by(id: session[:project_id], project_url: params[:project].sub('.html', '')) || (page_not_found and return)
      else
        @project = Project.find(session[:project_id]) || (page_not_found and return)
      end
    elsif session[:project_id].nil? && params[:project].present?
      @project = Project.find_by(project_url: params[:project].sub('.html', '')) || (page_not_found and return)
      session[:project_id] = @project.id
    else
      page_not_found and return
    end
    @directories = @project.directories
    @opened_files = DataSet.where(opened: true, project_id: @project.id)

    @showed = []
  end

  def get_tree
    @showed = []
    @directories = Directory.where project_id: session[:project_id]
    render 'get_tree.js.erb'
  end
  # GET /directories/1
  # GET /directories/1.json
  def show
  end

  # GET /directories/new
  def new
    @directory = Directory.new
    render :new, layout: false if request.xhr?
  end

  # GET /directories/1/edit
  def edit
    render :edit, layout: false
  end

  # POST /directories
  # POST /directories.json
  def create
    @directory = Directory.new(directory_params)
    @directory.project_id = session[:project_id]
    respond_to do |format|
      if @directory.save
        format.html { render text: 'created', layout: false, status: :created }
        format.json { render json: @directory.errors, status: :created }
      else
        params[:id] = @directory.parent_id
        format.html { render action: 'new', layout: false }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directories/1
  # PATCH/PUT /directories/1.json
  def update
    @directory.project_id = session[:project_id]
    respond_to do |format|
      if @directory.update(directory_params)
        format.html { render text: 'created', layout: false, status: :created }
        format.json { head :no_content }
      else
        params[:id] = @directory.parent_id
        format.html { render action: 'edit', layout: false }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    Directory.find(params[:id]).destroy!

    respond_to do |format|
      format.html { render text: 'created', layout: false, status: :created }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directory
      @directory = Directory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def directory_params
      params.require(:directory).permit(:name, :path, :parent_id)
    end
end