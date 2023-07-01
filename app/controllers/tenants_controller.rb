class TenantsController < ApplicationController
    before_action :set_tenant, only: [:show, :update, :destroy]
  
    def index
      tenants = Tenant.all
      render json: tenants, status: :ok
    end
  
    def show
      render json: @tenant, status: :ok
    end
  
    def create
      tenant = Tenant.new(tenant_params)
      if tenant.save
        render json: tenant, status: :created
      else
        render json: { errors: tenant.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @tenant.update(tenant_params)
        render json: @tenant, status: :ok
      else
        render json: { errors: @tenant.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @tenant.destroy
      render json: { message: 'Tenant deleted' }, status: :ok
    end
  
    private
  
    def set_tenant
      @tenant = Tenant.find_by(id: params[:id])
      unless @tenant
        render json: { error: 'Tenant not found' }, status: :not_found
      end
    end
  
    def tenant_params
      params.permit(:name, :age)
    end
end  