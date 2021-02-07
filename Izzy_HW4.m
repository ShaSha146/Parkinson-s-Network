function [V,u] = Izzy_HW4(a, b, c, d, I, V, u)
            dt =.2; % in miliseconds
            dVdt = .04*((V)^2) + 5*(V) + 140 - u + I;
            dudt = a*((b*V)-u);
            if(V >= 30)
                V = c;
                u = u + d;
            else
                V = V + (dVdt*dt);
                u = u + (dudt*dt);
            end
            
            
            return
    end