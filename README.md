# Lattice Paths Solver

This is a tiny app I wrote to help me learn [Elm](http://elm-lang.org/). It's a solution to [this challenge](https://projecteuler.net/problem=15) from Project Euler.

At the moment, it can calculate the number of paths for lattices up to 20 x 20. I'd like to come back to this and add an animation which cycles through each of the possible paths.

Interestingly, when making this I hit upon the limit of the Integer type in Elm, which starts giving [strange results](https://github.com/elm-lang/elm-compiler/issues/1258) when operating on integers higher than 2^31. I used conversion to Float and back, which was able to deal with these larger values.

I used Elm v0.18.0. The index.html is already compiled into Javascript using elm-make so should work on most browsers. 
