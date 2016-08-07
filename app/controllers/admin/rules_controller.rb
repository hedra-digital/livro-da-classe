module Admin
  # Rule Controller
  class RulesController < Admin::ApplicationController

    def index
      @rules = Rule.all
    end

    def new
      @rule = Rule.new
    end

    def destroy
      @rule = Rule.find(params[:id])
      @rule.destroy
      redirect_to admin_rules_path, notice: 'Rotina removida com sucesso.'
    end

    def create
      @rule = Rule.new(params[:rule])
      if @rule.save
        redirect_to admin_rules_path, notice: 'Uma nova rotina foi definida.'
      else
        render :new
      end
    end

    def edit
      @rule = Rule.find(params[:id])
    end

    def update
      @rule = Rule.find(params[:id])
      @rule.update_attributes(params[:rule])
      if @rule.save
        redirect_to admin_rules_path, notice: 'Rotina atualizada.'
      else
        render :edit
      end
    end

    def active
      rule = Rule.find(params[:id])
      active = rule.active
      rule.active = !active
      if rule.save
        render json: { result: 'success' }
      else
        render json: { result: 'fail' }
      end
    end
  end
end
