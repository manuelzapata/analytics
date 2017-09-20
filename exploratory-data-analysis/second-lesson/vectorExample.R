a = c("k", "j", "h", "a", "c", "m")

#get a value
print(a[3])

#get a subset using a vector
print(a[c(1,3,5)])

#get a subset using a range
print(a[2:6])

#remove position 3 from the vector
b = a[-3]
print(b)

#reverse vector
print(rev(b))
