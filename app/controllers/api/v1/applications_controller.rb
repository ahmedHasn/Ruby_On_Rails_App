class Api::V1::ApplicationsController < ApplicationController

  # GET: /api/v1/applications
  def index
    applications = Application.all
    render json: applications
  end

  # POST: /api/v1/applications
  def create
    application = Application.new(application_params)
    application.token = SecureRandom.uuid
    if application.save
      render json: application
    else
      render json: application.errors, status: :unprocessable_entity
    end
  end

  # GET: /api/v1/applications/:application_token
  def show
    application = Application.find_by_token(params[:application_token]);
    render json: application, status: :ok
  end

  # PUT: /api/v1/applications/:id
  def edit
    application = Application.find(params[:id])
    if application
      application.update(application_params)
      render json: application, status: :ok
    else
      render json: {error: 'Unable to update Application'}, status: 400
    end
  end

  def application_params
    params.permit(:name)
  end
end
