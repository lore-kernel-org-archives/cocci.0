From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 25 May 2016 14:01:38 -0700
Subject: [Cocci] new revision in github
In-Reply-To: <alpine.DEB.2.10.1605252157340.3041@hadrien>
References: <alpine.DEB.2.10.1605250948390.4766@hadrien>
 <20160525164027.GE11948@wotan.suse.de>
 <alpine.DEB.2.10.1605252157340.3041@hadrien>
Message-ID: <CAB=NE6UBYU55LrG8E=VNWk8PJ2hOY0YAkKMiCozEgVNC_mGxgA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, May 25, 2016 at 1:01 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Wed, 25 May 2016, Luis R. Rodriguez wrote:
>
>> On Wed, May 25, 2016 at 09:50:14AM +0200, Julia Lawall wrote:
>> > Thenks to those who have given feedback on the previous
>> > push to github.  We have tried to address these concerns and a new
>> > revision is available.
>>
>> Should ./configure fail on ocaml < 4.03 ? It currently does not.
>
> I don't understand the question.  You want it to fail on a version less
> than 4.03?  Or you mean that it does and previously it did not?

Sorry I thought 4.03 was required, its not.

> I have 4.01, and configure works fine.

FWIW, I was on 4.01 and I tried again had the same pcre symbol issue.
I upgraded to ocaml 4.02 and it now compiles fine.

  Luis
