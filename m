Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E4CD6E44
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ByoGskjexMkAkscq0MfxLRbJsA0vGb3ycq3J4Sc0IoA=;
  b=YFidV7i2W7/JtDat6hmTKfYhjAzzYUKiH43s757thCm7tiiFmDwc9CpH
   ZSEoX8N8PCnPDZ8gYow3xKX54NUciVDU58qYZQ+1U5W8fsN4ahmxpjKV0
   xTiiiEiDcmUBfWTiSwInGRi6HDtICUvVREVBuYOYHBVtDnvYcr1xWzW4m
   k=;
X-CSE-ConnectionGUID: DdWh3yDgR2WdBDnxvWbC8A==
X-CSE-MsgGUID: IzuMO9HjRHCZZlAAyEbXSA==
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
   d="scan'208";a="278650715"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 11:33:00 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 42E9A816BA; Thu, 28 May 2026 11:33:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 73D3F81309
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 10:16:10 +0200 (CEST)
X-CSE-ConnectionGUID: SLMk7Cp/SeG3llNmVKufDw==
X-CSE-MsgGUID: GvuxPluBRU68/rxw06DscA==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="147792113"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 10:16:10 +0200
Message-ID: <536a001e-4ff3-44d3-9099-28a915487744@irisa.fr>
Date: Thu, 28 May 2026 10:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>
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
 <363a5557-fcfc-4856-b4a9-17bbdadff8b0@irisa.fr>
 <c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr>
 <7670a200-249d-4156-8363-4d24c14be452@irisa.fr>
 <31ba5c26-0ff2-4873-ac8f-d7f93f5cd30b@web.de>
 <067a58ea-abe7-46d0-9dfc-9f5e4422db73@irisa.fr>
 <3bf18744-b071-4eea-8800-4b938ddd6576@web.de>
 <a4b13282-6d06-4eb0-93d5-3c57a7bdbd64@irisa.fr>
 <69d6ba2c-9d94-4388-9d2a-9979b3c25a04@web.de>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <69d6ba2c-9d94-4388-9d2a-9979b3c25a04@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3544
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/uJCKPB9Duq_WtOZ9dGhDTA>

On 5/28/26 09:44, Markus Elfring wrote:
>>>> My use case is a plugin to GCC where I use this attribute to identify variables of interest for a specific analysis. To be even more precise, its purpose is to identify variables (or types) that are known to hold secret data (cryptographically speaking) in order to run static analysis to detect misuses of such data (e.g., a call to memcmp).
>>> Would further programming interfaces be helpful for source code introspection?
>> Yeah, I came out with the idea of a configuration file where the
>> variables/types/parameters of interest are listed per files (and maybe
>> scope?) alongside a python script to generate the different semantic
>> patch to be used with Coccinelle.
>> At first, I was thinking about writing a custom clang-tool for doing it
>> from the configuration file, but then I remembered that Coccinelle was
>> completely doing the same job and is also a tool coming for public
>> research.
> Further data structures can be designed and reused as needed.
>
> APIs from mentioned compilers might become also more interesting occasionally.
Indeed, but the thing is more expensive in term of maintainability.
In the clang-tools case, the API tends to change quite rapidly.
>> The idea of the configuration file is to be able to leave the code base
>> untouched, while still being able to play along with our tool.
> This is obviously possible.
>>>> The idea to use Coccinelle here is to be able to patch the source code of huge code base in order to run our analysis.
>>> This approach triggers special development challenges.
>> What do you mean?
> You are struggling to become more familiar with the supported capabilities
> of the semantic patch language for example.
>
> There are development ideas which are waiting on further collateral evolution.
> https://github.com/coccinelle/coccinelle/issues/
> https://gitlab.inria.fr/coccinelle/coccinelle/-/issues

Oh right, thanks.

Pierrick

> Regards,
> Markus
