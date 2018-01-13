From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 13 Jan 2018 07:46:09 +0100 (CET)
Subject: [Cocci] Support for macro expansion
In-Reply-To: <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
 <alpine.DEB.2.20.1801121947510.3042@hadrien>
 <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1801130744400.2203@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 Jan 2018, Martijn Coenen wrote:

> On Fri, Jan 12, 2018 at 7:50 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > Is it possible to parse the macro? That is, is the body a legal C
> > statement or expression?
>
> The macro I was looking at is module_usb_serial_driver():
>
> https://elixir.free-electrons.com/linux/v4.15-rc7/source/include/linux/usb/serial.h#L433
>
> The macro itself expands to another macro (maybe that is the
> problem?), which expands to a few C function definitions. In this case
> I was interested in seeing whether a file used the
> "usb_serial_register_drivers()" function, which is called in one of
> those function definitions.

The easiest thing would be to just extend your semantic patch to look for
uses of module_usb_serial_driver.  module_usb_serial_driver however is
called outside of any function.  So you need to make a declaration among
the metavariables:

declarer name module_usb_serial_driver;

It doesn't make it ia metavariable, but rather gives some information
about the name so that it will look for this name at top level.

julia


>
> Thanks,
> Martijn
>
> >
> >
> > Normally, macros are only unfolded when doing so is necessary to parse the
> > context in which the macro occurs.  But when a macro is unfolded for that
> > reason, it is not possible to transform the unfolded code, although it is
> > possible to match it.
> >
> > It is indeed possible that the --preprocess argument does not do anything.
> >
> > julia
>
