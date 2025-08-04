require "test_helper"

class BooksTest < ActionDispatch::IntegrationTest
  test "should get books index" do
    get books_url
    assert_response :success
    assert_select "h1", "Dashboard"
    assert_select "h2", "All Books"
  end

  test "should create a new book" do
    get new_book_url
    assert_response :success
    assert_select "h1", "Novo Livro"

    assert_difference("Book.count") do
      post books_url, params: {
        book: {
          title: "The Great Gatsby",
          author: "F. Scott Fitzgerald",
          description: "A story of the Jazz Age",
          published_at: "1925-04-10",
          status: "published"
        }
      }
    end

    assert_redirected_to book_url(Book.last)
    follow_redirect!
    assert_select "h1", "The Great Gatsby"
    assert_select "p", "by F. Scott Fitzgerald"
  end

  test "should show book details" do
    book = books(:one)
    get book_url(book)
    assert_response :success
    assert_select "h1", book.title
    assert_select "p", "by #{book.author}"
    assert_select "h2", "Book Information"
    assert_select "h2", "Chapters"
  end

  test "should edit book" do
    book = books(:one)
    get edit_book_url(book)
    assert_response :success
    assert_select "h1", "Editar Livro"

    patch book_url(book), params: {
      book: {
        title: "Updated Book Title",
        author: "Updated Author",
        description: "Updated description"
      }
    }

    assert_redirected_to book_url(book)
    follow_redirect!
    assert_select "h1", "Updated Book Title"
    assert_select "p", "by Updated Author"
  end

  test "should delete book" do
    book = books(:one)
    assert_difference("Book.count", -1) do
      delete book_url(book)
    end

    assert_redirected_to books_url
    follow_redirect!
    assert_select "h1", "Dashboard"
  end

  test "should display book status correctly" do
    book = books(:one)
    get book_url(book)
    assert_response :success

    # Check if status badge is displayed
    assert_select "span.badge"
  end

  test "should show chapters section in book details" do
    book = books(:one)
    get book_url(book)
    assert_response :success
    assert_select "h2", "Chapters"
    assert_select "a", "Add Chapter"
  end

  test "should validate book creation with missing fields" do
    get new_book_url
    assert_response :success

    assert_no_difference("Book.count") do
      post books_url, params: {
        book: {
          title: "",
          author: "",
          description: ""
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "span.label-text-alt.text-error"
  end

  test "should display stats on books index" do
    get books_url
    assert_response :success
    assert_select ".stat-title", "Total Books"
    assert_select ".stat-title", "Published"
    assert_select ".stat-title", "Authors"
  end
end
