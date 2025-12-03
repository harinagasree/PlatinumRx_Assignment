def time_converter(time):
    hours = time // 60
    minutes = time % 60
    
    if minutes == 0:
        return f"{hours} hrs"
    else:
        return f"{hours} hrs {minutes} mins"

time = 130
output = time_converter(time)
print(output)

