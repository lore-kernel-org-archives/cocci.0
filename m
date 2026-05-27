Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4323BCD6E44
	for <cocci@archiver.kernel.org>; Wed, 27 May 2026 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hgScy2g1Lu5JFGXni7LjFc3ZW4Zy4hRxdXvCE1PJrGs=;
  b=aJcyuDsCOUQfEzyfklKKZuMfq3RFEQ6oFA6H3su0amkPRBVW0PvqbLtQ
   w26B45k6v/8PjKiI/IFzK3w94LyDB1y3v+aZFkv0oyfYUR1c2kUAVgWEM
   jdQHMnL/flxxQGBa1xPQV2d9YUJsC/8dfAQcZh2VaYD0pHLv5dhAmntrL
   M=;
X-CSE-ConnectionGUID: B6Y6I/uNQpqCZKwfLB+vWg==
X-CSE-MsgGUID: Cx6CiTXyR2+02Hf2v/U4xw==
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
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="278449807"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2026 11:45:21 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 366AF81621; Wed, 27 May 2026 11:45:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 98D2A815EA
	for <cocci@sympa.inria.fr>; Wed, 27 May 2026 11:35:56 +0200 (CEST)
X-CSE-ConnectionGUID: F+YW9FSsSPC4KrXwVn+jOg==
X-CSE-MsgGUID: IjZw9MClTZmCJBs0OyVG+g==
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="147691511"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 11:35:56 +0200
Message-ID: <b57b0f6c-1e81-4efc-b9db-afb395cc662d@irisa.fr>
Date: Wed, 27 May 2026 11:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Markus Elfring <Markus.Elfring@web.de>
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
 <c9b96fc7-d274-4572-b2a7-a7ddd53f0488@web.de>
 <1eb6ffd-2fb8-28b9-86d2-3d3a9691c874@inria.fr>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <1eb6ffd-2fb8-28b9-86d2-3d3a9691c874@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3532
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/Ccha4hSANyL4Ov8Sa97eqA>

On 5/27/26 11:32, Julia Lawall wrote:
>
> On Wed, 27 May 2026, Markus Elfring wrote:
>
>>>> I think that the problem is that { ... } is not actually an expression in
>>>> C.  It's a strange thing that can only exist as part of a declaration.
>> See also:
>> https://en.cppreference.com/c/language/initialization
>> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/1bff7651118fc65c269dd8dba7f7d4a30fbc72c7/docs/manual/cocci_syntax.tex#L237-238
>>
>>
>>>> But you don't want to change it, so you don't need a metavariable for it.
>>>>
>>>> Just write:
>>>>
>>>> - T F =
>>>> + T __attribute__((myattr(("X")))) F =
>>>>   { ... };
>>> It does work indeed, thanks a lot!
>> @addition@
>> expression E1, E2;
>> identifier F, X;
>> type T;
>> @@
>>  T
>> +__attribute__((myattr("X")))
>>  F = { ... };
>>  ...
>>  memcmp(&F.X, E1, E2)
>>
>>
>>> Although the metavariable X is not interpreted in the `+` context,
>> I suggest to reconsider such a view once more.
>> Please take another look at implementation details.
>>
>>
>>> could it be due to the attribute or unrelated?
>> Would you like to adjust a string literal according to a variable access?
> The string is supposed to be constructed from the field referenced in the
> memcmp call.

Exactly.

Pierrick

>
> julia
