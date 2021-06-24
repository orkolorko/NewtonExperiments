using Images, FileIO, ImageIO, ImageMagick, DualNumbers

function NewtonBasin(k = 10; x_min  = -1.0, x_max = 1.0, x_steps = 1024,
                        y_min  = -1.0, y_max = 1.0, y_steps = 1024
                )
        f(x) = x^50+8*x^5-80/3*x^4+20*x^3-2*x+1
        fprime(x) = 50*x^49+40*x^4-320/3*x^3+60*x^2-2

        A  = [x+im*y for y in reverse(LinRange(y_min, y_max, y_steps)), x in LinRange(x_min, x_max, x_steps)]
        #@info A
        for i in 1:k
                A = N.(A, f, fprime)
        end
        return A
end

almost_equal(x, y, epsilon) = abs(x-y)< epsilon ? true : false

function flagging_roots(A, epsilon = 10^-1)
        roots = Complex{Float64}[]
        push!(roots, A[1, 1])
        B = zeros(Int64, size(A))
        for (j, col) in enumerate(eachcol(A))
                for (i, x) in enumerate(col)
                        seen = false
                        for (k, y) in enumerate(roots)
                                if almost_equal(x, y, epsilon)
                                        B[i, j] = k
                                        seen = true
                                end
                        end
                        if seen ==  false
                                push!(roots, x)
                                B[i, j] = length(roots)
                        end
                  end
          end
          return B, roots
end

color_list = [  RGB(202/255, 179/255, 159/255),
                RGB(221/255, 169/255, 130/255),
                RGB(224/255, 187/255, 228/255),
                RGB(175/255, 199/255, 208/266),
                RGB(195/255, 111/255, 49/255),
                RGB(185/255, 203/255, 153/255)]

cores_joao(i; t=1000) = RGB( mod(i^2+i*π, 255)/255, mod(i^2+i*π, 255)/255, mod(4*i*π, 255)/255)
color_list2 = [cores_joao(i) for i in 1:1000]