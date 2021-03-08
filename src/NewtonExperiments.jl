module NewtonExperiments

export N, raiz, NewtonBasin # uma vez que eu chamar using ExemploJoao, N aparece sem ter que escrever ExemploJoao.N


N(x, f, fprime) = x - f(x)/fprime(x)

function raiz(alpha, n = 10)

    f(x) = x^2-alpha # defino a função cujo zero estou procurando
    fprime(x) = 2*x # defino a derivada da função

    x0 = alpha/2 # defino o ponto inicial

    for i in 1:n # ciclo for deixo i variar em 1, 2, 3, ..., n, significa que vou repetir n vezes a operação
	x0 = N(x0, f, fprime)
    end

    return x0
end

# você consegue fazer isso para raiz cubica?
function raiz_cubica(alpha, n = 10)
    @error "Not Implemented"
end

using Plots
function plot_raiz(alpha, n = 10)
     f(x) = x^2-alpha
     fprime(x) = 2*x
     x0 = alpha/2

     pl = plot(f, 1, 10, label = "")
     pl = plot!(x->0, 1, 10, label = "", color = :black)

     for i in 1:n
	x1 = N(x0, f, fprime)
	pl = plot!( [(x0, f(x0)), (x1, 0)], label = "" )
        x0 = x1
    end
    return pl
end

include("NewtonBasins.jl")


end # module
