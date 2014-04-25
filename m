From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Apr 2014 20:50:18 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <alpine.DEB.2.10.1404252000560.2692@hadrien>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <alpine.DEB.2.10.1404251823510.3323@hadrien>
 <535A8DEF.6070806@users.sourceforge.net>
 <alpine.DEB.2.10.1404252000560.2692@hadrien>
Message-ID: <CABxcv=kpLyPX3ky2GMfPk9WtnmDTUxkKxpkg9Q68vb60WtUzUA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

On Fri, Apr 25, 2014 at 8:03 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Fri, 25 Apr 2014, SF Markus Elfring wrote:
>
>> > The attached patch illustrated a number of them.
>>
>> How do you see the chances for generalisation of this concrete example?
>
> I think it should be quite straightforward.  One either takes the
> assignments out of the function and puts them into a structure
> initializer, or if there is a structure initializer already, one cuts it
> up into what is wanted for each of the separate functions.
>
> Maybe creating the name of the new structure is an issue?  I didn't look
> carefully enough to see if there was a pattern.
>
> julia

I'm glad to know that should be straightforward. To name the new
structure I've been trying to deduce the naming scheme that the
original driver author used to name the GPIO operations and following
that convention.

But if for the sake of simplicity we use a standard name that will be
used on all drivers, that's ok too. After all the structures are
static and later drivers maintainers can rename the structure if they
want a more suitable name.

Thanks a lot to Markus and you for the feedback. Now that I know that
is possible, I'll study the SmPL grammar, look at the examples and ask
silly questions here if I find issues :-)

Best regards,
Javier
