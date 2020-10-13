module tp1
    implicit none

    !Variables Universelles
    real, parameter ::  g = 9.81
    real, parameter ::  l = 0.1
    real, parameter ::  m = 6e-3
    real, parameter ::  R = 8.32
    real, parameter ::  n = 8e-7

    !Variables du probleme
    real, parameter :: w0 = g/l
    real, parameter :: x0 = 1.0 ! Dans ce programme on ecrit l'angle comme la variable 'x' au lieu de la variable 'teta'
    real, parameter :: Tc = m*g*l/(2*n*R*x0**2)
    !real, parameter :: T = 0.1*Tc
    real, parameter :: eps = 1e-15 ! Niveau de precision avec laquelle on veut aproicher le zero de la fonction considérée
    real, parameter :: gam = 2*n*R/(m*l*l)
    
end
!-------------------------------------------------------

subroutine f(x,y,dy,T)
    !implicit none
    use tp1
    !real x0,T,w0,gam,g,l,m,R,n,eps
    real x,y,dy,T
    
    
    y = ( sin(x)/x )*( x0**2 - x**2 ) - (gam*T)/(w0**2)
    
    dy = (x0**2-x**2)*(x*cos(x)-sin(x))/(x**2) - 2*sin(x)
    
    !Debug
    !write (*,*) ' Les parametres du probleme sont:    ', 'gam = ', gam, 'w0 = ', w0, 'T = ', T, 'x0 = ', x0, 'eps = ', eps
    !write(*,*) '    y = ',y,'    dy = ',dy, ' x = ',x
end
!-------------------------------------------------------

real function newton(f,x0,eps,T)

    implicit none
    
    real x,y,dy,eps,T
    real x0
    integer i, imax
    logical convergence
    
    imax = 10
    x = x0
    y = 1.0

    print '(A)'
    do i = 1, imax 
    !La Variable imax permet d'eviter la consomation de ressources trop importante lorsque l'algorithme ne trouve pas de solutions
        
        call f(x,y,dy,T) ! Initialise les valeurs à la ièmme boucle
        
        !Debug
        !write(*,*) 'i = ',i,'    y = ',y,'    dy = ',dy, ' x = ',x
        
        x = x - y/dy
        
        convergence  = abs(y) < eps
        !La Variable convergence est une variable logique (ou booléenne) qui est vrai lorsque la condition de convergence est verifiée

        if ( convergence .or. i==imax ) then
            
            newton = x
            !write(*,*) ' Le zero est à x = ', x
            
            exit 
        endif
    enddo

end
!-------------------------------------------------------

program transphase
    !implicit none

    !Imports (din't forget to include each subroutine)
    use tp1
    real :: newton,T,Teq
    integer :: k
    external :: f

    !Variables disponibles
    write (*,*) ' Les parametres du probleme sont:    ', 'gam = ', gam, 'w0 = ', w0, 'Tc = ', Tc, 'x0 = ', x0, 'eps = ', eps
    
    !On peut disposer des subroutines:
    !   f(x)    [Probleme de la bille]

    T = Tc

    open(1, file ='Teq.dat')

    do k = 1,100

        T = k*0.01*Tc

        Teq = newton(f,X0,eps,T)
        
        write(*,*) T,'  ', Teq
        write(1,*) T,'  ', Teq

    enddo

    close(1)

end
!-------------------------------------------------------