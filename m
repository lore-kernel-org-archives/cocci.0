From: keescook@chromium.org (Kees Cook)
Date: Mon, 9 Jan 2017 14:02:17 -0800
Subject: [Cocci] [PATCH] coccicheck: add a test for repeat copy_from_user
In-Reply-To: <CAGXu5jLBcx_eOBSHnwOVdBKOaZ8TTN2u-n-=+dR4Pf06NAiBfQ@mail.gmail.com>
References: <20160426222442.GA8104@www.outflux.net>
 <alpine.DEB.2.20.1612271916250.2001@hadrien>
 <d0289ec5-3ce2-f119-6876-e19dc1a5ccde@oracle.com>
 <alpine.DEB.2.20.1701092008160.2029@hadrien>
 <CAGXu5jLBcx_eOBSHnwOVdBKOaZ8TTN2u-n-=+dR4Pf06NAiBfQ@mail.gmail.com>
Message-ID: <CAGXu5j+gxav6P1+Wxm-9PFLWqQQBym6eXOY3NoZr2EnZ4bn6Pw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jan 9, 2017 at 12:56 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jan 9, 2017 at 11:08 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>> On Mon, 9 Jan 2017, Vaishali Thakkar wrote:
>>
>>> Here, may be we should add few more lines from Pengfei's
>>> script to avoid th potential FPs.
>>
>> Which lines (I don't have it handy)?
>
> I'm going to compare
> https://github.com/wpengfei/double_fetch_cocci/blob/master/pattern_match_linux.cocci
> to my original one, add your improvements and see what I get...

Okay, I finally had time to look at this. Pengfei added two other
logical cases that should be checked for, IIUC:

1) destination alias checking (with assignment either before or after
the first copy_from_user):

struct thing object;
struct thing *pointer = &object;

copy_from_user(..., &object);
...
copy_from_user(..., pointer);

2) field writes (via . or ->, instead of short writes):

struct thing object;

copy_from_user(..., &object.field);
...
copy_from_user(..., &object);


It'd probably better to convert Pengfei's into being able to run under
the coccicheck target.

-Kees

-- 
Kees Cook
Nexus Security
