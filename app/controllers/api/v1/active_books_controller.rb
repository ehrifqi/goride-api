class Api::V1::ActiveBooksController < ApplicationController
	before_action except: [

	] do
		verify_role([Rails.application.secrets.role_member, Rails.application.secrets.role_driver])
	end

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
		distance = params[:distance]
		price_with_gopay = params[:price_with_gopay]

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
			to: to,
			distance: distance,
			price_with_gopay: price_with_gopay
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

		member = Member.where("id = ?", member_id).first
		if !params[:member_id].blank? && !member.nil?	
  		render json: {
  			active_book: member.active_book,
  			token: regenerate_token
  		},status: :ok
  	else
  		render err("Id Nil", :ok)
  	end
  end

  def get_by_driver
  	driver_id = params[:driver_id]

		driver = Driver.where("id = ?", driver_id).first
  	if !params[:driver_id].blank? && !driver.nil?
  		render json: {
  			active_book: driver.active_book,
  			token: regenerate_token
  		},status: :ok
  	else
  		render err("Id Nil", :ok)
  	end
  end

  def set_driver
    id = params[:id]
    driver_id = params[:driver_id]

    active_book = ActiveBook.where("id = ?", id).first
    driver = Driver.where("id = ?", driver_id).first
    if !params[:id].blank? && !active_book.nil? && !params[:driver_id].blank? && !driver.nil?
      active_book.driver_id = driver_id
      active_book.order_status_id = 2 #accepted
      active_book.save
      render json: {
        active_book: active_book,
        token: regenerate_token
      },status: :ok
    else
      render err("Id Nil", :ok)
    end  
  end

  def set_status
    id = params[:id]
    order_status_id = params[:order_status_id]

    active_book = ActiveBook.where("id = ?", id).first
    order_status = OrderStatus.where("id = ?", order_status_id).first
    if !params[:id].blank? && !active_book.nil? && !params[:order_status_id].blank? && !order_status.nil?
      active_book.order_status_id = order_status_id
      active_book.save
      render json: {
        active_book: active_book,
        token: regenerate_token
      },status: :ok
    else
      render err("Id Nil", :ok)
    end
  end

  def move_to_history
    id = params[:id]
    order_status_id = params[:order_status_id]

    active_book = ActiveBook.where("id = ?", id).first
    order_status = OrderStatus.where("id = ?", order_status_id).first
    if !params[:id].blank? && !active_book.nil? && !params[:order_status_id].blank? && !order_status.nil?
      book_history = BookHistory.new(
        member_id: active_book.member_id,
        driver_id: active_book.driver_id,
        src_lat: active_book.src_lat,
        src_long: active_book.src_long,
        dest_lat: active_book.dest_lat,
        dest_long: active_book.dest_long,
        price: active_book.price,
        from: active_book.from,
        to: active_book.to,
        distance: active_book.distance,
        price_with_gopay: active_book.price_with_gopay,
        rating: 0,
        order_status_id: order_status_id
      )

      if book_history.valid?
        book_history.save
        active_book.destroy
        render json: {
          token: regenerate_token
        },status: :ok
      else
        render err("Invalid parameters", :ok)
      end
    else
      render err("Id Nil", :bad_request)
    end
  end
end
