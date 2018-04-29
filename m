From: Robert.Larice@t-online.de (Robert Larice)
Date: Sun, 29 Apr 2018 14:54:17 +0200
Subject: [Cocci] please help me with a "repetition"
In-Reply-To: <alpine.DEB.2.20.1804291328170.4211@hadrien> (Julia Lawall's
 message of "Sun, 29 Apr 2018 13:32:18 +0200 (CEST)")
References: <kkefiy2s6f.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291328170.4211@hadrien>
Message-ID: <kk604a2mx2.fsf@bora.foobar.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall <julia.lawall@lip6.fr> writes:

> On Sun, 29 Apr 2018, Robert Larice wrote:
>
>> Hello,
>>
>>   probably a stupid question,
>>   I'm failing to match something like this
>>
>> +  int newvar;
>>    i++; i++; ... any sequence of only "i++";
>> +  buckbear(42);
>>
>>   I don't succeed to express this "maximum length repetition"
>>     in the mids of those two insertions.
>
> It's not completely straightforward.  You could try:
>
> @r1@
> position p;
> @@
>
> ...

Thank You very much,

  your suggestion works perfectly well in my actual task.

  I was trying something different,
  very aproximately something like:
      ... when != i++;
    + int newvar;
      i++;
  and didn't get anywhere.

Thanks !
  Robert
