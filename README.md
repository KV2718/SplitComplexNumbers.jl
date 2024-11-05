Version 0.1.2

This is a package which implements split-complex numbers in Julia.
I have given a brief overview of how they work below but the Wikipedia article is more detailed: https://en.wikipedia.org/wiki/Split-complex_number

Split-complex numbers are number of the form $a + bj$ where $j^2 = 1$ but $j \neq ±1$.
Addition works as it would with complex numbers and multiplication is done by expanding brackets.
Split-complex numbers have an equivalent 'Euler's Formula':

$$\mathrm{e}^{jx} = \cosh(x) + j \sinh(x)$$

However not all split-complex numbers can be written in this way when $x$ is a real number and so logs are not well-defined.

The split-complex unit can also be represented by a matrix:

$$j \to \begin{pmatrix}
0 & 1 \\
1 & 0
\end{pmatrix}
$$

As it 'squares' to but is not the identity.

Split-complex numbers have a bigger problem than that with logs, as division by a split complex is not always well-defined due to the existence of zero divisiors, numbers which are not zero but which multiply to it.

$$(a + a j)(a - a j) = a^2 - a^2 = 0$$

$$\frac{1}{a ± aj} = \frac{a ∓ aj}{(a ± aj)(a ∓ aj)} = \frac{a ∓ aj}{0}$$

Division by zero is obviously problematic is in in part why split-complex numbers are seldom applied in the sciences, as compared to complex numbers which are touted as being 'unreasonably effective'.

We are able to develop a 'split-complex analysis' but the aforementioned problems cripple it greatly.
