class Listing
  class << self; attr_accessor :reddit, :num_of_comments end

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
      else
        if key == 'body'
          comments << (value.gsub(/[\n\t\r]/, ' ') + ' ')
        end
      end
    end
      
    comments
  end
  
  def self.get_tf_idf_values(subreddit, link_id)
    num_of_comments = reddit.get_comments(subreddit: 'AskReddit', link_id: '2lrb1w')[0]["data"]["children"][0]["data"]["num_comments"]
	documents = RubyTfIdf::TfIdf.new(get_corpus(reddit.get_comments(subreddit: subreddit, link_id: link_id, limit: num_of_comments, depth: num_of_comments)[1]["data"]), 3, true).tf_idf #.delete_if {|element| element.empty?}.uniq {|element| element.first[0]}.sort{|element| element.first[1]}
	words = {}
	for document in documents
	  for word in document
	    if words.has_key? word[0]
		  words[word[0]] = words[word[0]] + word[1]
		else
		  words[word[0]] = word[1]
		end
     end
   end
   
   words #.sort{|x, y| y[1] <=> x[1]}[1..200].to_h 
  end  
end