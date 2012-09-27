From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Thu, 27 Sep 2012 19:54:25 +0200
Subject: [Cocci] Help with SmPL
In-Reply-To: <CAACXqO8GNr9cknk-K5E58JUhQd3r0is6mkX_kzSsjF=-qt9X1Q@mail.gmail.com>
References: <CA+MoWDpBor-e+69ioxPH-kWcdnd8iYE3E9aXjC79dNO+_COxeg@mail.gmail.com>
 <501BEA35.5030008@redhat.com> <501BFA96.6080803@metafoo.de>
 <alpine.DEB.2.02.1208031832490.2827@hadrien>
 <501C0878.1010906@metafoo.de>
 <alpine.DEB.2.02.1208032309470.1928@localhost6.localdomain6>
 <CA+MoWDrymuTRRiQXcN6OVmPacFXDE=6zZazG7peBPEGW_ZRk_w@mail.gmail.com>
 <CAACXqO8GNr9cknk-K5E58JUhQd3r0is6mkX_kzSsjF=-qt9X1Q@mail.gmail.com>
Message-ID: <CAACXqO-5vPQAuvDGFim2UOD=D6xJUy=X7Pcekgaoe93Bm8o4KQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 27 September 2012 18:30, H?kon L?vdal <hlovdal@gmail.com> wrote:
> On 27 September 2012 17:29, Peter Senna Tschudin <peter.senna@gmail.com> wrote:
>> 2 - Empty switch case / default, like on:
>> diff -u -p a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
>> b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
>> --- a/drivers/media/usb/dvb-usb/cinergyT2-fe.c
>> +++ b/drivers/media/usb/dvb-usb/cinergyT2-fe.c
>> @@ -60,7 +60,6 @@ static uint16_t compute_tps(struct dtv_f
>>         case FEC_1_2:
>>         case FEC_AUTO:
>>         default:
>> -               /* tps |= (0 << 7) */;
>>         }
>>
>> In this case, if the semicolon is removed, gcc complains:
>> drivers/media/usb/dvb-usb/cinergyT2-fe.c:62:2: error: label at end of
>> compound statement
>>
>> Any ideas?
>
> Gcc complains because it finds a label not followed by a statement
> (the removed semicolon served that role before).
> For this specific case I would remove the semicolon after the comment
> and then insert a break statement after, e.g.
>
>         case FEC_1_2:
>         case FEC_AUTO:
>         default:
>                 /* tps |= (0 << 7) */
>                 break;
>         }
>

I see now more what your problem is. I suspect that the trouble is
related to the labels
in front of default. When I test with the following source code


        void test(int i)
        {
                switch (i) {
                case 0:
                        /**/;
                default:
                        /**/;
                }

                switch (i) {
                case 0:
                        /**/;
                case 1:
                default:
                        /**/;
                }
        }

and the following coccinelle script


        @r_case_statement@
        statement S;
        position p;
        @@
        switch(...)
        {
        case ...: S;@p
        }


        @r_default_statement@
        statement S;
        position p;
        @@
        switch(...)
        {
        default: S;@p
        }


        @r_case_nostatement@
        position p1 != r_case_statement.p;
        @@
        switch(...)
        {
        *case ...: ...;@p1
        }


        @r_default_nostatement@
        position p1 != r_case_statement.p;
        @@
        switch(...)
        {
        *default: ...;@p1
        }

the output is


init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: main.c
diff =
        --- main.c
        +++ /tmp/cocci-output-3854-986c14-main.c
        @@ -2,15 +2,9 @@
         void test(int i)
         {
                 switch (i) {
        -        case 0:
        -                /**/;
        -        default:
        -                /**/;
                 }

                 switch (i) {
        -        case 0:
        -                /**/;
                 case 1:
                 default:
                         /**/;


Notice the missing match on the second default label. I do not know
what to change to make
coccinelle match this as well.

BR H?kon L?vdal
