class Listing
  class << self
    attr_accessor :reddit, :num_of_comments
  end

  @reddit = Snoo::Client.new
  begin
    @reddit.log_in 'ahcarpenter', 'Drewby!23'
  rescue
    @reddit.log_in 'ahcarpenter', 'Drewby!23'
  end
  
  def self.get_corpus(response, comments = [])
    response.each do |key,value|
      value = value || key
      
	  if value.is_a?(Hash) || value.is_a?(Array)
        get_corpus(value, comments)
      elsif key == 'body'
        comments << value.gsub(/[\n\t\r]/, ' ') + ' '
      end
    end
      
    comments
  end
  
  def self.get_tf_idf_values(subreddit, link_id)
    num_of_comments = reddit.get_comments(subreddit: 'AskReddit', link_id: '2lrb1w')[0]["data"]["children"][0]["data"]["num_comments"]
	documents = RubyTfIdf::TfIdf.new(get_corpus(reddit.get_comments(subreddit: subreddit, link_id: link_id, limit: num_of_comments, depth: num_of_comments)[1]["data"]), 3, true).tf_idf #.delete_if {|element| element.empty?}.uniq {|element| element.first[0]}.sort{|element| element.first[1]}
	words = {}
	documents.each {|document|
	  document.each {|word|
	    words.has_key?(word[0]) ? words[word[0]] = words[word[0]] + word[1] : words[word[0]] = word[1]
     }
   }
   
   words
  end  
end