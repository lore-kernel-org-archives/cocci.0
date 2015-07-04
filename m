From: skunk@iSKUNK.ORG (Daniel Richard G.)
Date: Sat, 04 Jul 2015 04:13:38 -0400
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <CAGbDTvr6DpQzjYktmTjBTYWGZYxNPBWtuW1qf5nFjCBzKxQ6Cw@mail.gmail.com>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506240934280.2553@hadrien>
 <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
 <CAGbDTvr6DpQzjYktmTjBTYWGZYxNPBWtuW1qf5nFjCBzKxQ6Cw@mail.gmail.com>
Message-ID: <1435997618.363960.314982145.35E4A6A9@webmail.messagingengine.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Iago,

Apologies for the delay---my employer shifted me to some more urgent
work for the past few days.

On Fri, 2015 Jun 26 14:50+0200, Iago Abal wrote:
> Hi Daniel,
>
> Try passing --undefined WIN32 to spatch, this should work for you.
> Analogously, you can use --defined <SYMBOL>. This evaluates the
> condition of an #ifdef or #ifndef, and may convert them into #if 1 or
> #if 0. For #if , Coccinelle has an option --if0-passing (enabled by
> default) that will ignore code under #if 0. The only constraint is
> that the code under the #if  must still be lexically valid C code,
> because --if0-passing works after lexing.

Yep, that appears to do the trick :)

This works pretty well, as I can also specify e.g. "--defined COCCI" and
then use "#ifndef COCCI" to hide tricky segments of code from
Coccinelle---not unlike the magic-comment strings but in a form more
recognizable to other developers.

(I had noticed the "#if 0" behavior previously, but something else was
needed if I still wanted regular C compilers to see the code.)

I had seen --(un)defined in the "spatch --help" output, but without any
description:

  --defined
  --undefined

Julia, may I suggest the following text for these?

  --defined      <symbol> treat cpp symbol as defined in #ifdef
  --undefined    <symbol> treat cpp symbol as undefined in #ifdef

If this minimal documentation had been in place, I might have been able
to discover this functionality on my own.

Iago, thank you again for filling me in!


--Daniel


-- 
Daniel Richard G. || skunk at iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
