From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Jan 2018 10:14:58 +0100 (CET)
Subject: [Cocci] Support for macro expansion
In-Reply-To: <CALt5rJsftLSZheqOuQ9J-y13HzM=pG9xj3f8mtROm_JCs3XVPQ@mail.gmail.com>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
 <alpine.DEB.2.20.1801121947510.3042@hadrien>
 <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
 <alpine.DEB.2.20.1801130744400.2203@hadrien>
 <CALt5rJsftLSZheqOuQ9J-y13HzM=pG9xj3f8mtROm_JCs3XVPQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1801151009580.3305@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Jan 2018, Martijn Coenen wrote:

> On Sat, Jan 13, 2018 at 7:46 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > declarer name module_usb_serial_driver;
> >
> > It doesn't make it ia metavariable, but rather gives some information
> > about the name so that it will look for this name at top level.
>
> Thanks, I'll give this a shot. But say I wanted to do this for any
> random function in the linux kernel; in that case I would have to
> manually declare all macros that contain any of those functions? In
> other words, there's not really a way to write something that works
> for any function (passed as a virtual to the .cocci)?

My impression is that the problem arises only rarely.

It's hard for Coccinelle to know what macros you want to be expanded.
Also Coccinelle doesn't necessarily have access to the definitions of the
macros, unless you use eg --recursive-includes, which will massively
increase the amount of code to process and correspondingly degrade the
performance.  The idea is that generally it is beneficial to reason about
the code in the way that you see it, ie with the macro calls in the code
as they are.

julia


>
> Thanks,
> Martijn
>
> >
> > julia
> >
> >
> >>
> >> Thanks,
> >> Martijn
> >>
> >> >
> >> >
> >> > Normally, macros are only unfolded when doing so is necessary to parse the
> >> > context in which the macro occurs.  But when a macro is unfolded for that
> >> > reason, it is not possible to transform the unfolded code, although it is
> >> > possible to match it.
> >> >
> >> > It is indeed possible that the --preprocess argument does not do anything.
> >> >
> >> > julia
> >>
>
