class ApartmentsController < ApplicationController
    before_action :set_apartment, only: [:show, :update, :destroy]
  
    def index
      apartments = Apartment.all
      render json: apartments, status: :ok
    end
  
    def show
      render json: @apartment, status: :ok
    end
  
    def create
      apartment = Apartment.new(apartment_params)
      if apartment.save
        render json: apartment, status: :created
      else
        render json: { errors: apartment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @apartment.update(apartment_params)
        render json: @apartment, status: :ok
      else
        render json: { errors: @apartment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @apartment.destroy
      render json: { message: 'Apartment deleted' }, status: :ok
    end
  
    private
  
    def set_apartment
      @apartment = Apartment.find_by(id: params[:id])
      unless @apartment
        render json: { error: 'Apartment not found' }, status: :not_found
      end
    end
  
    def apartment_params
      params.permit(:number)
    end
end