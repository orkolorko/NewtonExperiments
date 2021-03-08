using Images, FileIO, ImageIO, ImageMagick



function NewtonBasin(k = 10; x_min  = -1.0, x_max = 1.0, x_steps = 1024,
                        y_min  = -1.0, y_max = 1.0, y_steps = 1024
                )
        f(x) = x^3-1
        fprime(x) = 3*x^2

        A  = [x+im*y for x in LinRange(x_min, x_max, x_steps), y in LinRange(y_min, y_max, y_steps)]
        #rea@info A
        for i in 1:k
                A = N.(A, f, fprime)
        end
        return A
end
