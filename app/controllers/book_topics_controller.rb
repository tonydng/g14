class BookTopicsController < ApplicationController
  before_action :set_book_topic, only: [:show, :edit, :update, :destroy]

  # GET /book_topics
  # GET /book_topics.json
  def index
    @book_topics = BookTopic.all
  end

  # GET /book_topics/1
  # GET /book_topics/1.json
  def show
  end

  # GET /book_topics/new
  def new
    @book_topic = BookTopic.new
  end

  # GET /book_topics/1/edit
  def edit
  end

  # POST /book_topics
  # POST /book_topics.json
  def create
    @book_topic = BookTopic.new(book_topic_params)

    respond_to do |format|
      if @book_topic.save
        format.html { redirect_to @book_topic, notice: 'Book topic was successfully created.' }
        format.json { render :show, status: :created, location: @book_topic }
      else
        format.html { render :new }
        format.json { render json: @book_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_topics/1
  # PATCH/PUT /book_topics/1.json
  def update
    respond_to do |format|
      if @book_topic.update(book_topic_params)
        format.html { redirect_to @book_topic, notice: 'Book topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_topic }
      else
        format.html { render :edit }
        format.json { render json: @book_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_topics/1
  # DELETE /book_topics/1.json
  def destroy
    @book_topic.destroy
    respond_to do |format|
      format.html { redirect_to book_topics_url, notice: 'Book topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_topic
      @book_topic = BookTopic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_topic_params
      params.require(:book_topic).permit(:book_id, :topic_id)
    end
end
