class EmojiParamParser
  def self.parse(params)
    params[:emojis].map do |emoji|
      name = if emoji[1][:mapping].empty?
        emoji[1][:name]
      else
        emoji[1][:mapping]
      end
      Emoji.new(
        emoji[0],
        name,
        emoji[1][:url]
      )
    end
  end
end
