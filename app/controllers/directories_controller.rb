class DirectoriesController < ApplicationController
  before_action :set_directory, only: [:show, :edit, :update, :destroy]

  # GET /directories
  # GET /directories.json
  def index
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
    @opened_files = DataSet.where(opened: true, project_id: @project.id)
    @showed = []
  end

  # GET /directories/1
  # GET /directories/1.json
  def show
  end

  # GET /directories/new
  def new
    @directory = Directory.new
    if request.xhr?
      render :new, layout: false
    end
  end

  # GET /directories/1/edit
  def edit
  end

  # POST /directories
  # POST /directories.json
  def create
    @directory = Directory.new(directory_params)
    @directory.project_id = session[:project_id]
    respond_to do |format|
      if @directory.save
        format.html { redirect_to root_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directories/1
  # PATCH/PUT /directories/1.json
  def update
    respond_to do |format|
      if @directory.update(directory_params)
        format.html { redirect_to root_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    @directory.destroy
    respond_to do |format|
      format.html { redirect_to directories_url }
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
