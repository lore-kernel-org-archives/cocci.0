From: mmarek@suse.cz (Michal Marek)
Date: Wed, 12 Aug 2015 17:05:16 +0200
Subject: [Cocci] [RFC] coccinelle: add style check for assignment in if
In-Reply-To: <CAMy_N63pADkvb4vP=1ReMPpmR7e32TmEE91hELKXTsYnPP+GZA@mail.gmail.com>
References: <1439387500-11183-1-git-send-email-kborer@gmail.com>
 <55CB543A.70007@suse.cz>
 <CAMy_N63pADkvb4vP=1ReMPpmR7e32TmEE91hELKXTsYnPP+GZA@mail.gmail.com>
Message-ID: <55CB60AC.3@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2015-08-12 16:53, Kris Borer wrote:
> On Wed, Aug 12, 2015 at 10:12 AM, Michal Marek <mmarek@suse.cz
> <mailto:mmarek@suse.cz>> wrote:
> 
>     On 2015-08-12 15:51, Kris Borer wrote:
>     > Add a semantic patch for fixing some cases of checkpatch.pl <http://checkpatch.pl> error:
>     >
>     > ERROR: do not use assignment in if condition
> 
>     There is a gcc warning for this already.
> 
>     Michal
> 
> 
> ?My intention was not to create another way to uncover problems but
> rather to ?provide a tool for people to use to fix them. Let me know if
> I am misunderstanding the purpose of this subsystem.

OK, so this is fixing a style issue, and not cases of accidental
assignment instead of '==' (for which there is a gcc warning and we
hopefully do not have such errors in the kernel). While I'm probably
ignorant and no not see how one style is better than the other, I see
that some maintainers already applied your patches based on this check.
So I'll merge it once Julia acks it.

P.S.: Please switch of HTML email, otherwise vger.kernel.org won't
accept your messages.

Michal
