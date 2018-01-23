class DesignersController < ApplicationController
  skip_before_action :logged_in?, only: [:new, :create]


  def index
    @designers = Designer.all
    @charts = {}
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Year' )
    data_table.new_column('number', 'Fee')

    @all_contracts = @designers.map{|designer| designer.contracts}.flatten
    @sorted_contracts = @all_contracts.sort_by{|contract| contract.opening_date}

    @sorted_contracts.each do |contract|
      data_table.add_rows([[contract.opening_date, contract.fee]])
    end

    option = { width: 600, height: 240, title: 'Company Performance' }
    @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)
  end

  def new
    @designer = Designer.new
  end

  def create
    designer_check = Designer.new(designer_params).save
    if designer_check
      @designer = Designer.last
      session[:designer_id] = @designer.id
      redirect_to root_path
    else
      redirect_to new_designer_path
    end
  end

  def designer_params
    params.require(:designer).permit(:username, :gender, :ethnicity, :birth_year, :password, :password_confirmation)
  end

end
