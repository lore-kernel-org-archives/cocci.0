Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFFCD6E4A
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WXSdxHCqZav38qXcTaO/LBhMnSnom2Qs0V9omQ9stME=;
  b=LclDTtulv30L/YGjP1gDo3A1qxkIXbJEt5jZ/ezE4ehdgHCr9E9+Aynv
   n6nONPrVXNipVPGjJwINpMamoPWQ5JblsTl06AOAPstveNYj6MjGowaFt
   I783sGaUXT6uWM/DqF4mrYWg6xstRRFJ5bfChJtBEyh5buy97/E5YnBmm
   U=;
X-CSE-ConnectionGUID: +lLhVkwKRCy6BEzd1fO2Cw==
X-CSE-MsgGUID: +IJzmbOYRPSth1QvjbLD2w==
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
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="278650600"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 11:32:54 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 80F0781A54; Thu, 28 May 2026 11:32:54 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 276C18054D
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 09:09:47 +0200 (CEST)
X-CSE-ConnectionGUID: BKHCzjn/TBOTbHc6dmFrWg==
X-CSE-MsgGUID: W2A/L8vLR/i2z6YwiCgdIA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="147781291"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:09:46 +0200
Message-ID: <e919c230-4996-43af-9a2c-ce025399d35e@irisa.fr>
Date: Thu, 28 May 2026 09:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
 <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
 <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de>
 <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr>
 <ad06211-6441-9568-e643-c39df9bf8494@inria.fr>
 <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr>
 <4221c671-682-68de-9a94-1634364b6685@inria.fr>
 <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3541
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/XhCkAiYCjG4qjI9l0gSkUg>

On 5/27/26 13:11, Markus Elfring wrote:
>> I haven't tried this, though.  Another more complex solution involves
>> passing through python code.  You can get inspiration from
>> demos/pythontococci.cocci.  You would want to set eg coccinelle.z to a
>> string that additionally contains the desired string quotes.
> Would you find a data processing approach (like the following) “appropriate”?
>
> @searching@
> expression E1, E2;
> identifier F, X;
> initialiser I;
> type T;
> @@
>  T F = I;
>  ...
>  memcmp(&F.X, E1, E2)
>
> @script:python generation@
> f << searching.F;
> x << searching.X;
> content;
> @@
> coccinelle.content = cocci.make_ident("__attribute__((myattr(\"" + x + "\"))) " + f)
>
> @replacement@
> expression searching.E1, searching.E2;
> identifier searching.F, searching.X, generation.content;
> initialiser searching.I;
> type searching.T;
> @@
>  T
> -F
> +content
>  = I;
>  ...
>  memcmp(&F.X, E1, E2)
This one is clearly working and the output is as expected, thanks.
I tried writing one on my own but didn't manage to write a working
semantic patch.
Thanks a lot :)

Pierrick

> Regards,
> Markus
