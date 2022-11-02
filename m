Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499CFC4332F
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Hwlkw4yAnCdRiQ+TM46iAZW7QPfAAgCdGvGqNHRyplo=;
  b=ExYTdZ+4qCXvApow/X7pJ75xj3I4jfJyu0LIXVj+ml2oCfCsUvhbQO89
   /JgNjKgeHzPIWFf5g5QijEYfKPjzG7iwJT/TU58aFDH+TjXivmpvqOuzf
   daLep/nAhEiIvyQ0FcWNuvIeDGJoy6V5rTOZhZ+z1fNXsOvjPFXlFhjEU
   4=;
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
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72701521"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:17:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2BD8FE010F; Wed,  2 Nov 2022 18:17:08 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DF43E002A
	for <cocci@sympa.inria.fr>; Wed,  2 Nov 2022 18:17:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hwlkw4yAnCdRiQ+TM46iAZW7QPfAAgCdGvGqNHRyplo=;
  b=H5UvIVYTfCSfCsJKvK0mipZhvhRzj9y8kKLh86gNspOg4Ze7Dcy8Ys3O
   gldI0+jMNErr2iMaqtJsOvJMVxpQuEpIvlRQr3v01N3cdqZLlz+mS7Gjt
   C7nPoQRkj62ttpQ5YKEv4lrhBw4Sk+sBcGeOL2bLmUuZwcB8fjjU6FoCK
   M=;
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72701514"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 18:17:04 +0100
Date: Wed, 2 Nov 2022 18:17:04 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org, 
    linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, 
    masahiroy@kernel.org, gregkh@linuxfoundation.org, 
    andriy.shevchenko@linux.intel.com, Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <Y1ku+jfRAyezq6Nz@zx2c4.com>
Message-ID: <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain> <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com> <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com> <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com> <202210201151.ECC19BC97A@keescook> <Y1iSYddi3BpP8gvf@zx2c4.com> <Y1ku+jfRAyezq6Nz@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 698
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/b72d866d-1dce-7260-7f1e-54be9fd25e97%40inria.fr>



On Wed, 26 Oct 2022, Jason A. Donenfeld wrote:

> On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > The traditional objdump comparison does work, though. It produces a good
>
> Another thing that appears to work well is just using Coccinelle
> scripts. I've had some success just scrolling through the results of:
>
>     @@
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
> That also triggers on explicitly signed chars, and examining those
> reveals that quite a bit of code in the tree already does do the right
> thing, which is good.
>
> From looking at this and objdump output, it looks like most naked-char
> usage that isn't for strings is actually already assuming it's unsigned,
> using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> things here and there, but all and all, I don't think this is looking as
> terrible as I initially feared.
>
> I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> improvements. Specifically, the thing we're trying to identify is:
>
>   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
>     where:

Try putting

disable optional_qualifier

between the initial @@, to avoid the implicit matching of signed and
unsigned.

>   - It's not being used for characters; and
>   - It's doing something that assumes it is signed, such as various
>     types of comparisons or decrements.

I took a quick look at the article, but I'm not completely sure what you
are getting at here.  Could you give some examples of what you do and
don't want to find?

You don't want the case where c is 'x', for some x?

julia

> LWN wrote a summary of the general problem, in case that helps describe
> what would be useful: https://lwn.net/SubscriberLink/911914/f90c2ed1af23cbc4/
>
> Any nice Cocci tricks for this?
>
> Jason
>
