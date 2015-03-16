class Post
  attr_reader :id, :title, :body

  def initialize(options)
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
  end

  # Returns a single Post object.
  def self.find(p_id)
    result = DATABASE.execute("SELECT * FROM posts WHERE id = #{p_id}")[0]
    self.new(result)
  end

  # Get all posts.
  #
  # Returns an Array of Post objects.
  def self.all
    results = DATABASE.execute("SELECT * FROM posts")
    results.map { |result_hash| self.new(result_hash) }
  end

  # Returns the Integer value representing how many likes this post has.
  def likes
    query = "SELECT COUNT(*) AS num_likes FROM likes WHERE post_id = #{id}"
    result = DATABASE.execute(query)[0]
    return result["num_likes"]
  end
end
