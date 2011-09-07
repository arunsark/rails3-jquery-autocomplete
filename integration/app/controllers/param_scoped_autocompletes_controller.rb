class ParamScopedAutocompletesController < ApplicationController

  autocomplete :brand, :name, :param_scopes => [{:scope => :custom_state,:param => :state}]

  def new
    @product = Product.new
  end

  private
  def state
    false
  end  
end
