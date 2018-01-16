From: coenen@gmail.com (Martijn Coenen)
Date: Tue, 16 Jan 2018 09:33:35 +0100
Subject: [Cocci] Support for macro expansion
In-Reply-To: <alpine.DEB.2.20.1801151009580.3305@hadrien>
References: <CALt5rJt=t1iHb42+hMPEoxqV12EMt+jge2e5AXaASAFGzpt_Ew@mail.gmail.com>
 <alpine.DEB.2.20.1801121947510.3042@hadrien>
 <CALt5rJvkW=LLVxiVNocak_+q339SOpJy2WMmynswY2gOmxDNig@mail.gmail.com>
 <alpine.DEB.2.20.1801130744400.2203@hadrien>
 <CALt5rJsftLSZheqOuQ9J-y13HzM=pG9xj3f8mtROm_JCs3XVPQ@mail.gmail.com>
 <alpine.DEB.2.20.1801151009580.3305@hadrien>
Message-ID: <CALt5rJsLOGmqmoUOj6MFQ+=yK38qXTvZNEpxmC8LwV4ggwUqxA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jan 15, 2018 at 10:14 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> The idea is that generally it is beneficial to reason about
> the code in the way that you see it, ie with the macro calls in the code
> as they are.

Yes, I think that makes sense - what I'm trying to do is sort of an
edge case. Thanks for your help.

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
>> > julia
>> >
>> >
>> >>
>> >> Thanks,
>> >> Martijn
>> >>
>> >> >
>> >> >
>> >> > Normally, macros are only unfolded when doing so is necessary to parse the
>> >> > context in which the macro occurs.  But when a macro is unfolded for that
>> >> > reason, it is not possible to transform the unfolded code, although it is
>> >> > possible to match it.
>> >> >
>> >> > It is indeed possible that the --preprocess argument does not do anything.
>> >> >
>> >> > julia
>> >>
>>
