class Enumerator
  def at_end
    peek
    false
  rescue StopIteration
    true
  end
  # http://stackoverflow.com/questions/16387530/enumeratoreach-restarts-sequence
  def each_remaining
    loop do
      yield self.next
    end
  end
end

module DBDiff
  module_function

  # simple primary key is first field
  # precondition: records are ordered on their key: least to greatest
  # a is the old table, b is the new table
  def outer_join( a, b)
    return to_enum(__method__, a, b) unless block_given?
    loop do
      if a.at_end
        b.each_remaining{|r| yield "added: #{r}"}
        break
      elsif b.at_end
        a.each_remaining{|r| yield "removed: #{r}"}
        break
      end
      loop do
        a_r = a.peek
        b_r = b.peek
        case a_r[0] <=> b_r[0]
        when 1
          yield "added: #{b_r}"
          b.next
        when 0
          yield "changed: #{b_r}" unless a_r[1..-1] == b_r[1..-1]
          a.next
          b.next
        when -1
          yield "removed: #{a_r}"
          a.next
        end
      end
    end
  end
end


# raise "usage: dbdiff old new" unless ARGV.size == 2

# # one record per line; space-separated fields
# old_table = File.open(ARGV[0]).each_line.lazy.map &:split
# new_table = File.open(ARGV[1]).each_line.lazy.map &:split

# outer_join( old_table, new_table)
