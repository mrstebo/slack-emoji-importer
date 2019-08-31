module EmojiSources
  class Slackmoji
    def initialize(client = Mechanize.new)
      @client = client
    end

    def emojis
      groups.map {|g| g.emojis}.flatten.uniq
    end

    def groups
      @groups ||= home_page.search('li.group').map do |group|
        group_name = group.search('.title').first.text.strip
        emojis = group.search('.emoji').map do |emoji|
          id = SecureRandom.hex
          name = emoji.text.strip
          link = emoji.search('.downloader').first
          command = link.text.strip
          url = link.attributes['href'].value
          Emoji.new(group_name, id, name, command, url)
        end
        EmojiGroup.new(group_name, emojis)
      end
    end

    private

    def home_page
      @home_page ||= @client.get('https://slackmojis.com/')
    end
  end
end
