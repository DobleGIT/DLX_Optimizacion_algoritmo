        .data

; VARIABLES DE ENTRADA: NO MODIFICAR ORDEN (Se pueden modificar los valores)
a1: .float 1.1
a2: .float 2.2
a3: .float 3.3
a4: .float 4.4

;;;;; VARIABLES DE SALIDA: NO MODIFICAR ORDEN
; m11, m12, m13, m14
; m21, m22, m23, m24
; m31, m32, m33, m34
; m41, m42, m43, m44

M: .float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0
; hm1, hm2, hm3, hm4

HM: .float 0.0, 0.0, 0.0, 0.0
; vm1, vm2, vm3, vm4

VM: .float 0.0, 0.0, 0.0, 0.0
check: .float 0.0

;;;;; FIN NO MODIFICAR ORDEN

.text  
    .global main

main:

    ;cargamos MF(a1,a2)

    lf  f1,a1
    lf  f2,a2
    eqf f2,f0   ;Si dividimos entre 0 hace un salto al final del programa
    bfpt    fin
    divf    f2,f1,f2
    lf  f3,a2
    multf   f4,f1,f3

    ;cargamos MF(a3,a4)

    lf  f5,a3
    lf  f6,a4
    eqf f6,f0   ;Si dividimos entre 0 hace un salto al final del programa
    bfpt    fin
    divf    f6,f5,f6
    lf  f7,a4
    multf   f8,f5,f7

    ;producto de Kronercker de f9 a f24
    ;primera fila
    multf   f9,f1,f5
    multf   f10,f1,f6
    multf   f11,f2,f5
    multf   f12,f2,f6
    ;segunda fila
    multf   f13,f1,f7
    multf   f14,f1,f8
    multf   f15,f2,f7
    multf   f16,f2,f8
    ;tercera fila
    multf   f17,f3,f5
    multf   f18,f3,f6
    multf   f19,f4,f5
    multf   f20,f4,f6
    ;cuarta fila
    multf   f21,f3,f7
    multf   f22,f3,f8
    multf   f23,f4,f7
    multf   f24,f4,f8

    ;a1+a4
    addf    f25,f1,f7

    ;calculamos MF(a2,a3) a2 esta en f3 y a3 esta en f5

    eqf f5,f0   ;Si dividimos entre 0 hace un salto al final del programa
    bfpt    fin
    divf   f26,f3,f5
    multf   f27,f3,f5

    ;calculamos el determinante de MF(a2,a3)

    multf   f28,f3,f27
    multf   f29,f5,f26
    subf    f30,f28,f29

    ;calculamos (a1+a4)/|MF(a2,a3)|

    eqf f30,f0   ;Si dividimos entre 0 hace un salto al final del programa
    bfpt    fin
    divf    f30,f25,f30

    ;calculamos M de f9 a f24
    multf   f9,f9,f30
    multf   f10,f10,f30
    multf   f11,f11,f30
    multf   f12,f12,f30
    multf   f13,f13,f30
    multf   f14,f14,f30
    multf   f15,f15,f30
    multf   f16,f16,f30
    multf   f17,f17,f30
    multf   f18,f18,f30
    multf   f19,f19,f30
    multf   f20,f20,f30
    multf   f21,f21,f30
    multf   f22,f22,f30
    multf   f23,f23,f30
    multf   f24,f24,f30

    ;Almacenamos M

    sf  M,f9
    sf  M+4,f10
    sf  M+8,f11
    sf  M+12,f12
    sf  M+16,f13
    sf  M+20,f14
    sf  M+24,f15
    sf  M+28,f16
    sf  M+32,f17
    sf  M+36,f18
    sf  M+40,f19
    sf  M+44,f20
    sf  M+48,f21
    sf  M+52,f22
    sf  M+56,f23
    sf  M+60,f24
    
    ;Calculamos VM

    multf   f9,f9,f13
    multf   f10,f10,f14
    multf   f11,f11,f15
    multf   f12,f12,f16

    ;Calculamos HM

    multf   f17,f17,f21
    multf   f18,f18,f22
    multf   f19,f19,f23
    multf   f20,f20,f24

    ;Calculamos check lo guardamos en f21

    multf   f21,f21,f0
    addf    f21,f21,f9
    addf    f21,f21,f10
    addf    f21,f21,f11
    addf    f21,f21,f12
    addf    f21,f21,f17
    addf    f21,f21,f18
    addf    f21,f21,f19
    addf    f21,f21,f20

    ;Almacenamos VM

    sf  VM,f9
    sf  VM+4,f10
    sf  VM+8,f11
    sf  VM+12,f12

    ;Almacenamos HM
    
    sf  HM,f17
    sf  HM+4,f18
    sf  HM+8,f19
    sf  HM+12,f20

    ;Almacenamos check

    sf check,f21

fin:
    ;fin de la ejecucion
    trap 0

    


