class Api::V1::BookHistoriesController < ApplicationController
  before_action except: [

  ] do
    verify_role([Rails.application.secrets.role_member, Rails.application.secrets.role_driver])
  end

  def member_histories
    order_status_id = params[:order_status_id]
    member_id = params[:member_id]

    if !member_id
      render err("member_id is mandatory", :bad_request)
    end

    member = Member.where("id = ?", member_id).first
    if member
      book_histories = member.book_history
      if order_status_id
        book_histories = book_histories.select do |book_history|
          book_history.order_status_id == order_status_id.to_i
        end
      end
      render json: {
        book_histories: book_histories,
        token: regenerate_token
      }, status: :ok
    end
  end

  def update_rating 
    id = params[:id]
    rating = params[:rating]

    if(id === nil || rating === nil)
      render err("Invalid parameters", :bad_request)
    end

    rating = rating.to_i
    if(rating < 0 || rating > 5)
      render err("Invalid rating", :bad_request)
    end

    book_history = BookHistory.where("id = ?", id).first
    book_history.rating = rating
    book_history.save
    render json: {
      token: regenerate_token
    }, status: :ok
  end
end
