class Api::PlayersController < ApplicationController
  before_action :find_player, only: %i[update destroy show]
  before_action :authenticate_token!, only: :destroy

  # GET /players
  def index
    @players = Player.joins(:player_skills).distinct.order(id: :asc)

    json_response(Api::PlayerJsonPresenter.collection(@players))
  end

  # POST /players
  def create
    begin
      @player = Player.create(Api::PlayerRequestBody.new(create_params).to_h)

      if @player.errors.empty?
        json_response(Api::PlayerJsonPresenter.new(@player).to_h)
      else
        render json: { message: @player.errors.messages.values.flatten.first }, status: :unprocessable_entity
      end
    rescue ArgumentError => error
      render json: { message: error.message }, status: :bad_request
    end
  end

  # GET /players/:id
  def show
    json_response(Api::PlayerJsonPresenter.new(@player).to_h)
  end

  # PUT /players/:id
  def update
    begin
      @player.update(Api::PlayerRequestBody.new(update_params.merge(id: @player.id)).to_h)

      if @player.errors.empty?
        json_response(Api::PlayerJsonPresenter.new(@player).to_h)
      else
        render json: { message: @player.errors.messages.values.flatten.first }, status: :unprocessable_entity
      end
    rescue ArgumentError => error
      render json: { message: error.message }, status: :bad_request
    end
  end

  # DELETE /players/:id
  def destroy
    head :no_content if @player.destroy
  end

  private

  def create_params
    params.require(:_json).permit(:name, :position, player_skills: [:skill, :value])
  end

  def update_params
    params.permit(:name, :position, player_skills: [:skill, :value])
  end

  def find_player
    begin
      @player = Player.find(params[:id])
    rescue ActiveRecord::RecordNotFound => _error
      render json: { message: "Invalid resource with ID: #{params[:id]}" }, status: :not_found
    end
  end
end
