From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 14:33:43 +0100
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <55F02297.6070503@users.sourceforge.net>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <55F02297.6070503@users.sourceforge.net>
Message-ID: <CAB3z_RqRF3t8UvJPUOugDst=i-gM4N3sbcx7zO4wwx6Bjcz5Cg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Markus,

On 9 September 2015 at 13:14, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> Reviewing the changes made by my s-patch, I've come across the following hunk :
>
> How do you think about to show your semantic patch script here?

My apologies, I should have considered that!
This is actually my second thread to the list today - the first is
still held in moderation I think. (posted before I joined the list)

The full patch was referenced in the first thread, so in my head was
just continuing as if there was context which I appreciate there isn't
:)

Full patch on viewable here:
https://gist.github.com/kbingham/96477177dd20a72b1c2f


The relevant segment of the patch is:
============================================================
// Remove the i2c_device_id array

@ dev_id depends on of_dev_id_present @
identifier arr;
@@
- struct i2c_device_id arr[] = { ... };


// Now remove the MODULE_DEVICE_TABLE entry
@ depends on dev_id @
declarer name MODULE_DEVICE_TABLE;
identifier i2c;
identifier dev_id.arr;
@@
- MODULE_DEVICE_TABLE(i2c, arr);
============================================================


>> +++ b/drivers/hwmon/jc42.c
>> ...
>> @@ -529,13 +529,7 @@ static const struct dev_pm_ops jc42_dev_pm_ops = {
>>  #define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
>>  #else
>>  #define JC42_DEV_PM_OPS NULL
>> -#endif /* CONFIG_PM */
>> -
>> -static const struct i2c_device_id jc42_id[] = {
>> -       { "jc42", 0 },
>> -       { }
>> -};
>> -MODULE_DEVICE_TABLE(i2c, jc42_id);
>> +#endif
>>
>>  static struct i2c_driver jc42_driver = {
>>         .class          = I2C_CLASS_SPD,
>> ============================================================
>>
>> Is this removal of the /* CONFIG_PM */ expected behaviour?
>
> I would interpret the shown changes in the way that a preprocessor
> statement "#endif" is repositioned after a variable initialisation which
> was not a part for conditional compilation is deleted. I find such a
> detail also strange.
>
>
>> I guess under the hood, Coccinelle is stripping comments from code to
>> make parsing possible/easier?
>
> This software is tackling some challenges to preserve comments for
> various source code places.

Having only got started with Coccinelle yesterday, I find it
fascinating how well it performs.
Its a marvellous tool, and I wish I had taken the energy to start
using it long before now!

> Regards,
> Markus

Regards

Kieran
