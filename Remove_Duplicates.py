
def remove_duplicates(word):
    k = ""
    for i in word:
        if i not in k:
            k+=i
    return k

word = "Eucalyptus"
result = remove_duplicates(word)
print(result)