;
; File generated by cc65 v 2.16 - Git f5e9b40
;
	.fopt		compiler,"cc65 v 2.16 - Git f5e9b40"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.import		_pal_col
	.import		_ppu_on_all
	.import		_ppu_system
	.import		_vram_adr
	.import		_vram_put
	.export		_put_str
	.export		_main

.segment	"RODATA"

L0047:
	.byte	$59,$4F,$55,$27,$44,$20,$4E,$45,$45,$44,$20,$41,$20,$43,$55,$53
	.byte	$54,$4F,$4D,$20,$45,$4E,$43,$4F,$44,$49,$4E,$47,$00
L002C:
	.byte	$55,$53,$49,$4E,$47,$20,$41,$53,$43,$49,$49,$2D,$45,$4E,$43,$4F
	.byte	$44,$45,$44,$20,$43,$48,$41,$52,$53,$45,$54,$00
L0035:
	.byte	$28,$57,$49,$54,$48,$20,$43,$41,$50,$49,$54,$41,$4C,$20,$4C,$45
	.byte	$54,$54,$45,$52,$53,$20,$4F,$4E,$4C,$59,$29,$00
L003E:
	.byte	$54,$4F,$20,$55,$53,$45,$20,$43,$48,$52,$20,$4D,$4F,$52,$45,$20
	.byte	$45,$46,$46,$49,$43,$49,$45,$4E,$54,$4C,$59,$00
L0023:
	.byte	$54,$48,$49,$53,$20,$43,$4F,$44,$45,$20,$50,$52,$49,$4E,$54,$53
	.byte	$20,$53,$4F,$4D,$45,$20,$54,$45,$58,$54,$00
L0050:
	.byte	$41,$4E,$44,$20,$41,$20,$43,$4F,$4E,$56,$45,$52,$53,$49,$4F,$4E
	.byte	$20,$54,$41,$42,$4C,$45,$00
L0059:
	.byte	$43,$55,$52,$52,$45,$4E,$54,$20,$56,$49,$44,$45,$4F,$20,$4D,$4F
	.byte	$44,$45,$20,$49,$53,$00
L001A:
	.byte	$48,$45,$4C,$4C,$4F,$2C,$20,$57,$4F,$52,$4C,$44,$21,$00
L0065:
	.byte	$4E,$54,$53,$43,$00
L0068:
	.byte	$50,$41,$4C,$00

; ---------------------------------------------------------------
; void __near__ put_str (unsigned int, __near__ const unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_put_str: near

.segment	"CODE"

;
; {
;
	jsr     pushax
;
; vram_adr(adr);
;
	ldy     #$03
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	jsr     _vram_adr
;
; if(!*str) break;
;
L0004:	ldy     #$01
	lda     (sp),y
	sta     ptr1+1
	dey
	lda     (sp),y
	sta     ptr1
	lda     (ptr1),y
	beq     L0005
;
; vram_put((*str++)-0x20);//-0x20 because ASCII code 0x20 is placed in tile 0 of the CHR
;
	iny
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	sta     regsave
	stx     regsave+1
	clc
	adc     #$01
	bcc     L000D
	inx
L000D:	jsr     stax0sp
	ldy     #$00
	lda     (regsave),y
	sec
	sbc     #$20
	jsr     _vram_put
;
; while(1)
;
	jmp     L0004
;
; }
;
L0005:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; pal_col(1,0x30);//set while color
;
	jsr     decsp1
	lda     #$01
	jsr     pusha
	lda     #$30
	jsr     _pal_col
;
; put_str(NTADR_A(2,2),"HELLO, WORLD!");
;
	ldx     #$20
	lda     #$42
	jsr     pushax
	lda     #<(L001A)
	ldx     #>(L001A)
	jsr     _put_str
;
; put_str(NTADR_A(2,6),"THIS CODE PRINTS SOME TEXT");
;
	ldx     #$20
	lda     #$C2
	jsr     pushax
	lda     #<(L0023)
	ldx     #>(L0023)
	jsr     _put_str
;
; put_str(NTADR_A(2,7),"USING ASCII-ENCODED CHARSET");
;
	ldx     #$20
	lda     #$E2
	jsr     pushax
	lda     #<(L002C)
	ldx     #>(L002C)
	jsr     _put_str
;
; put_str(NTADR_A(2,8),"(WITH CAPITAL LETTERS ONLY)");
;
	ldx     #$21
	lda     #$02
	jsr     pushax
	lda     #<(L0035)
	ldx     #>(L0035)
	jsr     _put_str
;
; put_str(NTADR_A(2,10),"TO USE CHR MORE EFFICIENTLY");
;
	ldx     #$21
	lda     #$42
	jsr     pushax
	lda     #<(L003E)
	ldx     #>(L003E)
	jsr     _put_str
;
; put_str(NTADR_A(2,11),"YOU'D NEED A CUSTOM ENCODING");
;
	ldx     #$21
	lda     #$62
	jsr     pushax
	lda     #<(L0047)
	ldx     #>(L0047)
	jsr     _put_str
;
; put_str(NTADR_A(2,12),"AND A CONVERSION TABLE");
;
	ldx     #$21
	lda     #$82
	jsr     pushax
	lda     #<(L0050)
	ldx     #>(L0050)
	jsr     _put_str
;
; put_str(NTADR_A(2,16),"CURRENT VIDEO MODE IS");
;
	ldx     #$22
	lda     #$02
	jsr     pushax
	lda     #<(L0059)
	ldx     #>(L0059)
	jsr     _put_str
;
; video_mode = ppu_system();
;
	jsr     _ppu_system
	ldy     #$00
	sta     (sp),y
;
; put_str(NTADR_A(24,16), video_mode > 0 ? "NTSC" : "PAL");
;
	ldx     #$22
	lda     #$18
	jsr     pushax
	ldy     #$02
	lda     (sp),y
	beq     L0066
	lda     #<(L0065)
	ldx     #>(L0065)
	jmp     L0069
L0066:	lda     #<(L0068)
	ldx     #>(L0068)
L0069:	jsr     _put_str
;
; ppu_on_all();//enable rendering
;
	jsr     _ppu_on_all
;
; while(1);//do nothing, infinite loop
;
L0070:	jmp     L0070

.endproc
