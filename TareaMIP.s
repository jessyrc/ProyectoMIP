    .global proceso

proceso:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0-S6}
    VMOV S1, R0
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso1

proceso1:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso2

proceso2:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso3

proceso3:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso4

proceso4:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso5

proceso5:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R0, {S0}
    VLDM R1, {S1}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

.global proceso6

proceso6:
    PUSH {LR}
    VPUSH {S16-S31}

    VLDM R1, {S0}
    VMUL.F32 S1, S0, S1
    VMOV R0, S1
    VPOP {S16-S31}
    POP {PC}

/*
    Diseñe un programa que permita registrar las compras realizadas en una tienda, se debe mostrar al usuario
    con al menos 7 productos (se mostrara nombre del producto y precio); el ususario elegira el producto a comprar
    y luego la cantidad deseada, se debe soliciar al usuario confiracion de la compra y de ser afirmativo se guarda
    en un archivo la transaccion, conteniendo el nombre del producto, el precio, la cantidad y el importe total .

    ENTRADAS: 
            Nombre del producto
            cantidad
            Confirmación de la compra

    SALIDAS:
            Archivo con: nombre del producto, precio, cantidad e importe total
 */

        .data
    msjListaProd: .asciz "Productos en la lista\n1. Blusa para dama  -------------------> $07.99\n2. Jeans para caballero  --------------> $21.99\n3. Jeans para dama  -------------------> $19.99\n4. Zapatillas para niña  --------------> $24.69\n 5. Traje de baño VS  ------------------> $17.55\n6. Mochila Totto  -------------------- > $45.00\n7. Camisa Addidas para caballero ------> $35.67\n"
    msjPedirDato: .asciz "Que producto desea comprar. (Digite el numero del producto)\n"
    msjPedirCant: .asciz "Ingrese la cantidad del producto a adquirir: "
    msjSlida:     .asciz " El importe total es de :%f, %f, %f"
    fmtProducto:  .asciz "%d"
    fmtImporte:   .asciz "%f"
    producto:     .word 0
    cantidad:     .word 0
    precio1:      .single 7.99
    precio2:      .single 21.99
    precio3:      .single 12.99
    precio4:      .single 24.69
    precio5:      .single 17.55
    precio6:      .single 45.00
    precio7:      .single 35.67 
    importeFinal:  .single 0
        .text

        .global main

main: 
    PUSH {LR}
    VPUSH {S16-S31}

    LDR R0, =msjListaProd
    BL printf

    LDR R0, =msjPedirDato
    BL printf

    LDR R0, =fmtProducto
    LDR R1, =producto
    BL scanf

    LDR R0, =msjPedirCant
    BL printf

    LDR R0, =fmtProducto
    LDR R1, =cantidad
    BL scanf

    LDR R1, =producto
    LDR R1, [R1]
    LDR R2, =cantidad
    LDR R2, [R2]
    MOV R4, R1

    _if:
        CMP R1, #1
        BNE _else
    _then:
        MOV  R0, R2
        LDR  R1, =precio1
        VLDM R1, {S0-s1}
        VMOV S1, R0
        VMUL.F32 S1, S0, S1
        VMOV R0, S1
        BAL _endif
    _else:
        _if1:
            CMP R1, #2
            BNE _else1
        _then1:
            VLDM R1, {S0-S6}
            VMOV S1, R0
            VMUL.F32 S1, S0, S1
            VMOV R0, S1
            BAL _endif1
        _else1:
            _if2:
                CMP R1, #3
                BNE _else2
            _then2:
                MOV R0, R1
                BL proceso2
                BAL _endif2
            _else2:
                _if3:
                    CMP R1, #4
                    BNE _else3
                _then3:
                    MOV R0, R1
                    BL proceso3
                    BAL _endif3
                _else3:
                    _if4:
                        CMP R1, #5
                        BNE _else4
                    _then4:
                        MOV R0, R1
                        BL proceso4
                        BAL _endif4
                    _else4:
                        _if5:
                            CMP R1, #6
                            BNE _else5
                        _then5:
                            MOV R0, R1
                            BL proceso5
                            BAL _endif5
                        _else5:
                            MOV R0, R1
                            BL proceso6
                        _endif5:
                    _endif4:
                 _endif3:
            _endif2:
        _endif1:
    _endif:

    VMOV S0, R0
    VCVT.F64.F32 D0, S0
    VMOV R1, R2, D0
    LDR R0, =msjSlida
    BL printf

    VPOP {S16-S31}
    POP {PC}
_exit: 
    MOV R7, #1
    SWI 0
