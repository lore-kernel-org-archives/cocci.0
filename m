From: coenen@gmail.com (Martijn Coenen)
Date: Fri, 12 Jan 2018 20:10:46 +0100
Subject: [Cocci] Support for macro expansion
In-Reply-To: <alpine.DEB.2.20.1801121947510.3042@hadrien>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
 <alpine.DEB.2.20.1801121947510.3042@hadrien>
Message-ID: <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jan 12, 2018 at 7:50 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> Is it possible to parse the macro? That is, is the body a legal C
> statement or expression?

The macro I was looking at is module_usb_serial_driver():

https://elixir.free-electrons.com/linux/v4.15-rc7/source/include/linux/usb/serial.h#L433

The macro itself expands to another macro (maybe that is the
problem?), which expands to a few C function definitions. In this case
I was interested in seeing whether a file used the
"usb_serial_register_drivers()" function, which is called in one of
those function definitions.

Thanks,
Martijn

>
>
> Normally, macros are only unfolded when doing so is necessary to parse the
> context in which the macro occurs.  But when a macro is unfolded for that
> reason, it is not possible to transform the unfolded code, although it is
> possible to match it.
>
> It is indeed possible that the --preprocess argument does not do anything.
>
> julia
