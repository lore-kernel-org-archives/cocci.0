From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Apr 2014 20:39:21 +0200
Subject: [Cocci] semantic patch feasibility
In-Reply-To: <alpine.DEB.2.10.1404251823510.3323@hadrien>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>
 <535A7186.1020301@users.sourceforge.net>
 <alpine.DEB.2.10.1404251823510.3323@hadrien>
Message-ID: <CABxcv=ntuKOMDKP343vhaQG7Pk=8H5Z1+czki1QF4sZJvTubng@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Apr 25, 2014 at 6:24 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Fri, 25 Apr 2014, SF Markus Elfring wrote:
>
>> > I was wondering if the change I'm doing manually could be automated by
>> > using cocinelle but I've no experience neither writing semantic
>> > patches nor the SmPL language grammar.
>>
>> I would like to point out a general consideration.
>>
>> Semantic patches can be developed for some use cases. I find that
>> corresponding efforts are only useful if such a generalised patch can be
>> applied to a source code base several times.
>> I doubt that you want to try it out for a single source code adjustment.
>> It might be that a need will appear to perform a transformation once
>> more a bit later, doesn't it?
>
> I believe that he has hundreds of use cases.  The attached patch
> illustrated a number of them.
>
> julia

Exactly, there are much more drivers than the ones I already modified
in the attached patched. It was just to give you an example of the
level of complexity (or not) of the change I'm doing.

Best regards,
Javier
