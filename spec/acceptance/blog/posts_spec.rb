require 'acceptance/acceptance_helper'

feature 'Posts', %q{
  In order to learn intesting new things
  As a site visitor
  I want to read blog articles
} do

  background do
    published_at = Time.utc(2011, 01, 02, 03)
    Blog::Post.make!(:title => "Test Post", :body => "_Body_ ",
                                :state => 'published',
                                :published_at => published_at,
                                :permalink => 'test')
  end

  scenario 'Viewing the index' do
    visit '/blog'
    page.should have_content("Test Post")
    within('em') { page.should have_content("Body") }
    page.should_not have_content("New Post")
  end

  scenario 'Navigating to a post' do
    visit '/blog'
    click_on "Test Post"
    page.should have_content("Test Post")
    page.should_not have_content("New Post")
    within('em') { page.should have_content("Body") }
    page.should_not have_content("Edit Post")
  end

  scenario 'Linking to a post directly' do
    visit '/blog/2011/01/02/test'
    page.should have_content("Test Post")
  end

  scenario 'Looking for posts on page 2' do
    # Force our original post off the front page (and off the recent posts
    # list, too).
    10.times { Blog::Post.make!(:published) }

    visit '/blog'
    page.should_not have_content("Test Post")
    click_on "Next"
    click_on "Next"
    page.should have_content("Test Post")
    current_path.should == '/blog/page/3'
  end

  scenario 'Adding a comment' do
    visit '/blog'
    click_on 'Comment'
    fill_in "Your name", :with => "Jane Doe"
    fill_in "Comment", :with => "Test comment"
    click_on "Post Comment"
    page.should have_content("Jane Doe")
    page.should have_content("Test comment")

    # Change comment link text.
    visit '/blog'
    click_on "1 comment"
    page.should have_content("Jane Doe")
  end

  scenario 'Validating a comment' do
    visit '/blog'
    click_on 'Comment'
    click_on 'Post Comment'
    page.should have_content("can't be blank")
    fill_in "Your name", :with => "Jane Doe"
    fill_in "Comment", :with => "Test comment"
    click_on "Post Comment"
    page.should have_content("Jane Doe")
  end
end
