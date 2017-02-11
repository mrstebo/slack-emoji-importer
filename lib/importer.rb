require 'open-uri'

class Importer
  def initialize(session)
    @session = session
  end

  def import(emoji)
    create_temporary_file(emoji.url, save_path_for(emoji)) do
      @session.fill_in 'name', with: emoji.name
      @session.attach_file 'img', save_path_for(emoji)
      @session.click_on 'Save New Emoji'
    end
  end

  private

  def save_path_for(emoji)
    File.basename(URI.parse(emoji.url).path)
  end

  def create_temporary_file(url, path)
    File.open(path, 'w') do |f|
      IO.copy_stream(open(url), f)
    end
    yield
    File.delete(path)
  end
end
