class FilesController < ApplicationController
  before_action :set_file, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new_project
  end

  def open_project
  end

  def new_file
    @file = DataSet.new
  end

  def new_file_from_template
  end

  def open_file
    head :bad_request and return unless request.xhr? or params[:id].present?
    @file = DataSet.find_by_id(params[:id]) || page_not_found
    @file.update(opened: true)
    render 'files/_file.js.erb.coffee', locals: {file: @file }
  end

  def close_file
    head :bad_request and return unless request.xhr? or params[:id].present?
    DataSet.find_by_id(params[:id]).update(opened: false)
    render 'files/delete_file.js.erb.coffee', locals: {id: params[:id] }
  end

  def close_all_files
    head :bad_request and return unless request.xhr?
    DataSet.update_all(opened: false)
    render text: 'ok'
  end

  def save_file
    head :bad_request and return unless request.xhr? or params[:id].present? or params[:text].present?
    render text: DataSet.find_by_id(params[:id]).update(text: params[:text])
  end

  def save_all_files
  end

  def close_project
  end

  def settings
  end

  def default_settings
  end

  def print
  end

  # GET /files/1
  # GET /files/1.json
  def show
  end

  # GET /files/new
  def new
    @file = DataSet.new
  end

  # GET /files/1/edit
  def edit
  end

  # POST /files
  # POST /files.json
  def create
    @file = DataSet.new(file_params)

    respond_to do |format|
      if @file.save
        format.html { redirect_to @file, notice: 'Files was successfully created.' }
        format.json { render action: 'show', status: :created, location: @file }
      else
        format.html { render action: 'new' }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /files/1
  # PATCH/PUT /files/1.json
  def update
    respond_to do |format|
      if @file.update(file_params)
        format.html { redirect_to @file, notice: 'Files was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /files/1
  # DELETE /files/1.json
  def destroy
    @file.destroy
    respond_to do |format|
      format.html { redirect_to files_index_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file
      @file = DataSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_params
      params.require(:data_set).permit(:name, :text, :directory_id)
    end
end
