class Api::V1::ActiveBooksController < ApplicationController
  def create_active_book 
  	member_id = params[:member_id]
  	driver_id = params[:driver_id]
  	order_status_id = params[:order_status_id]
  	src_lat = params[:src_lat]
  	src_long = params[:src_long]
  	dest_lat = params[:dest_lat]
  	dest_long = params[:dest_long]
  	price = params[:price]
  	from = params[:from]
  	to = params[:to]

  	activeBook = ActiveBook.new(
  		member_id: member_id,
  		driver_id: driver_id,
  		order_status_id: order_status_id,
  		src_lat: src_lat,
  		src_long: src_long,
  		dest_lat: dest_lat,
  		dest_long: dest_long,
  		price: price,
  		from: from,
  		to: to
  		)
  	if activeBook.valid?
  		activeBook.save
  		render json: {
            token: regenerate_token
        },status: :ok
  	else
  		render err("Creation of Active Book Failed", :bad_request)
  	end
  end

  def get_by_member
  	member_id = params[:member_id]

  	if params[:member_id].blank?
  		render json: {
  			active_book: ActiveBook.where("member_id = ?",params[:member_id]),
  			token: regenerate_token
  		},status: :ok
  	else
  		render err("Id Nil", :ok)
  	end
  end

  def get_by_driver
  	driver_id = params[:driver_id]

  	if params[:driver_id].blank?
  		render json: {
  			active_book: ActiveBook.where("driver_id = ?",params[:driver_id]),
  			token: regenerate_token
  		},status: :ok
  	else
  		render err("Id Nil", :ok)
  	end
  end
end
