Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B5C433F5
	for <cocci@archiver.kernel.org>; Sat,  8 Oct 2022 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=m/pdT9g/wX/pgeg5dalCPuz6ENNL6jg9/W/znfXjyvE=;
  b=hPeb8KuIEOstZfBgr1C73RIrjVRdjBEIwtiyHnQUXH6g1bGGqDyGokYF
   uwk/ZOvQRcbU1Fe6SRryYgsWprrsJQ4aJQqiol/Kk2BlgaUYNYlGYiDjY
   jLVLI2RAmSR38ZESXfn9LQ9YnCQxc2SwxDSyvQ91mK0k92nMgDg/GAnb8
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56593588"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Oct 2022 09:43:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60A79E02CA; Sat,  8 Oct 2022 09:43:59 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E445AE0121
	for <cocci@sympa.inria.fr>; Sat,  8 Oct 2022 09:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m/pdT9g/wX/pgeg5dalCPuz6ENNL6jg9/W/znfXjyvE=;
  b=HGSPmku6whFog1IYWhVw5waMbkL9JHCWqVukyz7RnyTRrP+MwoxhUNuj
   2dXRiNR0I5A08HwqZP9Zl1JcAcN07P9gUJD//15x4i58XEKHgHS+65QAu
   /L9FMyUusZJtfn0gFP4MTOi6Ovt/uk/Hbk9ebDf2fj7p2UufkE+BLXFRL
   Y=;
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="25831901"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 09:43:54 +0200
Date: Sat, 8 Oct 2022 09:43:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: cocci@inria.fr, Julia Lawall <julia.lawall@inria.fr>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>
In-Reply-To: <202210071600.078A2101@keescook>
Message-ID: <alpine.DEB.2.22.394.2210080942250.3287@hadrien>
References: <202210071600.078A2101@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] how to check a for "don't care" state of a variable?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 618
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/alpine.DEB.2.22.394.2210080942250.3287%40hadrien>



On Fri, 7 Oct 2022, Kees Cook wrote:

> Hi!
>
> I was looking at doing some conversions for this[1], and I wasn't sure
> how to check for removing a variable assignment if there was either no
> more uses or the next use was an assignment itself.
>
> i.e.:
>
> 	var = 1;
> 	other = func(var);
>
> turns into:
>
> 	other = func(1);
>
> but this would not:
>
> 	var = 1;
> 	other = func(var);
> 	report(var);
>
> without getting confused by:
>
> 	var = 1;
> 	other = func(var);
> 	var = 5;

- x = e;
  ... when != x
? x = e';

The ? will stop the match if the thing is found, but won't require the
presence of that thing for the match to be successful.

julia


>
>
>
> @multi_line@
> identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
> identifier RAND;
> expression E;
> type TYPE;
> @@
>
> (
> -       RAND = randfunc();
>         ... when != RAND
> -       RAND %= (E);
> +       RAND = prandom_u32_max(E);
> |
> -       RAND = randfunc();
>         ... when != RAND
> -       ((TYPE)RAND % (E))
> +       prandom_u32_max(E)
> // This is wrong: we need to check that RAND is either assigned or never
> // accessed again
> )
>
>
> I thought I could do this:
>
> 	... when != RAND
> 	<... RAND = EXP; ...>
>
> But this appears to be invalid syntax...
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/202210071241.445289C5@keescook/
>
> --
> Kees Cook
>
