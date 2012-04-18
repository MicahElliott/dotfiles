#! /usr/bin/env python

# From Peter Norvig: http://norvig.com/spell-correct.html

import sys
import re, collections

DICT = '/usr/share/dict/words'

def words(text): return re.findall('[a-z]+', text.lower()) 

def train(features):
    model = collections.defaultdict(lambda: 1)
    for f in features:
        model[f] += 1
    return model

NWORDS = train(words(file(DICT).read()))

alphabet = 'abcdefghijklmnopqrstuvwxyz'

def edits1(word):
   splits     = [(word[:i], word[i:]) for i in range(len(word) + 1)]
   deletes    = [a + b[1:] for a, b in splits if b]
   transposes = [a + b[1] + b[0] + b[2:] for a, b in splits if len(b)>1]
   replaces   = [a + c + b[1:] for a, b in splits for c in alphabet if b]
   inserts    = [a + c + b     for a, b in splits for c in alphabet]
   ##print 'splits:', splits
   ##print 'deletes:', deletes
   ##print 'transposes:', transposes
   ##print 'replaces:', replaces
   ##print 'inserts:', inserts
   return set(deletes + transposes + replaces + inserts)

def known_edits2(word):
    return set(e2 for e1 in edits1(word) for e2 in edits1(e1) if e2 in NWORDS)

def known(words): return set(w for w in words if w in NWORDS)

def correct(word):
    candidates = known([word]) or known(edits1(word)) or known_edits2(word) or [word]
    ##print 'candidates', candidates
    ##return max(candidates, key=NWORDS.get)
    return candidates

# MDE: Adding a printout of matches.
word = sys.argv[1]
print 'Real words similar to "%s":' % word
for cand in correct(word):
    print ' ', cand

#from IPython.Shell import IPShellEmbed
#ipshell = IPShellEmbed()
#ipshell() # this call anywhere in your program will start IPython 
