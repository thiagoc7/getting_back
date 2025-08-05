require "test_helper"

class ChaptersTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get chapters index" do
    get book_chapters_url(@book)
    assert_response :success
    assert_select "h1", "Chapters"
    assert_select "p", "Chapters for \"#{@book.title}\""
  end

  test "should create a new chapter" do
    get new_book_chapter_url(@book)
    assert_response :success
    assert_select "h1", "New Chapter"

    assert_difference("Chapter.count") do
      post book_chapters_url(@book), params: {
        chapter: {
          title: "Chapter 1: The Beginning",
          content: "This is the first chapter of our story. It introduces the main characters and sets the scene for the adventure that follows."
        }
      }
    end

    assert_redirected_to book_chapter_url(@book, Chapter.last)
    follow_redirect!
    assert_select "h1", "Chapter 1: The Beginning"
    assert_select "h2", "Chapter Content"
  end

  test "should show chapter details" do
    chapter = chapters(:one)
    get book_chapter_url(@book, chapter)
    assert_response :success
    assert_select "h1", chapter.title
    assert_select "h2", "Chapter Content"
    assert_select "h3", "Chapter Information"
  end

  test "should edit chapter" do
    chapter = chapters(:one)
    get edit_book_chapter_url(@book, chapter)
    assert_response :success
    assert_select "h1", "Edit Chapter"

    patch book_chapter_url(@book, chapter), params: {
      chapter: {
        title: "Updated Chapter Title",
        content: "Updated chapter content with more details and information."
      }
    }

    assert_redirected_to book_chapter_url(@book, chapter)
    follow_redirect!
    assert_select "h1", "Updated Chapter Title"
  end

  test "should delete chapter" do
    chapter = chapters(:one)
    assert_difference("Chapter.count", -1) do
      delete book_chapter_url(@book, chapter)
    end

    assert_redirected_to book_chapters_url(@book)
    follow_redirect!
    assert_select "h1", "Chapters"
  end

  test "should create chapter with photos" do
    get new_book_chapter_url(@book)
    assert_response :success

    # Simulate file upload (in real test you'd use fixture_file_upload)
    assert_difference("Chapter.count") do
      post book_chapters_url(@book), params: {
        chapter: {
          title: "Chapter with Photos",
          content: "This chapter includes photos to illustrate the story.",
          photos: [] # In real test: [fixture_file_upload("test_image.jpg", "image/jpeg")]
        }
      }
    end

    assert_redirected_to book_chapter_url(@book, Chapter.last)
  end

  test "should display chapter stats correctly" do
    get book_chapters_url(@book)
    assert_response :success
    assert_select ".stat-title", "Total Chapters"
    assert_select ".stat-title", "With Photos"
    assert_select ".stat-title", "Latest Chapter"
  end

  test "should show empty state when no chapters" do
    # Create a book without chapters
    empty_book = Book.create!(title: "Empty Book", author: "Empty Author")

    get book_chapters_url(empty_book)
    assert_response :success
    assert_select "h3", "No chapters yet"
    assert_select "a", "Add your first chapter"
  end

  test "should validate chapter creation with missing fields" do
    get new_book_chapter_url(@book)
    assert_response :success

    assert_no_difference("Chapter.count") do
      post book_chapters_url(@book), params: {
        chapter: {
          title: "",
          content: ""
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "span.label-text-alt.text-error"
  end

  test "should navigate between book and chapters" do
    # Go to book details
    get book_url(@book)
    assert_response :success
    assert_select "a", "View Chapters"

    # Go to chapters
    get book_chapters_url(@book)
    assert_response :success
    assert_select "a", "Back to Book"

    # Go back to book
    get book_url(@book)
    assert_response :success
  end

  test "should display chapter in book details page" do
    chapter = chapters(:one)
    get book_url(@book)
    assert_response :success
    assert_select "h2", "Chapters"
    assert_select "h3", chapter.title
  end
end
