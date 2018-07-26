From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 14:34:38 -0500
Subject: [Cocci] Variable number of macro parameters?
In-Reply-To: <alpine.DEB.2.20.1807262057300.2308@hadrien>
References: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
 <alpine.DEB.2.20.1807262057300.2308@hadrien>
Message-ID: <CAOZdJXUUWuy6mMPaTUPJwV=Oa5TznaqWZJb1EDMMSiO+bYoSSQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 26, 2018 at 1:57 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> @rule1@
>> expression x, y;
>> @@
>> -DBG_PRINTF((x, y));
>> +NV_PRINTF(y);
>
> Try expression list y;

You mean like this:

@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF((x, y));
+NV_PRINTF(y);

That gives me an error:

$ spatch -sp_file ~/sw/dev/gpu_drv/chips_a/nv_printf.cocci osinit.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
60 61
Fatal error: exception Failure("minus: parse error: \n = File
\"/home/ttabi/sw/dev/gpu_drv/chips_a/nv_printf.cocci\", line 5, column
16,  charpos = 60\n    around = 'y', whole content = -DBG_PRINTF((x,
y));\n")

I also tried this, but it gave me a different error:

@rule1@
expression x;
expression list y;
@@
-DBG_PRINTF(
-(x,
+NV_PRINTF(
 y
-)
 );

Fatal error: exception Failure("minus: parse error: \n = File
\"/home/ttabi/sw/dev/gpu_drv/chips_a/nv_printf.cocci\", line 8, column
1,  charpos = 75\n    around = 'y', whole content =  y\n")
