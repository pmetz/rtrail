module RTrail
  # Sub class to disable Hashie::Mash warnings
  class Hashie < Hashie::Mash
    disable_warnings
  end
end

