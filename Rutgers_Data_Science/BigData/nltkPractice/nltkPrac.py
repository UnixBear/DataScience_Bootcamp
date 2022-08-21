import nltk
from nltk import word_tokenize
text = word_tokenize("I can ride my bike with no handlebars")
output = nltk.pos_tag(text)
print(output) 