From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 6 Aug 2016 12:39:19 +0200 (CEST)
Subject: [Cocci] Bad formatting when changing function prototypes
In-Reply-To: <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
References: <CANr=Z=bpk1DKiXODccy8Ru0QkP8EX0_v6BfVA2PvsOZ9gpiVXw@mail.gmail.com>
 <alpine.DEB.2.10.1608052249480.3315@hadrien>
 <CANr=Z=Zeg_fO7m9uDzK1HgV3i0QuQNt5dppr+mggRZ1sjXE8Bw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1608061236490.3433@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The problem should be fixed.  It's a little bit curious that you put
newlines in the semantic patch that you don't want to see in the code.  In
some cases, Coccinelle takes those newlines as hints for how to format the
resulting code.  But now for parameter lists (and argument lists) it will
never put a newline before the final ).

The fix is available in github.  If you have any problem in compiling,
with respect to python, do make distclean; ./autogen; ./configure before
doing make.

Thanks for the report.

julia
