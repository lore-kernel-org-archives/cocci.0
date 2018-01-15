From: coenen@gmail.com (Martijn Coenen)
Date: Mon, 15 Jan 2018 08:54:00 +0100
Subject: [Cocci] Support for macro expansion
In-Reply-To: <alpine.DEB.2.20.1801130744400.2203@hadrien>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
 <alpine.DEB.2.20.1801121947510.3042@hadrien>
 <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
 <alpine.DEB.2.20.1801130744400.2203@hadrien>
Message-ID: <CALt5rJsftLSZheqOuQ9J-y13HzM=pG9xj3f8mtROm_JCs3XVPQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Jan 13, 2018 at 7:46 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> declarer name module_usb_serial_driver;
>
> It doesn't make it ia metavariable, but rather gives some information
> about the name so that it will look for this name at top level.

Thanks, I'll give this a shot. But say I wanted to do this for any
random function in the linux kernel; in that case I would have to
manually declare all macros that contain any of those functions? In
other words, there's not really a way to write something that works
for any function (passed as a virtual to the .cocci)?

Thanks,
Martijn

>
> julia
>
>
>>
>> Thanks,
>> Martijn
>>
>> >
>> >
>> > Normally, macros are only unfolded when doing so is necessary to parse the
>> > context in which the macro occurs.  But when a macro is unfolded for that
>> > reason, it is not possible to transform the unfolded code, although it is
>> > possible to match it.
>> >
>> > It is indeed possible that the --preprocess argument does not do anything.
>> >
>> > julia
>>
