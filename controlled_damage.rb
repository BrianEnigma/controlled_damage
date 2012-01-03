#!/usr/bin/ruby

if ARGV.length != 3 and ARGV.length != 4
    print("USAGE: ./controlled_damage.rb infile outfile distortion [seed]\n")
    print("WHERE:\n")
    print(" infile is the source filename\n")
    print(" outfile is the destination filename\n")
    print(" distortion is how frequently, on average to alter bits.  For example, 100 means 1 in 100 bytes will have a bit flipped.\n")
    print(" seed is the (optional) random seed to use for the random number generator\n")
    exit(1)
end

in_filename = ARGV[0]
out_filename = ARGV[1]
distortion = ARGV[2].to_i
srand(ARGV[3].to_i) if ARGV.length >= 4

$total_bytes = 0
$altered_bytes = 0
BLOCK_SIZE = 1024

def flip_bits(buffer, len, distortion)
    $total_bytes += len
    (0...len).each { |i|
        if 0 == rand(distortion)
            $altered_bytes += 1
            buffer[i] = buffer[i] ^ (0x01 << rand(7))
        end
    }
    #print("Processed #{$total_bytes}, altered #{$altered_bytes} (#{($altered_bytes.to_f / $total_bytes.to_f * 100.0).to_i}%)\n")
end

infile = File.new(in_filename, "rb")
outfile = File.new(out_filename, "wb")

while true
    buffer = infile.read(BLOCK_SIZE)
    break if nil == buffer
    len = buffer.length
    break if 0 == len
    flip_bits(buffer, len, distortion)
    outfile.write(buffer)
end

if ARGV.length >= 4
    seed_was = ARGV[3].to_i
else
    seed_was = srand(0)
end
print("Random seed was #{seed_was}\n")
print("Processed #{$total_bytes}, altered #{$altered_bytes} (#{($altered_bytes / $total_bytes * 100).to_i}%)\n")

