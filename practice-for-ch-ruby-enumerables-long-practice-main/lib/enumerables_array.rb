class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        select = []
        self.my_each do |el|
            select << el if prc.call(el)    
        end
        select
    end

    def my_reject(&prc)
        reject = []
        self.my_each do |el|
            reject << el if !prc.call(el)
        end
        reject
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if prc.call(el)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |el|
            return false if !prc.call(el)
        end
        true
    end

    def my_flatten
        if !self.is_a?(Array)
            return [self]
        end
        arr = []
        self.each do |el|
            if !el.is_a?(Array)
                arr << el
            else
                arr += el.my_flatten
            end
        end
        arr
    end 

    def my_zip(*arr)
        new_arr = []
        new_arr << self
        arr.each do |subarr|
            new_arr << subarr
        end
        zip = []
        (0...self.length).each do |i|
            s_arr = []
            (0...new_arr.length).each do |j|
                s_arr << new_arr[j][i]
            end
            zip << s_arr
        end
        zip
    end

    def my_rotate(n=1)
        rotated = self.dup
        if n > 0
            n.times do 
                r = rotated.shift
                rotated << r
            end
        elsif n < 0
            n *= -1
            n.times do 
                r = rotated.pop
                rotated.unshift(r)
            end
        end
        rotated
    end

    def my_join(delim="")
        join = ""
        self.each do |el|
            join += el
            join += delim
        end
        join
    end

    def my_reverse
        reverse = []
        i = self.length-1
        while i >= 0
            reverse << self[i]
            i -= 1
        end
        reverse
    end
    
end

# a = [1,2,3]
# a.my_each {|num| puts num}

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]
