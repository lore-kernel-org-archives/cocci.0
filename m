From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Thu, 27 Sep 2012 17:29:19 +0200
Subject: [Cocci] Help with SmPL
In-Reply-To: <alpine.DEB.2.02.1208032309470.1928@localhost6.localdomain6>
References: <CA+MoWDpBor-e+69ioxPH-kWcdnd8iYE3E9aXjC79dNO+_COxeg@mail.gmail.com>
 <501BEA35.5030008@redhat.com> <501BFA96.6080803@metafoo.de>
 <alpine.DEB.2.02.1208031832490.2827@hadrien>
 <501C0878.1010906@metafoo.de>
 <alpine.DEB.2.02.1208032309470.1928@localhost6.localdomain6>
Message-ID: <CA+MoWDrymuTRRiQXcN6OVmPacFXDE=6zZazG7peBPEGW_ZRk_w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This thread started on previous list...

I'm using the Cocci patch for finding unnecessary semicolons:
@r_case@
position p;
@@
switch (...)
{
case ...: ...;@p
}

@r_default@
position p;
@@
switch (...)
{
default: ...;@p
}

@r1@
statement S;
position p1;
position p != {r_case.p, r_default.p};
identifier label;
@@
(
label:;
|
S at p1;@p
)

@script:python r2@
p << r1.p;
p_case << r_case.p;
p1 << r1.p1;
@@
if p[0].line != p1[0].line_end:
        cocci.include_match(False)
@@
position r1.p;
@@
-;@p

I've identified two problems:

1 - Macros. It is very common to remove ";" after a call to a macro like on:

diff -u -p a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -2690,10 +2690,10 @@ isdn_tty_cmd_ATand(char **p, modem_info
                p[0]++;
                i = isdn_getnum(p);
                if ((i < 0) || (i > ISDN_SERIAL_XMIT_MAX))
-                       PARSE_ERROR1;
+                       PARSE_ERROR1

or

diff -u -p a/drivers/input/keyboard/sh_keysc.c
b/drivers/input/keyboard/sh_keysc.c
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -90,8 +90,8 @@ static irqreturn_t sh_keysc_isr(int irq,
        int keyout_nr = sh_keysc_mode[pdata->mode].keyout;
        int keyin_nr = sh_keysc_mode[pdata->mode].keyin;
        DECLARE_BITMAP(keys, SH_KEYSC_MAXKEYS);
-       DECLARE_BITMAP(keys0, SH_KEYSC_MAXKEYS);
-       DECLARE_BITMAP(keys1, SH_KEYSC_MAXKEYS);
+       DECLARE_BITMAP(keys0, SH_KEYSC_MAXKEYS)
+       DECLARE_BITMAP(keys1, SH_KEYSC_MAXKEYS)
        unsigned char keyin_set, tmp;
        int i, k, n;

2 - Empty switch case / default, like on:
diff -u -p a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
--- a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
+++ b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
@@ -60,7 +60,6 @@ static uint16_t compute_tps(struct dtv_f
        case FEC_1_2:
        case FEC_AUTO:
        default:
-               /* tps |= (0 << 7) */;
        }

In this case, if the semicolon is removed, gcc complains:
drivers/media/usb/dvb-usb/cinergyT2-fe.c:62:2: error: label at end of
compound statement

Any ideas?

Thanks,

Peter

On Fri, Aug 3, 2012 at 11:10 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Fri, 3 Aug 2012, Lars-Peter Clausen wrote:
>
>> On 08/03/2012 06:36 PM, Julia Lawall wrote:
>>>>
>>>> This one is a bit tricky, but it takes care of the case where cocci
>>>> can't
>>>> parse the statement inform of the semicolon.
>>>
>>>
>>> A simpler approach would be as follows:
>>>
>>>> @r1@
>>>> statement S;
>>>> position p;
>>>
>>>   position p1;
>>>>
>>>> @@
>>>> S
>>>
>>>
>>> change to S at p1
>>>
>>>> ;@p
>>>>
>>>> @script:python r2@
>>>> p << r1.p;
>>>> @@
>>>
>>>
>>> Change to call cocci.include_match(False) if p1[0].line_end != p[0].line
>>
>>
>> Hm, that's a good idea. But I guess it may produce false positives for
>> something like foo(); not_parseable(...);, but that's probably bad coding
>> style anyway.
>>
>> And this still leaves us with the false positives for case:; and default:;
>>
>> Maybe this could work:
>> @r_case@
>> position p;
>> @@
>> switch (...)
>> {
>> case ...: ...;@p
>> }
>
>
> I don't think you need the ... in front of the ;
>
> julia
>
>
>> @r_default@
>> position p;
>> @@
>> switch (...)
>> {
>> default: ...;@p
>> }
>>
>> @r1@
>> statement S;
>> position p1;
>> position p != {r_case.p, r_default.p};
>> identifier label;
>> @@
>> (
>> label:;
>> |
>> S at p1;@p
>> )
>>
>> @script:python r2@
>> p << r1.p;
>> p_case << r_case.p;
>> p1 << r1.p1;
>> @@
>> if p[0].line != p1[0].line_end:
>>         cocci.include_match(False)
>>
>> @@
>> position r1.p;
>> @@
>> -;@p
>>
> _______________________________________________
> Cocci mailing list
> Cocci at diku.dk
> http://lists.diku.dk/mailman/listinfo/cocci
> (Web access from inside DIKUs LAN only)



-- 
Peter
