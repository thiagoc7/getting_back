require "test_helper"

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @chapter = chapters(:one)
  end

  test "should get index" do
    get book_chapters_url(@book)
    assert_response :success
  end

  test "should get show" do
    get book_chapter_url(@book, @chapter)
    assert_response :success
  end

  test "should get new" do
    get new_book_chapter_url(@book)
    assert_response :success
  end

  test "should create chapter" do
    assert_difference("Chapter.count") do
      post book_chapters_url(@book), params: { chapter: { title: "Test Chapter", content: "Test content" } }
    end

    assert_redirected_to book_chapter_url(@book, Chapter.last)
  end

  test "should get edit" do
    get edit_book_chapter_url(@book, @chapter)
    assert_response :success
  end

  test "should update chapter" do
    patch book_chapter_url(@book, @chapter), params: { chapter: { title: "Updated Chapter" } }
    assert_redirected_to book_chapter_url(@book, @chapter)
  end

  test "should destroy chapter" do
    assert_difference("Chapter.count", -1) do
      delete book_chapter_url(@book, @chapter)
    end

    assert_redirected_to book_chapters_url(@book)
  end
end
