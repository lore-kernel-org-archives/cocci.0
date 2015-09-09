From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 15:55:55 +0100
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <55F046A3.4000004@users.sourceforge.net>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <alpine.DEB.2.10.1509091559330.2798@hadrien>
 <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
 <alpine.DEB.2.10.1509091617370.2798@hadrien>
 <CAB3z_RoqPMH3ZEwXHk-NHWt2qbLx3vv5bWcFY7eWuw0OqDOa0A@mail.gmail.com>
 <55F046A3.4000004@users.sourceforge.net>
Message-ID: <CAB3z_RqpjvcJnaEWcUi58Fp=S=W6=GUi_jb3wRrJKVZQojFmbA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 9 September 2015 at 15:48, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>> There is a comment section below, and the hunk removes the first /*
>> there instead.
>
> Does this generated update suggestion fit to your expectations?
>
> Would you like to express any preferences if specific comments should be
> deleted together with some source code or when such annotations should
> be preserved for a preprocessor statement?

I was surprised to see it happen, as I was not expecting it, however I think it
is a useful feature.

In the most part, the code blocks I am removing, if they are titled
with a comment,
would also want that comment to be removed.

(with the caveat that the comment is not attached to the end of
another statement as discovered)


In this particular instance, the fact that the alignment of the
comment being removed from below, is just something that happens in
patches from diff, and I think for me that is expected behaviour,
(Though if anyone knows how to stop it happening I'd be interested in
hearing) but I believe it is not an issue related to Coccinelle.

Regards

Kieran


>
> Regards,
> Markus
