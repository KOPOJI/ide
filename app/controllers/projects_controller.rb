class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def setSession
    render nothing: true and return if params[:id].nil? or params[:type].nil? or !request.xhr?
    session["#{params[:type]}_id".to_sym] = params[:id].to_i
    render nothing: true and return
  end
  # GET /projects
  # GET /projects.json
  def index
    if session[:project_id].blank? or !session[:project_id] =~ /\d+/
      @projects = Project.all
    else
      begin
        @project = Project.find(session[:project_id]) || page_not_found
      rescue ActiveRecord::RecordNotFound => e
        session[:project_id] = nil
        page_not_found and return
      end
      redirect_to "/#{@project.project_url}.html"
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id]) || page_not_found
    session[:project_id] = params[:id].to_i
    redirect_to "/#{@project.project_url}.html"
  end

  def open
    @projects = Project.all
  end
  def close
    session[:project_id] = nil
    redirect_to root_path
  end
  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.status = true
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :title)
    end
end
