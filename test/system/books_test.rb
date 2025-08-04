require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  test "user can create a new book" do
    visit books_path

    # Click on "Add Book" button
    click_on "Add Book"

    # Fill in the form fields
    fill_in "Título", with: "The Great Gatsby"
    fill_in "Autor", with: "F. Scott Fitzgerald"
    fill_in "Descrição", with: "A story of the Jazz Age"
    fill_in "Data de Publicação", with: "1925-04-10"
    select "Published", from: "Status"

    # Click the submit button
    click_on "Create Book"

    # Verify the book was created and we're on the show page
    assert_text "The Great Gatsby"
    assert_text "by F. Scott Fitzgerald"
    assert_text "Book was successfully created"
  end

  test "user can edit an existing book" do
    book = books(:one)
    visit book_path(book)

    # Click on "Edit" button - use first to avoid ambiguity
    first("a[href='#{edit_book_path(book)}']").click

    # Update the form fields
    fill_in "Título", with: "Updated Book Title"
    fill_in "Autor", with: "Updated Author Name"
    fill_in "Descrição", with: "Updated description with more details"

    # Click the submit button
    click_on "Update Book"

    # Verify the book was updated
    assert_text "Updated Book Title"
    assert_text "by Updated Author Name"
    assert_text "Book was successfully updated"
  end

  test "user can delete a book" do
    book = books(:one)
    visit book_path(book)

    # Click on "Delete Book" button and handle alert
    accept_confirm do
      click_on "Delete Book"
    end

    # Verify we're redirected to books index
    assert_current_path books_path
    assert_text "Book was successfully destroyed"
  end

  test "user can view book details" do
    book = books(:one)
    visit book_path(book)

    # Verify book information is displayed
    assert_text book.title
    assert_text "by #{book.author}"
    assert_text "Book Information"
    assert_text "Chapters"
    assert_text "Quick Stats"
    assert_text "Actions"
  end

  test "user can navigate from books index to book details" do
    book = books(:one)
    visit books_path

    # Click on "View" button for the specific book - use first to avoid ambiguity
    within "tr", text: book.title do
      first("a[href='#{book_path(book)}']").click
    end

    # Verify we're on the book details page
    assert_text book.title
    assert_text "by #{book.author}"
  end

  test "user can navigate from book details to chapters" do
    book = books(:one)
    visit book_path(book)

    # Click on "View Chapters" button
    click_on "View Chapters"

    # Verify we're on the chapters index page
    assert_text "Chapters"
    assert_text "Chapters for \"#{book.title}\""
  end

  test "form validation shows errors for invalid input" do
    visit new_book_path

    # Try to submit empty form
    click_on "Create Book"

    # Verify error messages are displayed - look for visible text
    assert_text "can't be blank"
  end

  test "dashboard shows correct statistics" do
    visit books_path

    # Verify stats cards are present
    assert_text "Total Books"
    assert_text "Published"
    assert_text "Authors"
  end

  test "user can change book status" do
    book = books(:one)
    visit edit_book_path(book)

    # Change status to published
    select "Published", from: "Status"
    click_on "Update Book"

    # Verify status badge is displayed
    assert_text "Published"
  end
end
