From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 15:28:49 +0100
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <alpine.DEB.2.10.1509091617370.2798@hadrien>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <alpine.DEB.2.10.1509091559330.2798@hadrien>
 <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
 <alpine.DEB.2.10.1509091617370.2798@hadrien>
Message-ID: <CAB3z_RoqPMH3ZEwXHk-NHWt2qbLx3vv5bWcFY7eWuw0OqDOa0A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,


>>
>> Ahh yes, I see this here! (Actually sounds like a reasonable thing to do!)
>> @@ -207,37 +207,6 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
>> max6659, adt7461, max6680,
>>  #define MAX6696_STATUS2_LOT2   (1 << 7) /* local emergency limit tripped */
>>
>>  /*
>
> Is there really no - here?

Now that's a keen eye you have!

Yes - that is correct, but fear not ... its my fault for cropping the hunk.

There is a comment section below, and the hunk removes the first /*
there instead.


Full hunk below: I'll try not to 'cut corners' when pasting next time :)


diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index c9ff08d..5b76055 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -207,37 +207,6 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
max6659, adt7461, max6680,
 #define MAX6696_STATUS2_LOT2   (1 << 7) /* local emergency limit tripped */

 /*
- * Driver data (common to all clients)
- */
-
-static const struct i2c_device_id lm90_id[] = {
-       { "adm1032", adm1032 },
-       { "adt7461", adt7461 },
-       { "adt7461a", adt7461 },
-       { "g781", g781 },
-       { "lm90", lm90 },
-       { "lm86", lm86 },
-       { "lm89", lm86 },
-       { "lm99", lm99 },
-       { "max6646", max6646 },
-       { "max6647", max6646 },
-       { "max6649", max6646 },
-       { "max6657", max6657 },
-       { "max6658", max6657 },
-       { "max6659", max6659 },
-       { "max6680", max6680 },
-       { "max6681", max6680 },
-       { "max6695", max6696 },
-       { "max6696", max6696 },
-       { "nct1008", adt7461 },
-       { "w83l771", w83l771 },
-       { "sa56004", sa56004 },
-       { "tmp451", tmp451 },
-       { }
-};
-MODULE_DEVICE_TABLE(i2c, lm90_id);
-
-/*
  * chip type specific parameters
  */
 struct lm90_params {



--
Regards

Kieran


>
> julia
>
>> - * Driver data (common to all clients)
>> - */
>> -
>> -static const struct i2c_device_id lm90_id[] = {
>> -       { "adm1032", adm1032 },
>> -       { "adt7461", adt7461 },
>> -       { "adt7461a", adt7461 },
>> -       { "g781", g781 },
>>
>>
>>
>>
>>
>>
>> > It would need to observe that the comment does not start at the beginning
>> > of the line, and treat it differntly.  Just to check, are you using
>> > Coccinelle 1.0.2?  I made a change in this regard recently, but I'm not
>> > sure it was an overall improvement.
>>
>> No - I'm afraid I'm using the version shipped with ubuntu 15.04:
>>
>> spatch --version
>> spatch version 1.0.0-rc22 with Python support and with PCRE support
>>
>>
>> --
>> Regards
>>
>> Kieran
>>
>> >
>> > julia
>>
