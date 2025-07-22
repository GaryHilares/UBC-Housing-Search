class ListingsController < ApplicationController
  def new
    @residences = Residence.all.select([:id, :name])
    @roomtypes = RoomType.all.select([:id, :name])
  end

  def create
    if !params.has_key?(:monthly_rate) || !params.has_key?(:security_deposit) || !params.has_key?(:start_date) || !params.has_key?(:end_date) || !params.has_key?(:gender) || !params.has_key?(:other_details) || !params.has_key?(:residence_id) || !params.has_key?(:roomtype_id)
      flash[:alert] = "At least one of the required parameters is missing"
      redirect_to new_listing_url()
    elsif !Residence.exists?(id: params[:residence_id]) || !RoomType.exists?(id: params[:roomtype_id])
      flash[:alert] = "The selected residence or roomtype is invalid"
      redirect_to new_listing_url()
    else
      session = find_session_by_cookie()
      id = session[:user_id]
      monthly_rate = Integer(Float(params[:monthly_rate]) * 10)
      security_deposit = Integer(Float(params[:security_deposit]) * 10)
      open_to_negotiation = params.has_key?(:open_to_negotiation) && ActiveModel::Type::Boolean.new.cast(params[:open_to_negotiation])
      prorating_available = params.has_key?(:prorating_available) && ActiveModel::Type::Boolean.new.cast(params[:prorating_available])
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      listing = Listing.new(
        monthly_rate: monthly_rate,
        security_deposit: security_deposit,
        open_to_negotiation: open_to_negotiation,
        prorating_available: prorating_available,
        start_date: start_date,
        end_date: end_date,
        gender: params[:gender],
        other_details: params[:other_details],
        residence_id: params[:residence_id],
        room_type_id: params[:roomtype_id],
        user_id: id
        )
      listing.save
      redirect_to listing_url(id: listing.id)
    end
  rescue ArgumentError
    flash[:error] = "One of the parameters you passed was not valid"
    redirect_to new_listing_url()
  end

  def show
    @listing = Listing.find(params[:id])
    @user = @listing.user
    @roomtype = @listing.room_type
    @residence = @listing.residence
  end
end
