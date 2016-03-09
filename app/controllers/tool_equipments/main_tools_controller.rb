module ToolEquipments
  class MainToolsController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :find_main_tool, only: [:destroy, :update]
    before_action :define_main_tool, only: [:index, :create]
    before_action :main_tools, only: :index

    def index
      if params[:paginate]
        render partial: 'tool_equipments/main_tools/paginate'
      else
        respond_to do |format|
          format.js
          format.html { render layout: false }
        end
      end
    end

    def create
      @main_tool.update_attributes main_tools_params
      flash.now[:error] = t('validation.errors.all_fields') unless @main_tool.save
      respond_to { |format| format.js }
    end

    def update
      respond_to do |format|
        if @main_tool.update(main_tools_params)
          format.json { head :no_content }
        else
          format.json { render json: @main_tool.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      flash.now[:error] = t('validation.errors.delete_error') unless @main_tool.destroy
      respond_to { |format| format.js }
    end

    private

    def define_main_tool
      @main_tool = MainTool.new
    end

    def find_main_tool
      @main_tool = MainTool.find(params[:id])
    end

    def main_tools_params
      params.require(:main_tool).permit!.merge(company_id: current_company.id)
    end

    def main_tools
      @main_tools = current_company.main_tools.by_type(params[:type])
                                   .page(params[:page])
    end
  end
end
