module Repository(T)
  abstract def add(instance : T)
  abstract def all : Array(T)
end
