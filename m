Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72695CD5BD1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D8qP4FJ3xj6CAA+ucVIW7d5YlxADCL0b9R7LZ43aeso=;
  b=Z7w0VOT0jTw2Dc214OgbJBmc1ZbQqDsK/RqiwmSmJPYT6o80Isqp9lPP
   TAGsy5I3dzmq7kZTq8ESeDNZSEMczENltN0T7ScEx6XBMviP7XYQ7T3ZK
   aNTudLdh+5DSB2iZmV8KS/ac8BPtB6d7LSYzYhrDvAyorjT9gFGnEB0kO
   I=;
X-CSE-ConnectionGUID: ZiQzMQF+TRGEHmR0F1/Kkg==
X-CSE-MsgGUID: 6pAP3HtYQ4udIuS2AtOLgg==
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
   d="scan'208";a="278650636"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 11:32:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AC18D81A6A; Thu, 28 May 2026 11:32:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2B8628068D
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 09:29:27 +0200 (CEST)
X-CSE-ConnectionGUID: ZbylYKbMSWeEmBgHwlDO/w==
X-CSE-MsgGUID: TdYt3zzuSI2tGCVO4y0MZw==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="147784188"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:29:27 +0200
Message-ID: <a4b13282-6d06-4eb0-93d5-3c57a7bdbd64@irisa.fr>
Date: Thu, 28 May 2026 09:29:26 +0200
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
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <3bf18744-b071-4eea-8800-4b938ddd6576@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3542
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/iiQ6DGiCtehCo1zIE_-JXQ>

On 5/28/26 09:11, Markus Elfring wrote:
>>>> I apologize to both of you for the confusion, I do want quote, but I do not want escaped quote (I haven't tried it with escaped quote, but I'm pretty sure it won't be a valid string for GCC).
>>> I suggest to reconsider known use cases for corresponding quoting
>>> (in discussed source code variants).
>> Not sure what you meant here, I am sorry.
> Are you used to escaping of selected data?
> https://en.wikipedia.org/wiki/Escape_character
Oh, yes, I am sorry.
>>>> The attribute I'm working with is taking an optional parameter, which, if present, should be a string (const char *) containing the field name of interest.
>>> Where would you like to benefit from the knowledge of such an identifier?
>> My use case is a plugin to GCC where I use this attribute to identify variables of interest for a specific analysis. To be even more precise, its purpose is to identify variables (or types) that are known to hold secret data (cryptographically speaking) in order to run static analysis to detect misuses of such data (e.g., a call to memcmp).
> Would further programming interfaces be helpful for source code introspection?
Yeah, I came out with the idea of a configuration file where the
variables/types/parameters of interest are listed per files (and maybe
scope?) alongside a python script to generate the different semantic
patch to be used with Coccinelle.
At first, I was thinking about writing a custom clang-tool for doing it
from the configuration file, but then I remembered that Coccinelle was
completely doing the same job and is also a tool coming for public
research.

The idea of the configuration file is to be able to leave the code base
untouched, while still being able to play along with our tool.

>> The idea to use Coccinelle here is to be able to patch the source code of huge code base in order to run our analysis.
> This approach triggers special development challenges.

What do you mean?

Regards,

Pierrick

> Regards,
> Markus
