class HomeCrawler

  include Crawler

  attr_reader :data

  def run
    @data = episode_links.map do |link|
      link.node.ancestors
      byebug
      [link.text, link.resolved_uri.to_s]
    end
    # episode_links.each do |link|
    #   ::Episode.find_or_initialize_by(uri: link.resolved_uri.to_s).tap do |episode|
    #     if episode.new_record?
    #       episode.series = Series.find_or_create_by(title: link.text)
    #     end
    #     episode.title = link.text
    #     puts "#{link.text} saved." if (episode.new_record? || episode.changed?) && episode.save!
    #   end
    # end
    # true
  end

  private

  def episode_links(name = nil)
    links.select { |l| l.href =~ /^ViewMedia\.aspx\?Num=[0-9]+$/ }.reject { |l| l.text == name }
  end


end
