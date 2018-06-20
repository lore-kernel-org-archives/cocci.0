From: joe@perches.com (Joe Perches)
Date: Wed, 20 Jun 2018 11:25:08 -0700
Subject: [Cocci] [PATCH v2 2/2] hwmon: npcm750: add NPCM7xx PWM and Fan
	driver
In-Reply-To: <20180620164853.GA3459@roeck-us.net>
References: <20180619105352.97181-1-tmaimon77@gmail.com>
 <20180619105352.97181-3-tmaimon77@gmail.com>
 <20180620164853.GA3459@roeck-us.net>
Message-ID: <a6a5a21236c37cfc63329e54248d941bf6d49e3c.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

(adding Julia Lawall and cocci mailing list)

On Wed, 2018-06-20 at 09:48 -0700, Guenter Roeck wrote:
[]
> > +static inline void npcm7xx_fan_start_capture(struct npcm7xx_pwm_fan_data *data,
> > +						 u8 fan, u8 cmp)
> > +{
> > +	u8 fan_id = 0;
> > +	u8 reg_mode = 0;
> > +	u8 reg_int = 0;
> > +	unsigned long flags;
> > +
> > +	fan_id = NPCM7XX_FAN_INPUT(fan, cmp);
> > +
> > +	/* to check whether any fan tach is enable */
> > +	if (data->npcm7xx_fan[fan_id].FanStFlag != FAN_DISABLE) {
> > +		/* reset status */
> > +		spin_lock_irqsave(&data->npcm7xx_fan_lock[fan], flags);
> > +
> > +		data->npcm7xx_fan[fan_id].FanStFlag = FAN_INIT;
> > +		reg_int = ioread8(NPCM7XX_FAN_REG_TIEN(data->fan_base, fan));
> > +
> > +		if (cmp == NPCM7XX_FAN_CMPA) {
> > +			/* enable interrupt */
> > +			iowrite8((u8) (reg_int | (NPCM7XX_FAN_TIEN_TAIEN |
> > +						  NPCM7XX_FAN_TIEN_TEIEN)),
> 
> Is the (u8) typecast really necessary ? Seems unlikely.

The cast is not really necessary here as there would
be an implicit cast already.

Some might complain about loss of type safety and
"make W=123" would probably emit something here.

But casts to the same type are not necessary.

A possible coccinelle script to find casts to the
same type is below, but there are some false positives
for things like __force and __user casts

Also, spatch (1.0.4) seems to have a defect for this
when the type is used in operations that change a
smaller type to int or unsigned int.

i.e.: (offset is u16, but offset * 2 is int)

While running the cocci script below:

HANDLING: drivers/net/ethernet/intel/igb/e1000_nvm.c
diff = 
diff -u -p a/drivers/net/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -335,7 +335,7 @@ s32 igb_read_nvm_spi(struct e1000_hw *hw
 
 	/* Send the READ command (opcode + addr) */
 	igb_shift_out_eec_bits(hw, read_opcode, nvm->opcode_bits);
-	igb_shift_out_eec_bits(hw, (u16)(offset*2), nvm->address_bits);
+	igb_shift_out_eec_bits(hw, (offset * 2), nvm->address_bits);
 
 	/* Read the data.  SPI NVMs increment the address with each byte
 	 * read and will roll over if reading beyond the end.  This allows

---

Anyway, here's the cocci script:

$ cat same_typecast.cocci
@@
type T;
T foo;
@@

-	(T *)&foo
+	&foo

@@
type T;
T foo;
@@

-	(T)foo
+	foo
