Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253CFC83F27
	for <cocci@archiver.kernel.org>; Tue, 22 Jul 2025 11:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=XTD5LoxWRzb4R0vo7o7QlFniPd6O8YR0tfc/XT9p3Ho=;
  b=b4WzGssXaFQ7DwrYCOssrrJzXTDiydpXY+/fw65GXkrly2S4CPHz7WO6
   FBP6g+vrEXrzko0k9Hh9fupbTiPWoJumo/8eZ0wYoSsv1vMGbx4rRdS5l
   wIpXIDaufYur+pnHH3h/4J8Dy1GbJ46YnYXE6gZ1b9iPsS/8tb6ABDQsv
   k=;
X-CSE-ConnectionGUID: IYX1cF+xReicPojl9v6Nnw==
X-CSE-MsgGUID: eN3WLM2QR7GiFOddVqHeRw==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="232615730"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jul 2025 13:12:24 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 882CFE0264; Tue, 22 Jul 2025 13:12:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 51997E0171
	for <cocci@sympa.inria.fr>; Tue, 22 Jul 2025 13:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XTD5LoxWRzb4R0vo7o7QlFniPd6O8YR0tfc/XT9p3Ho=;
  b=ARxYIYiU8t9U+Ja1bcyV2xkgdgYEfHZ6FYd6fzURyUE9ora1ZPVwWCOG
   w8HP/JMr7Vc34IbWF3A4BGQ4RZHXrqww3c9SPBeHciV8/MHi+XZJxLHr/
   ujjPYhqBcT++l1zjTxxqrNyulxf5c2q1L6pLIhB73lJaSuz43z7WtrW41
   g=;
X-CSE-ConnectionGUID: 7hT9LCD8QU+rJV5rBh5r1Q==
X-CSE-MsgGUID: kqhNbdwCQtKGQiBdMnEffg==
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="121933333"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 13:12:21 +0200
Date: Tue, 22 Jul 2025 13:12:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <9083bc25-b9ab-40ef-903c-f26d9670c112@web.de>
Message-ID: <8ef830f6-6ab3-e5de-86a3-771315bc90d@inria.fr>
References: <0830325b-6697-49d1-a0a4-d06814c6450f@web.de> <21f78cc-6034-2b33-c2fb-cdf6d3694d2@inria.fr> <fafd85e8-9d04-401f-a4a5-d4286a911264@web.de> <alpine.DEB.2.22.394.2507201608390.3477@hadrien> <bf7d6619-92c5-4471-a6fd-df4af8b97e39@web.de>
 <alpine.DEB.2.22.394.2507210747070.18950@hadrien> <6fa377f7-0612-42aa-afbc-cdeab8bea314@web.de> <8a4b47e2-725e-769e-6bb-43e01113f9fa@inria.fr> <52ce78f5-8141-46dc-9ad0-5cbfedfd92a1@web.de> <cd40be57-cdef-7834-5c8d-eda49eb3a8b@inria.fr>
 <9083cb34-5f8a-43d9-b908-43a9fe2a4281@web.de> <4752963-ce2-3e23-fe61-9cbd1acbbdc1@inria.fr> <9154fc36-842b-4797-9b55-397cfdcba283@web.de> <2914d20-68da-a23d-6345-fd48f0b9bed8@inria.fr> <8c949c3e-cb28-42f4-9db6-e4e81231236e@web.de> <479a2492-62de-2b9d-4899-4d4f35f653e9@inria.fr>
 <9083bc25-b9ab-40ef-903c-f26d9670c112@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-985079949-1753182741=:3516"
Subject: Re: [cocci] Reducing parentheses (with SmPL)?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2900
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/8ef830f6-6ab3-e5de-86a3-771315bc90d%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-985079949-1753182741=:3516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 22 Jul 2025, Markus Elfring wrote:

> >> There is a desire to avoid extra parentheses in the generated diff output.
> >> If such difference displays should be accepted as patches for known code bases,
> >> it would probably be more helpful if they could adhere better to coding
> >> style preferences.
> > You have sent like 20 messages about this.
>
> Some communication is obviously needed to achieve a better common understanding
> for the presented topic.
>
>
> >                                             How about one single concrete
> > example where the output is not what you hoped for???
>
> Another SmPL script example:
> @replacement@
> expression condition, context, x, y;
> identifier action;
> @@
> -if (condition)
> -   { action(context, x); }
> -else
> -   { action(context, y); }
> +action(context, (condition) ? (x) : (y));
>
>
> Questionable test result (by the software combination “Coccinelle 1.3.0” for example):
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20250722 && time /usr/bin/spatch …/Projekte/Coccinelle/Probe/use_selected_call_with_ternary_operator-20250722.cocci fs/xfs/scrub/findparent.c
> …
> @@ -229,11 +229,8 @@ xrep_findparent_live_update(
> …
> +               xrep_findparent_scan_found(pscan,
> +                                          (p->delta > 0) ? (p->dp->i_ino) : (NULLFSINO));
> …
> @@ -269,10 +266,8 @@ __xrep_findparent_scan_start(
> …
> +       xfs_dir_hook_setup(&pscan->dhook,
> +                          (custom_fn) ? (custom_fn) : (xrep_findparent_live_update));
> …

Why is it a surprise to see the () if you put the ()?

julia

>
> real    0m0,322s
> user    0m0,138s
> sys     0m0,022s
>
>
>
> > On the other hand, Coccinelle cannot guess what are your coding style preferences.
>
> It would be nice if the pattern recognition could be improved another bit.
> But we tend to concentrate mostly on Linux source code variations so far.
>
> Regards,
> Markus
>
--8323329-985079949-1753182741=:3516--
