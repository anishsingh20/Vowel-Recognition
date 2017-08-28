# Vowel-Recognition
Speaker independent recognition of the eleven steady state vowels of British English using a specified training set of lpc derived log area ratios.

This project describes the application of a variety of feed-forward networks
to the task of recognition of vowel sounds from multiple speakers.
The vowel data was collected by
Deterding [Deterding89], who recorded examples of the eleven steady state
vowels of English spoken by __fifteen speakers__ for a speaker normalisation
study.

(An ascii approximation to) the International Phonetic Association (I.P.A.)
symbol and the word in which the eleven vowel sounds were recorded.
The word was uttered once by each of the fifteen speakers.  Four
male and four female speakers were used to train the networks, and the other
four male and three female speakers were used for testing the performance.

The speech signals were low pass filtered at 4.7kHz and then digitised to 12
bits with a 10kHz sampling rate.  Twelfth order linear predictive analysis was
carried out on six 512 sample Hamming windowed segments from the steady part
of the vowel.  The reflection coefficients were used to calculate 10 log area
parameters, giving a 10 dimensional input space.Each speaker thus yielded six frames of speech from eleven vowels.  This gave
528 frames from the eight speakers used to train the networks and 462 frames
from the seven speakers used to test the networks.



-----

### Trial 1 -with 100 epochs and optimizer as SGD(Stochastic gradient descent)

![github logo](https://github.com/anishsingh20/Vowel-Recognition/blob/master/Pass1-100epochs.png)
