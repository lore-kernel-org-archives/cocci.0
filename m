From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 4 Dec 2015 16:36:53 +0000
Subject: [Cocci] Using Coccinelle to add #include lines
In-Reply-To: <alpine.DEB.2.10.1512041713520.2768@hadrien>
References: <CAFEAcA-HKiMsz36SbfaGN3Oaz3Jn_h+f8McaHo48zmsngJtyRg@mail.gmail.com>
 <alpine.DEB.2.10.1512041701250.2768@hadrien>
 <CAFEAcA-PnYAapj3tc5CiD4r5UROcbrO0x2=7xGTv+XqCjXWFKg@mail.gmail.com>
 <alpine.DEB.2.10.1512041713520.2768@hadrien>
Message-ID: <CAFEAcA9PwmunJrqYu1rUw35_a3Wdq8p6=SkcPcj0+s_Bi4fayA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 4 December 2015 at 16:16, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> Hmm. Maybe I'm better off just using sed or perl for this job?
>> #include lines are really pretty much line-based after all.
>
> If you have a good solution for getting the first include with sed or
> perl, I think it would be better to do that.  Coccinelle is designed to be
> independent of the position of top-level entities in the file, so it is
> not very convenient to make it sensitive to that.

OK. I think I'll use coccinelle to add the new #includes and then
perl to remove the duplicates. The removal is a perl one-liner:
perl -n -i -e 'print if !/#include "qemu\/osdep.h"/ || !$n++;' foo.c

Thanks for your help.

-- PMM
