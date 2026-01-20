Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE02AD2ED0F
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nGNTMY1hdz+tg+5/wEXXjR/9DHJ8GjUj7oCU9Bj5nC8=;
  b=uQEfodTQoqSumj6/nrYJGRaW0HzU56s725s8aCvvoKf4Nx2FzovxCuXx
   Wyfrjry63xaRChQbBOyiWKnGjFG/zxfjLEf+/yCS/dEOwLSEP6tcV+r1I
   zMsfXypUm9DsTz0/EV05Tma3B9jvYztrz8EEhTfBNSg8oAh2K+PY0HBh3
   o=;
X-CSE-ConnectionGUID: 4nG1KH+uQ2eqprAWjcVAeg==
X-CSE-MsgGUID: P4QQigyLSkaN+KL3NjdAjg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259450851"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 13:45:45 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A19C683A5F; Tue, 20 Jan 2026 13:45:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B92AC836E2
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 13:45:39 +0100 (CET)
X-CSE-ConnectionGUID: 4U4wysVZRu+kBex117VjpQ==
X-CSE-MsgGUID: jCM6y/AAR3anCNG9HvjYwA==
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="136505617"
Received: from unknown (HELO hadrien) ([4.26.64.170])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:45:39 +0100
Date: Tue, 20 Jan 2026 07:45:38 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
Message-ID: <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de> <3857229-a98-854f-225f-5a63ca19cb7d@inria.fr> <15bca19e-5a87-4efd-8da7-c6ea2cad27f1@web.de> <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr> <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr> <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de> <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1744034420-1768913139=:4134"
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3287
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/JW_J_JIEObybB795QdNy7w>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1744034420-1768913139=:4134
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 20 Jan 2026, Markus Elfring wrote:

> > I can try another SmPL script example out:
>
> @display_without_extra_semicolon@
> expression action;
> expression * pointer;
> identifier member;
> @@
> *pointer = action(...);
>  <+...
> *pointer->member
>  ...+>

And yet I made another suggestion that you completely ignored:

* pointer = action(...);
  (<+...
* pointer->member
  ...+>);

This should you give what you seemed to want, with pointer->member in the
immediately following statement only.

julia

>
>
> > Do you imagine any further data processing refinements?
>
> Corresponding test result:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> time /usr/bin/spatch --no-loops …/Projekte/Coccinelle/janitor/show_questionable_statement_combination6.cocci drivers/regulator/fp9931.c
> …
> @@ -438,44 +438,21 @@ static int fp9931_probe(struct i2c_clien
> …
> -       data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> -       data->regmap = devm_regmap_init_i2c(client, &regmap_config);
> -       if (IS_ERR(data->regmap))
> …
> @@ -501,7 +478,6 @@ static int fp9931_probe(struct i2c_clien
>
>         config.driver_data = data;
>         config.dev = &client->dev;
> -       config.regmap = data->regmap;
>
>         for (i = 0; i < ARRAY_SIZE(regulators); i++) {
>                 rdev = devm_regulator_register(&client->dev, &regulators[i],
>
> real    0m1,057s
> user    0m1,008s
> sys     0m0,026s
>
>
> Regards,
> Markus
>
--8323329-1744034420-1768913139=:4134--
