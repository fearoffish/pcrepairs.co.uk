require 'rubygems'
require 'sinatra'
require 'pony'

get "/" do
  @title = 'Skipton'
  @selected = 'about'
  erb :home
end

get '/home_services' do
  @title = 'Home Services'
  @selected = 'home'
  erb :home_services
end

get '/business_services' do
  @title = 'Business Services'
  @selected = 'business'
  erb :business_services
end

get "/contact_us" do
  @title = 'Contact Us'
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

  Pony.mail :to => 'jamie@fearoffish.com',
            :from => from,
            :subject => '[PC Repairs] Contact Form',
            :message => params[:message]
  
  @flash = "Thanks for getting in touch, we'll get back to you soon."
  erb :home
end