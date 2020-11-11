program array


    !Generates the arrays of data array of the Slots
    implicit none

    !Declaration
    integer, parameter :: N = 1000
    complex, dimension(N) :: x,y, FFT
    real, dimension(4*N+15):: w
    integer            :: k
    real               :: xi, xf
    
    !Initialisation
    x(:)    = (0,0)    
    y(:)    = (0,0)    
    FFT(:)  = (0,0)
    k = 0
    xi = 0
    xf = 20

    x(1) = xi

    !Creation de la Fente 1D
    do k = 1, N

        if ( k >= int(N/4) .AND. k <= int(N*3/4) ) then
            
            y(k)%re = 1
            
        end if
        
        x(k) = k*(xf-xi)/N

    end do


    FFT = y ! Pour garder la reference


    !FFT de la fente crée
    call dffti(n,w)
    call dfftf(n,FFT,w)

    open(2, file = 'fente1d.data')

    do k = 1, N

        write(2,*) real(x(k)),'   ',real( y(k) ),'   ', real( FFT(k)*conjg(FFT(k)) )
        !write(*,*) real(x(k)),'   ',real( y(k) ),'   ', real( FFT(k)*conjg(FFT(k)) )
    end do
    close(2)
    

end program array