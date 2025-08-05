class ChaptersController < ApplicationController
  before_action :set_book
  before_action :set_chapter, only: %i[ show edit update destroy ]

  # GET /books/:book_id/chapters
  def index
    @chapters = @book.chapters
  end

  # GET /books/:book_id/chapters/1
  def show
  end

  # GET /books/:book_id/chapters/new
  def new
    @chapter = @book.chapters.build
  end

  # GET /books/:book_id/chapters/1/edit
  def edit
  end

  # POST /books/:book_id/chapters
  def create
    @chapter = @book.chapters.build(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to book_chapter_path(@book, @chapter), notice: "Chapter was successfully created." }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/:book_id/chapters/1
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to book_chapter_path(@book, @chapter), notice: "Chapter was successfully updated." }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/:book_id/chapters/1
  def destroy
    @chapter.destroy!

    respond_to do |format|
      format.html { redirect_to book_chapters_path(@book), notice: "Chapter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_chapter
      @chapter = @book.chapters.find(params[:id])
    end

    def chapter_params
      params.require(:chapter).permit(:title, :content, photos: [])
    end
end
