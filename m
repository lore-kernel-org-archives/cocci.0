From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Aug 2017 15:20:58 +0200
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <alpine.DEB.2.20.1708251509060.3191@hadrien>
References: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
 <8ee5f080-2b21-565a-cc6b-e49ba7b1e73f@users.sourceforge.net>
 <alpine.DEB.2.20.1708251353440.3191@hadrien>
 <abc618f6-8de2-95e2-7c57-b495f9704866@users.sourceforge.net>
 <alpine.DEB.2.20.1708251509060.3191@hadrien>
Message-ID: <b3a551cf-fceb-5d0a-22ba-f8901f8a8ebf@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> (
>> *setup_timer(&E->_timer at tl, \((_func)\| \) \(&\| \) _callback, \((_data)\| \) E);
>> |
>> *E->_timer at tl.function = \((_func)\| \) \(&\| \) _callback;
>> )
> 
> No, it doesn't work, because \( \| \) matches an expression and there is
> no empty expression.

Will the Coccinelle software become able to generate the desired combination
of casts and address-of operators anyhow automatically?

Can the usage of optional items be expressed in a more convenient way here?

Regards,
Markus
