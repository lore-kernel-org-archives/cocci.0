Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3026AECAAD8
	for <cocci@archiver.kernel.org>; Thu,  1 Sep 2022 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tHMrMn32N8Agsl+EQFOeGq4qYS1E6WGJksLjXJD4bOU=;
  b=SvwatD5F+KMnoNN3+rVVijaFF+aCLMg4fPznpoMCJDaQyq7Ty63cQhrH
   KWhpB7IotGWS+r7fw8oy/6zWj73U3JkiE4BGVApBYWz9yiXDhq7V39FDR
   Lq+gc9oAGBQ8YVCfKvj3dB+WVGMZD4/z4RUTcBac8VGhgQfnw6MOeXKrq
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="50911711"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Sep 2022 17:19:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2426BE779D; Thu,  1 Sep 2022 17:19:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D377EE7799
	for <cocci@sympa.inria.fr>; Thu,  1 Sep 2022 17:19:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tHMrMn32N8Agsl+EQFOeGq4qYS1E6WGJksLjXJD4bOU=;
  b=DNpEi667tQa3jZ8ypEmIauVYFuhQ5+FCsO7ufbVO32zMH+jxYVlu+ybG
   x24S+K7vu+RhUbV6XYBG/FdocSpgc36/4RvxnGKMHZA3vjHSm6WMrm/oY
   THcXg7y48OVhT94nji5AUQ4UeM7cGNTHuyHy5VC/w1DZ/kkvEJAyVXCgL
   U=;
X-IronPort-AV: E=Sophos;i="5.93,281,1654552800"; 
   d="scan'208";a="22629164"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:19:23 +0200
Date: Thu, 1 Sep 2022 17:19:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc: Coccinelle ML <cocci@inria.fr>
In-Reply-To: <220901.8635dbjfko.gmgdl@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209011715290.33128@hadrien>
References: <220901.8635dbjfko.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-629888121-1662045562=:33128"
Subject: Re: [cocci] Optimizing *.cocci rules by concat'ing them
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 532
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209011715290.33128%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-629888121-1662045562=:33128
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 1 Sep 2022, Ævar Arnfjörð Bjarmason wrote:

> Are there reasons for why $subject is a generally bad idea, i.e. given a
> set of *.cocci rules in a directory instead of something like:
>
> 	for c in cocci/*.cocci
> 	do
> 		spatch --sp-file $c --patch . *.c
> 	done
>
> Doing:
>
> 	cat cocci/*.cocci >ALL.cocci
> 	spatch --sp-file ALL.cocci --patch . *.c
>
> I'm aware that rules in general may rely on previous transformations,
> such that the 3rd rule in a file might not fire unless the other 2 have
> previously changed the code.

I think that the main problem is the opposite of what you suggest.  Two
.cocci files might define rules that have the same names.

I don't see any other problems offhand.  If one rule makes a change that
somehow affects a later semantic patch, then that should be ok, assuming
that the change made by the first rule was actually a fix.

Another issue is that you can't mix rules that make changes with rules
that just search (*).  You need at least some command line options, like
-D patch in make coccicheck, to keep them apart.

julia

>
> But aside from any such undeclared dependencies, which surely I'll have
> trouble with either way. I.e. I'd get to the 2nd rule in A.cocci, apply
> that to my sources, and only then on a second run would the 1st rule in
> B.cocci fire, but it should have been in A.cocci to begin with, and
> depending on the 2nd rule in that file.
>
> Are there reasons for why this is a Bad Idea?
>
> The motivation here (and this is probably burying the lede) is that I
> implemented a "spatchcache", which can cache previous runs of "spatch"
> in a local Redis (or with a custom command, if you don't have Redis, I
> started out with a dumb FS-based cache).
>
> It uses the approach of piggy-backing on GCC and Clang's ability to dump
> a full list of all the files that a given *.c file depends on.
>
> This is usually used to drive better incremental "make" support, but I'm
> (ab)using it to implement an "spatchcache". If the hash of a the target
> file *and* everything it depends on *and* spatch's path, flags etc. is
> the same I can cache the output of "spatch".
>
> See [1] for a series to implement this for git.git. I'd previously mused
> on this list in [2] about this approach (but hadn't finished it up until
> now).
>
> But even then git's fairly slow in running "make coccicheck", and of
> course it does nothing to speed up an initial run. So concat'ing the
> *.cocci files we use seems like a viable option. But I thought I'd ask
> first in case I'm running into somewell-known caveat.
>
> Thanks!
>
> 1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com/
> 2. https://lore.kernel.org/cocci/211116.86lf1op65q.gmgdl@evledraar.gmail.com/
>
--8323329-629888121-1662045562=:33128--
