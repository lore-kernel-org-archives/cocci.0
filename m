From: joe.hershberger@gmail.com (Joe Hershberger)
Date: Mon, 8 Aug 2016 10:53:55 -0500
Subject: [Cocci] Bad formatting when changing function prototypes
In-Reply-To: <alpine.DEB.2.10.1608061236490.3433@hadrien>
References: <CANr=Z=bpk1DKiXODccy8Ru0QkP8EX0_v6BfVA2PvsOZ9gpiVXw@mail.gmail.com>
 <alpine.DEB.2.10.1608052249480.3315@hadrien>
 <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
 <alpine.DEB.2.10.1608061236490.3433@hadrien>
Message-ID: <CANr=Z=beMS-iN57j9z=kFvfTWV6fmwvddeSLfhppAfKAWPxd3A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On Sat, Aug 6, 2016 at 5:39 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> The problem should be fixed.  It's a little bit curious that you put
> newlines in the semantic patch that you don't want to see in the code.  In
> some cases, Coccinelle takes those newlines as hints for how to format the
> resulting code.

Ah, I didn't realize that there was any connection. I probably would
have been more likely to make that connection if all variables were on
separate lines (like my patch - done only for readability). That's
good to know.

> But now for parameter lists (and argument lists) it will
> never put a newline before the final ).

Great, thanks.

> The fix is available in github.  If you have any problem in compiling,
> with respect to python, do make distclean; ./autogen; ./configure before
> doing make.

Building worked fine, but the autotools errantly decided to built for
PCRE support even though I didn't have it installed. I think that's
new broken behavior since the 1.0.5 release

> Thanks for the report.

Thanks for fixing it!

Cheers,
-Joe
