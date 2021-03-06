require_relative 'timelimit'

class Poll

  class InvalidCandidateError < StandardError
  end
  class VoteTimeLimitExceededError < StandardError
  end
  class DuplicatedVoteError < StandardError
  end

  attr_reader :title, :candidates, :votes, :timelimit, :voters

  def initialize(title, candidates, timelimit=TimeLimit.new("", ""))
    @title = title
    @candidates = candidates
    @votes = []
    @timelimit = timelimit
    @voters = []
  end

  def voted?(voter)
    @voters.include?(voter)
  end

  def undo(voter)
    @voters.delete(voter)
    idx = @votes.find_index { |vote| vote.voter == voter }
    @votes.delete_at(idx)
  end


  def add_vote(vote)
    if timelimit.exceeded(vote.time)
      raise VoteTimeLimitExceededError
    end
    if voted?(vote.voter)
      raise DuplicatedVoteError
    end
    if @candidates.include?(vote.candidate)
      @voters << vote.voter
      @votes << vote
    elsif
      raise InvalidCandidateError
    end
  end

  def count_votes()
    ret = {}
    @candidates.each do |cand|
      ret[cand] = 0
    end
    votes.each do |vote|
      ret[vote.candidate] += 1
    end
    ret
  end
end
