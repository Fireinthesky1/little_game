	.segment "HEADER"
	.byte $4E, $45, $53, $1A ;'N' 'E' 'S' '<EOF>'
	.byte 2			; 2x 16 kb prg data
	.byte 1			; 1x 8kb chr data
	.byte $01		; vert mirroring, no batry, no trainer, no alt nametables, mapper 0
	.byte $08		; NES 2.0, Nintendo Entertainment System
	.byte $00		; mapper 000, submapper number 0

	.segment "VECTORS"
	.addr nmi		;.addr defines word sized data alias for .word a word is two bytes?
	.addr reset
	.addr 0			; not using the IRQ

RESET:
	sei			; sets the interrupt flag (disables maskable interrupts: IRQ)
	cld			; clears decimal flag; no arithmetic in packed binary coded decimal
	ldx #$40
	stx $4017		; this sets the irq inhibit flag for the audio processing unit
	ldx #FF			; set up stack
	inx			; now x is zero
	stx $2000		; disable generation of NMI at start of verticle blanking
	stx $2001		; $00 disables all rendering
	stx $4010		; disables DMC IRQs

	;; the vblank flag is in an unknown state after reset,
	;; so it is cleared here to make sure that @vblankwait1
	;; does not exit immediately
	bit $2002		; reading status register clears bit 7 (1 if vblank has started)
	;; first of two waits for verticle blank to make sure that
	;; the ppu has stabilized
@vblankwait1:
	bit $2002
	bpl @vblankwait1	; branch on N of status register == 0
				; We now have about 30,000 cycles to burn before the PPU stabilizes.
				; One thing we can do with this time is put RAM in a known state.
				; Here we fill it with $00, which matches what (say) a C compiler
				; expects for BSS.  Conveniently, X is still 0.
	txa
@clrmem:
	sta $0000,x
	sta $0100,x
	sta $0200,x
	sta $0300,x
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	inx
	bne @clrmem

    ; Other things you can do between vblank waits are set up audio
    ; or set up other mapper registers.

@vblankwait2:
	bit $2002
	bpl @vblankwait2


	.segment "CODE"
