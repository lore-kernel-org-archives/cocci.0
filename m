Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC87CD5BD0
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hhezv992ryaOFWxEmQC20YHRDgwOxdtW6ZrIlWnGv4k=;
  b=XqUXbmmWF6xRcDW6MnP0G9eIXqKuz4l9N0Jz9fK4G6yR86t/RI9MlH0j
   2QjCqcjWROv4+ZoRojfntEKl6PwCb9p16gg2iIniyTSwrV+KvZMlUhIQ4
   ztL8nb5ebKkAUCh4Hcd3oOI7a465uYdtVjmg9EXHVnWX7HMnuLrimEJma
   M=;
X-CSE-ConnectionGUID: eWh6Ho9VTGKJGodYyebvqg==
X-CSE-MsgGUID: uUe/vXzLSaWf/iJGN2zgHQ==
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
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278234735"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 13:33:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D8E3486353; Tue, 26 May 2026 13:33:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F317280E9E
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 11:24:04 +0200 (CEST)
X-CSE-ConnectionGUID: 9BaoWGT5RIqjgsNglav3YA==
X-CSE-MsgGUID: 6bCFBdvNTSeDd0aB3S6qOg==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208";a="278205158"
Received: from 88-183-23-223.subs.proxad.net (HELO [192.168.1.189]) ([88.183.23.223])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 11:24:04 +0200
Message-ID: <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
Date: Tue, 26 May 2026 11:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
 <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3525
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/Huf0qU8up0IuTxZDHbrg1Q>

Hi Markus,

Thanks for your answers.

On 5/26/26 11:20, Markus Elfring wrote:
>>> Also, Coccinelle requires you specify a complete term, not just the
>>> subpart of the term that is convenient for you.
>> I think I understand, also I do have a question regarding the `declaration` keyword of the grammar.
>> Is there any way to access inner information of the declaration?
> The programming interfaces can eventually be adjusted.
>
> The semantic patch language supports also kinds of metavariables which refer to compound data.
> It would occasionally be nice if subitems would be directly accessible.
>
> But it is possible to express desirable information requirements by the means of SmPL conjunctions.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/1bff7651118fc65c269dd8dba7f7d4a30fbc72c7/docs/manual/cocci_syntax.tex#L1050-1054
>
> SmPL conjunctions trigger the need to indicate data constraints in a repeated way.
Oh, thank you for the pointers into the documentation.
>>> This again fails because you have only specified part of the memcmp
>>> statement.  If you want to put a complete statement, you have to put the
>>> whole thing.  I think you can also just put a memcmp call, without the
>>> semicolon.
>> It worked with the whole `memcmp` call statement indeed, I probably misunderstood the `...` operator then.
> Did you interpret SmPL ellipses as code placeholders?

It is exactly how I interpreted it, somehow such as `.*` in regular
expression.

Thanks,

Pierrick


