def my_map(array, &prc)
    mapped = []

    array.each do |el|
        mapped << prc.call(el)
    end

    mapped
end

def my_select(array,&prc)
    selected = []

    array.each do |el|
        if prc.call(el) == true
            selected << el
        end 
    end

   selected 
end

def my_count(array, &prc)
    num = 0

    array.each do |el|
        if prc.call(el) == true
            num += 1
        end
    end

    num
end

def my_any?(array, &prc)
    array.each do |el|
        if prc.call(el) == true
           return true
        end
    end
    
    false
end

def my_all?(array, &prc)
    array.each do |el|
        if prc.call(el) == false
            return false
        end
    end
    
    true
end

def my_none?(array, &prc)
    array.each do |el|
        if prc.call(el) == true
            return false
        end
    end

    true
end



