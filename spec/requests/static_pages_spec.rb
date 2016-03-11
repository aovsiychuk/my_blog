require 'rails_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('valeria fortuna') }
    it { should have_title("Ruby on Rails Tutorial Sample App") }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        visit signin_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title('Ruby on Rails Tutorial Sample App | Help') }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title('Ruby on Rails Tutorial Sample App | About Us') }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector( 'h1', text: 'Contact') }
    it { should have_title('Ruby on Rails Tutorial Sample App | Contact') }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title ('Ruby on Rails Tutorial Sample App | About Us')
    click_link "Help"
    expect(page).to have_title ('Ruby on Rails Tutorial Sample App | Help')
    click_link "Contact"
    expect(page).to have_title ('Ruby on Rails Tutorial Sample App | Contact')
    click_link "Home"
    click_link "Sign up now"
    expect(page).to have_title ('Ruby on Rails Tutorial Sample App | Sign up')
    click_link "valeria fortuna"
    expect(page).to have_title ('Ruby on Rails Tutorial Sample App')

  end

end