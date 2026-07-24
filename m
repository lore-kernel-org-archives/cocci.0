Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE73DC531C9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Rw0wIETRsFh1KY80jRMSxOddXjGx6rijH0hDzdNJijU=;
  b=B3rkE9WrW5PraCOnn04SiNHxJ8SQwTrjbnvXnzwgJTeeRIZiTt4q151x
   RCzeiMvHJikA/XeR5jj/0Q4iTv9FUwcZk3dnCMLJThU8eWm0vmAdawXxP
   9/THSQihZ0gWGNvmUA8VejaLpVwHeErhjPZgmdf/HvlA/ztXmAIK7ozZm
   E=;
X-CSE-ConnectionGUID: dfrtjnCrQtiaJ5pKuVwbRQ==
X-CSE-MsgGUID: Ai/4EocdQA24b7k6cG4wWA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287766079"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 13:38:29 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 36A568149A; Fri, 24 Jul 2026 13:38:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4F19180E08
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 13:38:25 +0200 (CEST)
X-CSE-ConnectionGUID: Qy+w6r+XQbK1ocn3cYRoYA==
X-CSE-MsgGUID: 0OKsW1t3SXmd+jTnHp81dA==
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287766068"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:38:25 +0200
Date: Fri, 24 Jul 2026 13:38:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: Sang-Heon Jeon <ekffu200098@gmail.com>, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
In-Reply-To: <b0577cf2-d8eb-473f-87af-82ecc653f29c@web.de>
Message-ID: <614a4d1a-7a18-f7d9-7531-64605bc24080@inria.fr>
References: <20260723184538.3888637-2-ekffu200098@gmail.com> <b0577cf2-d8eb-473f-87af-82ecc653f29c@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1116840085-1784893105=:3487"
Subject: Re: [cocci] [PATCH 01/36] coccinelle: misc: add
 cond_return_no_effect.cocci
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3646
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/ZSzxYrSzJkqhGQipy19jmA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1116840085-1784893105=:3487
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 24 Jul 2026, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/misc/cond_return_no_effect.cocci
> > @@ -0,0 +1,121 @@
> …
> > +@depends on patch@
> > +local idexpression ret;
> > +expression E;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +-	ret = E;
> > +-	if (\(ret \| !ret \| ret cmp C\))
> > +-		return ret;
> > +-	return ret;
> > ++	return E;
> > +
> > +@depends on patch@
> > +idexpression ret;
> > +binary operator cmp = {<, <=, >, >=, ==, !=};
> > +constant C;
> > +@@
> > +-	if (\(ret \| !ret \| ret cmp C\))
> > +-		return ret;
> > +	return ret;
> …
>
> How do you think about to combine such transformation rules
> by using an SmPL disjunction?

I see no benefit to doing that.  In particular, the patterns search for
some code in common, but from different places, since one starts with an
assignment and the other starts with an if (that is common to both).

julia
--8323329-1116840085-1784893105=:3487--
