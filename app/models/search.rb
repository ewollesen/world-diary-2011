class Search

  MAX_RESULTS = 25

  def self.perform(terms, campaign=nil)
    root = campaign ? campaign.people : Person.scoped
    root.with_permissions_to(:read)
      .order("pg_search_rank DESC, name")
      .limit(MAX_RESULTS)
      .full_search(terms)
  end

end
