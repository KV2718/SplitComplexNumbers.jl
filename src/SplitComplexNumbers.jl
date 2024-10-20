module SplitComplexNumbers

export SplitComplex, mod2

struct SplitComplex{T<:Real}
    x::T
    y::T
end

Base.show(io::IO, z::SplitComplex) = z.y ≥ 0 ? print(io, z.x, " + ", z.y, "j") : print(io, z.x, " - ", -z.y, "j")

const j = SplitComplex(0, 1)

# allows real numbers to be recognised more broadly as split-complex numbers
Base.promote_rule(::Type{SplitComplex{T}}, ::Type{R}) where {T<:Real, R<:Real} = SplitComplex{promote_type(T, R)}
Base.convert(::Type{SplitComplex{T}}, x::T) where {T<:Real} = SplitComplex(x, zero(T))

Base.real(z::SplitComplex{T}) where {T<:Real} = z.x
Base.imag(z::SplitComplex{T}) where {T<:Real} = z.y
Base.reim(z::SplitComplex{T}) where {T<:Real} = (real.(z), imag.(z))
Base.conj(z::SplitComplex{T}) where {T<:Real} = SplitComplex(z.x, -z.y)

mod2(z::SplitComplex{T}) where {T<:Real} = z.x^2 - z.y^2
Base.abs(z::SplitComplex{T}) where {T<:Real} = sqrt(z.x^2 + z.y^2)
Base.angle(z::SplitComplex{T}) where {T<:Real} = atan(z.y, z.x)

Base.:+(z1::SplitComplex{T}, z2::SplitComplex{R}) where {T<:Real, R<:Real} = SplitComplex(z1.x + z2.x, z1.y + z2.y)
Base.:+(z::SplitComplex{T}, t::R) where {T<:Real,R<:Real} = SplitComplex(z.x + t, z.y)
Base.:+(t::R, z::SplitComplex{T}) where {T<:Real,R<:Real} = SplitComplex(t + z.x, z.y)

Base.:-(z::SplitComplex{T}) where {T<:Real} = SplitComplex(-z.x, -z.y)
Base.:-(z1::SplitComplex{T}, z2::SplitComplex{R}) where {T<:Real,R<:Real} = SplitComplex(z1.x - z2.x, z1.y - z2.y)
Base.:-(z::SplitComplex{T}, t::R) where {T<:Real,R<:Real} = SplitComplex(z.x - t, z.y)
Base.:-(t::R, z::SplitComplex{T}) where {T<:Real,R<:Real} = SplitComplex(t - z.x, -z.y)

Base.:*(z1::SplitComplex{T}, z2::SplitComplex{R}) where {T<:Real,R<:Real} = SplitComplex(z1.x * z2.x + z1.y * z2.y, z1.x * z2.y + z2.x * z1.y)
Base.:*(z::SplitComplex{T}, t::R) where {T<:Real,R<:Real} = SplitComplex(z.x * t, z.y * t)
Base.:*(t::R, z::SplitComplex{T}) where {T<:Real,R<:Real} = SplitComplex(t * z.x, t * z.y)

Base.:/(z::SplitComplex{T}, t::R) where {T<:Real,R<:Real} = 1 / t * z
Base.:/(t::R, z::SplitComplex{T}) where {T<:Real,R<:Real} = t * SplitComplex(z.x, -z.y) / (z.x^2 - z.y^2)
Base.:/(z1::SplitComplex{T}, z2::SplitComplex{R}) where {T<:Real,R<:Real} = (z1 == z2) ? 1 : SplitComplex((z1.x * z2.x - z1.y * z2.y), (z1.y * z2.x - z1.x * z2.y)) / (z2.x^2 - z2.y^2)

# exp(tj) = cosh(t) + j*sinh(t)
# log(x + jy) = u + jv, exponentiate both sides to solve
# u = log(x^2-y^2)/2, v = atanh(y/x)
Base.exp(z::SplitComplex{T}) where {T<:Real} = exp(z.x) * SplitComplex(cosh(z.y), sinh(z.y))
Base.log(z::SplitComplex{T}) where {T<:Real} = (z.y / z.x == abs(z.y / z.x) < 1) ? SplitComplex(log(z.x^2 - z.y^2) / 2, atanh(z.y / z.x)) : throw(DomainError(z, "Logarithm of a split-complex number where x² ≤ y² or y/x ≤ 0 is not defined. The result in general includes complex numbers as well as split-complexes."))

Base.:^(z::SplitComplex{T}, n::N) where {T<:Real,N<:Integer} = prod([z for _ in 1:n])
Base.:^(z1::SplitComplex{T}, z2::SplitComplex{R}) where {T<:Real,R<:Real} = exp(z2 * log(z1))
Base.:^(z::SplitComplex{T}, t::R) where {T<:Real,R<:Real} = exp(t * log(z))
Base.:^(t::R, z::SplitComplex{T}) where {T<:Real,R<:Real} = t^z.x * SplitComplex(cosh(z.y * log(t)), sinh(z.y * log(t)))

end # module SplitComplexNumbers