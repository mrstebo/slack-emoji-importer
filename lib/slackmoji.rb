class Slackmoji
  def initialize(client = Mechanize.new)
    @client = client
  end

  def emojis
    @emojis ||= home_page.links_with(class: 'downloader').map do |link|
      id = SecureRandom.hex
      name = link.attributes[:download].gsub(/\..*/, '')
      url = link.attributes[:href]
      Emoji.new(id, name, url)
    end
    @emojis.uniq {|x| x.name}.sort! {|a, b| a.name.downcase <=> b.name.downcase}
  end

  private

  def home_page
    @home_page ||= @client.get('https://slackmojis.com/')
  end
end
