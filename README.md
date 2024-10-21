Version 0.1.0

This is a package which implements split-complex numbers in Julia.
I have given a brief overview of how they work below but the Wikipedia article is more detailed: https://en.wikipedia.org/wiki/Split-complex_number

Split-complex numbers are number of the form $a + bj$ where $j^2 = 1$ but $j \neq ±1$.
Addition works as it would with complex numbers and multiplication is done by expanding brackets.
Split-complex numbers have an equivalent 'Euler's Formula':

$$\mathrm{e}^{jx} = \cosh(x) + j \sinh(x)$$

However not all split-complex numbers can be written in this way when $x$ is a real number
