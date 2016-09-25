require_relative 'support.rb'

# ------------------------------------------------------------------

seq, pat = BIO.read('dataset_2_6.txt')

def count(sequence, pattern)
  sequence.each_cons(pattern.length).inject(0) do |count, slice|
    slice == pattern ? count += 1 : count
  end
end

BIO.write('output_2_6.txt', count(seq, pat))

# ------------------------------------------------------------------

text, k = BIO.read('dataset_2_9.txt')

def frequent_kmer(text, k)
  freq = Hash.new(0)
  text.each_cons(k) { |slice| freq[slice] += 1 }
  max_count = freq.values.max
  freq.select { |_, c| c == max_count }.keys.map(&:join)
end

BIO.write('output_2_9.txt', frequent_kmer(text, k))

# ------------------------------------------------------------------

text = File.read("#{DIR}/dataset_3_2.txt").strip.split(//)

def reverse_nuc(sequence)
  complement = {'A' => 'T', 'T' => 'A', 'G' => 'C', 'C' => 'G'}
  sequence.reverse.map { |n| complement[n] }
end

BIO.write('output_3_2.txt', reverse_nuc(text))

# ------------------------------------------------------------------
