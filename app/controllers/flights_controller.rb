class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end
  # POST /search
  def search
    if user_signed_in?
      @all_flights = Flight.all  # Get all flights information
      @from = params[:from] # Get the from address
      @from.slice! "'"
      @to = params[:to] # Get the from address
      @departing_date = params[:departing_date]  # Get the departing date
      @returning_date = params[:returning_date]  # Get the returning date
      # Check if the date is weekdays or weekends
      @check_departing_date = @departing_date.to_datetime.strftime('%w') 
      @check_returning_date = @returning_date.to_datetime.strftime('%w') 
      if regular?
        # if the date is weekends
        if @check_departing_date.to_i == 0 || @check_departing_date.to_i == 6
          @search_departing_flights = @all_flights.where("to_addr LIKE ?", @to).order(weekends_reg_price: :ASC)
          if @search_departing_flights.present?
            # Get the lowest price   
            @lowest_departing_price = @search_departing_flights.minimum(:weekends_reg_price)
            @search_departing_flights = @search_departing_flights.where("weekends_reg_price =?", @lowest_departing_price)
          end
        else
          # if the date is weekdays
          @search_departing_flights = @all_flights.where("to_addr LIKE ?", @to).order(weekdays_reg_price: :ASC)
          if @search_departing_flights.present?
            # Get the lowest price   
            @lowest_departing_price = @search_departing_flights.minimum(:weekdays_reg_price)
            @search_departing_flights = @search_departing_flights.where("weekdays_reg_price =?", @lowest_departing_price)
          end
        end
        if @check_returning_date.to_i == 0 || @check_returning_date.to_i == 6
          @search_returning_flights = @all_flights.where("from_addr LIKE ?", @to).order(weekends_reg_price: :ASC)       
          if @search_returning_flights.present?
            @lowest_returning_price = @search_returning_flights.minimum(:weekends_reg_price)
            @search_returning_flights = @search_returning_flights.where("weekends_reg_price =?", @lowest_returning_price)           
          end
        else
          @search_returning_flights = @all_flights.where("from_addr LIKE ?", @to).order(weekdays_reg_price: :ASC)   
          if @search_returning_flights.present?
            @lowest_returning_price = @search_returning_flights.minimum(:weekdays_reg_price)
            @search_returning_flights = @search_returning_flights.where("weekdays_reg_price =?", @lowest_returning_price)           
          end
        end
      elsif reward?
        # if the date is weekends
        if @check_departing_date.to_i == 0 || @check_departing_date.to_i == 6
          @search_departing_flights = @all_flights.where("to_addr LIKE ?", @to).order(weekends_rew_price: :ASC)
          if @search_departing_flights.present?
            # Get the lowest price   
            @lowest_departing_price = @search_departing_flights.minimum(:weekends_rew_price)
            @search_departing_flights = @search_departing_flights.where("weekends_rew_price =?", @lowest_departing_price)
          end
        else
          # if the date is weekdays
          @search_departing_flights = @all_flights.where("to_addr LIKE ?", @to).order(weekdays_rew_price: :ASC)
          if @search_departing_flights.present?
            # Get the lowest price   
            @lowest_departing_price = @search_departing_flights.minimum(:weekdays_rew_price)
            @search_departing_flights = @search_departing_flights.where("weekdays_rew_price =?", @lowest_departing_price)
          end
        end
        if @check_returning_date.to_i == 0 || @check_returning_date.to_i == 6
         @search_returning_flights = @all_flights.where("from_addr LIKE ?", @to).order(weekends_rew_price: :ASC)       
         if @search_returning_flights.present?
          @lowest_returning_price = @search_returning_flights.minimum(:weekends_rew_price)
          @search_returning_flights = @search_returning_flights.where("weekends_rew_price =?", @lowest_returning_price)          
        end
      else
        @search_returning_flights = @all_flights.where("from_addr LIKE ?", @to).order(weekdays_rew_price: :ASC)       
        if @search_returning_flights.present?
          @lowest_returning_price = @search_returning_flights.minimum(:weekdays_rew_price)
          @search_returning_flights = @search_returning_flights.where("weekdays_rew_price =?", @lowest_returning_price)           
        end
      end
    end
    Rails.logger.debug("!!!#{@lowest_departing_price}")
       # Check if there are more flights have the same price.
       if @search_departing_flights.count == 1
        @exact_departing_flight = @search_departing_flights[0]
      elsif @search_departing_flights.count > 1
        @exact_departing_flight = @search_departing_flights.sort_by{ |m| m.schedule.strftime('%I:%M').to_i - "12:00".to_i}.last   
      end
      if @search_returning_flights.count == 1
        @exact_returning_flight = @search_returning_flights[0]
      elsif @search_returning_flights.count > 1
        @exact_returning_flight = @search_returning_flights.sort_by{ |m| m.schedule.strftime('%I:%M').to_i - "12:00".to_i}.last   
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: 'Please log in!' }
      end
    end
  end
  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params.require(:flight).permit(:flight, :schedule, :from_addr, :to_addr, :weekdays_reg_price, :weekdays_rew_price, :weekends_reg_price, :weekends_rew_price)
    end
  end
