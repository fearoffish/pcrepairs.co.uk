require 'sinatra'
require 'pony'

get "/" do
  @title = 'in Skipton, Embsay, Crosshills, Silsden, Steeton and more. All over Yorkshire.'
  @selected = 'about'
  erb :home
end

get '/home_services' do
  @title = 'Home PC services in the Skipton Area'
  @selected = 'home'
  erb :home_services
end

get '/business_services' do
  @title = 'Business IT services in the Skipton Area'
  @selected = 'business'
  erb :business_services
end

get "/contact_us" do
  @title = 'Get in touch, by phone, address or email'
  @selected = 'contact'
  erb :contact
end

post '/' do
  [:name, :email, :message].each do |key|
    if key.nil? || key == ''
      redirect '/contact_us'
    end
  end
  from = "#{params[:name]} <#{params[:email]}>"
  body = "Someone sent you this message from your website: \n\n" + params[:message]
  Pony.mail :to => 'jamie@fearoffish.com',
            :from => from,
            :subject => '[PC Repairs] Contact Form',
            :body => body,
            :via => :smtp,
            :via_options => {
              :address        => 'smtp.sendgrid.net',
              :port           => '587',
              :user_name      => ENV['SENDGRID_USERNAME'],
              :password       => ENV['SENDGRID_PASSWORD'],
              :authentication => :plain,
              :domain         => ENV['SENDGRID_DOMAIN']
            }
  
  @flash = "Thanks for getting in touch, we'll get back to you soon"
  erb :home
end