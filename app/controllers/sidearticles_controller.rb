class SidearticlesController < ApplicationController
  # GET /sidearticles
  # GET /sidearticles.json
  def index
    @sidearticles = Sidearticle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sidearticles }
    end
  end

  # GET /sidearticles/1
  # GET /sidearticles/1.json
  def show
    @sidearticle = Sidearticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sidearticle }
    end
  end

  # GET /sidearticles/new
  # GET /sidearticles/new.json
  def new
    @sidearticle = Sidearticle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sidearticle }
    end
  end

  # GET /sidearticles/1/edit
  def edit
    @sidearticle = Sidearticle.find(params[:id])
  end

  # POST /sidearticles
  # POST /sidearticles.json
  def create
    @sidearticle = Sidearticle.new(params[:sidearticle])

    respond_to do |format|
      if @sidearticle.save
        format.html { redirect_to @sidearticle, notice: 'Sidearticle was successfully created.' }
        format.json { render json: @sidearticle, status: :created, location: @sidearticle }
      else
        format.html { render action: "new" }
        format.json { render json: @sidearticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sidearticles/1
  # PUT /sidearticles/1.json
  def update
    @sidearticle = Sidearticle.find(params[:id])

    respond_to do |format|
      if @sidearticle.update_attributes(params[:sidearticle])
        format.html { redirect_to @sidearticle, notice: 'Sidearticle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sidearticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sidearticles/1
  # DELETE /sidearticles/1.json
  def destroy
    @sidearticle = Sidearticle.find(params[:id])
    @sidearticle.destroy

    respond_to do |format|
      format.html { redirect_to sidearticles_url }
      format.json { head :no_content }
    end
  end
end
