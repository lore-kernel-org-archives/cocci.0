From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 8 Mar 2016 11:26:29 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <CAGbDTvr_nmt-SVtvYtvOM9tcsUvh_tdg0i=+R1QDLck0G9uctg@mail.gmail.com>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <CAO=9Y+0KUsrK4OpR9YrNpp5JJ2tDDoY-DOq0xfDBcY8GdKWwCQ@mail.gmail.com>
 <56DDDCB7.5060206@users.sourceforge.net>
 <CAGbDTvr_nmt-SVtvYtvOM9tcsUvh_tdg0i=+R1QDLck0G9uctg@mail.gmail.com>
Message-ID: <56DEA8D5.6070902@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> If you are talking about using Coccinelle as a bug finder,
> and empower it with alias analysis,

I am also curious on how such technologies will fit together.


> then I have spent about a year working on a similar idea.

How similar was this approach?


> I am available to discuss my experience with you,

Nice ?


> if you want.

Yes, please.


> I don't know exactly in what direction you want to "improve" Coccinelle results,
> but let me warn you that in principle alias analysis may just give you
> a lot more false positives.

Do you need also a special software infrastructure to reduce the probability
for the undesired reporting of false positives?


> Sometimes, in functions with complex manipulation of pointers,
> I find that alias analysis hurts more than it helps.

Interesting view ?


> That said, I think advanced Coccinelle users could make good use
> of aliasing information.

How would these data be integrated for the use in SmPL scripts?

Regards,
Markus
