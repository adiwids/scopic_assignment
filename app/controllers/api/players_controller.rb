class Api::PlayersController < ApplicationController
  before_action :find_player, only: :update

  # GET /players
  def index
  end

  # POST /players
  def create
    begin
      @player = Player.create(Api::PlayerRequestBody.new(create_params).to_h)

      if @player.errors.empty?
        json_response(Api::PlayerJsonPresenter.new(@player).to_h)
      else
        render json: { message: @player.errors.full_messages.first }, status: :unprocessable_entity
      end
    rescue ArgumentError => error
      render json: { message: error.message }, status: :bad_request
    end
  end

  # GET /players/:id
  def show
  end

  # PUT /players/:id
  def update
    begin
      @player.update(Api::PlayerRequestBody.new(update_params.merge(id: @player.id)).to_h)

      if @player.errors.empty?
        json_response(Api::PlayerJsonPresenter.new(@player).to_h)
      else
        render json: { message: @player.errors.full_messages.first }, status: :unprocessable_entity
      end
    rescue ArgumentError => error
      render json: { message: error.message }, status: :bad_request
    end
  end

  # DELETE /players/:id
  def destroy
  end

  private

  def create_params
    params.require(:_json).permit(:name, :position, player_skills: [:skill, :value])
  end

  def update_params
    params.permit(:name, :position, player_skills: [:skill, :value])
  end

  def find_player
    @player = Player.find(params[:id])
  end
end
