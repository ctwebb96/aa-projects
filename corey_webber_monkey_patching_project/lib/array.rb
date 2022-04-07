# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return nil if self.empty?
    
            self.max - self.min
    end
    
    
    def average
        return nil if self.empty?

            self.sum / (self.length * 1.00)
    end

    def median
        return nil if self.empty?

        if self.length.odd?
            mid_index = self.length / 2
            return self.sort[mid_index]
        else
            sorted = self.sort
            mid_index = self.length / 2
            first_ele = sorted[mid_index]
            second_ele = sorted[mid_index - 1]
            return (first_ele + second_ele) / 2.0
        end
    end

    def counts
        count = Hash.new(0)
        
        self.each { |k| count[k] += 1 }
        return count
    end

    def my_count(target)
        num = 0
        self.each do |ele|
            if ele == target
                num += 1
            end
        end  
        num
    end

    def my_index(num)

        self.each_with_index do |n, idx|
            if num == n
                return idx
            end
        end
        return nil
    end

    def my_uniq
        hash = {}
        self.each { |ele| hash[ele] = true }
        hash.keys
    end

    def my_transpose
        new_arr = []

        (0...self.length).each do |row|
            new_row = []

            (0...self.length).each do |col|
                new_row << self[col][row]
            end

            new_arr << new_row
        end
    
        new_arr
    end
end
