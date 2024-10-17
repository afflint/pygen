
output = []
for n in range(0, 100):
    if n % 2 == 0:
        output.append(n)    
# print(output)

out = [n for n in range(0, 100) if n % 2 == 0]

x = "questo è un testo che contiene dei caratteri"
vowels = "aèeiou"

out = [c for c in x if c not in vowels]

print("".join(out))