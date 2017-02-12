require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'erb'

Dir["lib/**/*.rb"].each {|file| require_relative file}

get '/' do
  slackmoji = Slackmoji.new
  erb :index, locals: {emojis: slackmoji.emojis}
end

put '/emoji' do
  erb :selected_emoji, locals: {
    id: params[:id],
    name: params[:name],
    url: params[:url]
  }
end

post '/import' do
  team_name = params[:team_name]
  email = params[:email]
  password = params[:password]
  emojis = EmojiParamParser.parse(params)

  SessionBuilder.create(team_name, email, password) do |session|
    importer = Importer.new(session)
    emojis.each do |emoji|
      importer.import(emoji)
    end
  end
  content_type :json
  {
    success: true,
    message: "Imported #{emojis.length} emojis"
  }.to_json
end
