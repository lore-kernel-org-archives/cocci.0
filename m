Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51440C4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YA1Q7r2MD2IDprLLiJlNJRSpMTj1ZdOkA9I4ysjBm4o=;
  b=rXV9Kvy95xCYLFP4yKikY4oTylY7jKHylsIZmBI0S62C2vQvHiLAmA6J
   UtKlmDpQGE0PqPj42zu1+kh201r0vdKp6Y7g8WxICjxLTQY9oNkMXrVMY
   wkOHDaGByntIUpN9kEDrMoNLfQn/9G7Z29lZIbSpt1Pu6XYel9Qxco5PE
   M=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72820567"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 13:45:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 412E5E7389; Thu,  3 Nov 2022 13:45:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 25FD2E7388
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 13:45:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YA1Q7r2MD2IDprLLiJlNJRSpMTj1ZdOkA9I4ysjBm4o=;
  b=nQIwSyIbY7GfPLLJPcWNeguxKKGKJ0mQeNgYaaYWNjWcZ4kpsL2bIiiy
   ii3EteQl0lnVJquerUCpp8fsoXzkTCFoMsELQUR8YLaOBTRr/OGQHSOAf
   SSJ03+Ee2A5VYPtuVdpSQE9w6SOL6UCKQnWu2twkepJV/JoyuDoERGKIq
   k=;
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72820556"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:45:28 +0100
Date: Thu, 3 Nov 2022 13:45:28 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>, 
    cocci@inria.fr, Linus Torvalds <torvalds@linux-foundation.org>, 
    Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, 
    linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, 
    masahiroy@kernel.org, gregkh@linuxfoundation.org, 
    andriy.shevchenko@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <Y2MGlTwh9aB+4z4l@zx2c4.com>
Message-ID: <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain> <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com> <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com> <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com> <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com> <Y1ku+jfRAyezq6Nz@zx2c4.com> <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 706
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/d930b8af-7cb-c652-c3a4-cf8e9bdd610%40inria.fr>



On Thu, 3 Nov 2022, Jason A. Donenfeld wrote:

> On Wed, Nov 02, 2022 at 06:17:04PM +0100, Julia Lawall wrote:
> >
> >
> > On Wed, 26 Oct 2022, Jason A. Donenfeld wrote:
> >
> > > On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > > > The traditional objdump comparison does work, though. It produces a good
> > >
> > > Another thing that appears to work well is just using Coccinelle
> > > scripts. I've had some success just scrolling through the results of:
> > >
> > >     @@
> > >     char c;
> > >     expression E;
> > >     @@
> > >     (
> > >     * E > c
> > >     |
> > >     * E >= c
> > >     |
> > >     * E < c
> > >     |
> > >     * E <= c
> > >     )
> > >
> > > That also triggers on explicitly signed chars, and examining those
> > > reveals that quite a bit of code in the tree already does do the right
> > > thing, which is good.
> > >
> > > From looking at this and objdump output, it looks like most naked-char
> > > usage that isn't for strings is actually already assuming it's unsigned,
> > > using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> > > things here and there, but all and all, I don't think this is looking as
> > > terrible as I initially feared.
> > >
> > > I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> > > improvements. Specifically, the thing we're trying to identify is:
> > >
> > >   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
> > >     where:
> >
> > Try putting
> >
> > disable optional_qualifier
> >
> > between the initial @@, to avoid the implicit matching of signed and
> > unsigned.
>
> Hmm, this doesn't quite work. Here are my rules:

It should work now.  However, without disable optional_qualifier, char is
still matching signed char.  If you think that should be changed, I can do
that.

julia


>
>     @disable optional_qualifier@
>     char c;
>     expression E;
>     @@
>     (
>     * E > c
>     |
>     * E >= c
>     |
>     * E < c
>     |
>     * E <= c
>     )
>
>     @disable optional_qualifier@
>     char c;
>     @@
>     * c == -1
>
>     @disable optional_qualifier@
>     char c;
>     @@
>     * c = -1
>
> This produces, for example:
>
> diff -u -p ./sound/firewire/bebob/bebob_focusrite.c /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
> --- ./sound/firewire/bebob/bebob_focusrite.c
> +++ /tmp/nothing/sound/firewire/bebob/bebob_focusrite.c
> @@ -192,7 +192,6 @@ saffirepro_both_clk_src_get(struct snd_b
>
>         /* In a case that this driver cannot handle the value of register. */
>         value &= SAFFIREPRO_CLOCK_SOURCE_SELECT_MASK;
> -       if (value >= SAFFIREPRO_CLOCK_SOURCE_COUNT || map[value] < 0) {
>                 err = -EIO;
>                 goto end;
>         }
>
> Except map is defined as:
>
>     const signed char *map;
>
> So this would be one of those cases that I had hoped `disable
> optional_qualifier` would exclude. (I think internally coccinelle might
> be assuming `char` is signed, by the way.)
>
> > >   - It's not being used for characters; and
> > >   - It's doing something that assumes it is signed, such as various
> > >     types of comparisons or decrements.
> >
> > I took a quick look at the article, but I'm not completely sure what you
> > are getting at here.  Could you give some examples of what you do and
> > don't want to find?
> >
> > You don't want the case where c is 'x', for some x?
>
> Something I would want to find is `if (c < 0)`. Something I wouldn't
> want to find is `if (c < '9')`. IOW, I'm looking for code that assumes
> `c` is signed, and would become incorrect if `c` suddenly became
> unsigned. Most things involving actual characters are fine. But most
> things involving signed arithmetic or comparisons with numbers isn't
> find.
>
> Jason
>
