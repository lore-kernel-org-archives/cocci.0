Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC81C10F16
	for <cocci@archiver.kernel.org>; Mon,  6 May 2024 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=VDwkJ1sNnmeRopEEACbeFsqg4jk3TAw5A3K/SzOKpaE=;
  b=itv5p2VDXHLDtuyp6Baxu7+DV7d3oVWpiYGkzKujelRBaxYTNfGKQMYO
   6AJLg9APRQRFl5PqpMSRsV0VCcwe6T4YhFXFIf1Qk0h2OMrRI9WTQ3yY7
   /4Kk/d0rVOq4jlJPfI6VAhX8nB+fqz7cxhdyeRnksEaDvZZkF531nILpH
   c=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164650398"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 May 2024 12:08:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D1D8E0141; Mon,  6 May 2024 12:08:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A4AAE0035
	for <cocci@sympa.inria.fr>; Mon,  6 May 2024 12:08:37 +0200 (CEST)
IronPort-SDR: 6638ac25_J/Pg+ZtdiV1OQR5Uuo76tfoH/z7FPPku77hkaEfqYOyiYov
 p6jItqxGBAPL8L+hrhbENJ9cBS13r8jGR82UeUg==
X-IPAS-Result: =?us-ascii?q?A0HCBAAVqzhmhwQP49RagQmBT4JEfFczBAtICIROj0aBd?=
 =?us-ascii?q?S2EPo8IiHGBVoFAPg8BAwENPQQBAgQBAQMDAYILgmqIOgIeBwEEMgcOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CYBiBD?=
 =?us-ascii?q?oEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECD?=
 =?us-ascii?q?TprHQEBESc0AiYCcwEBgnwBgi8BAzEHDQayW4EygQGCDAEBBoFYQU7Xch8sI?=
 =?us-ascii?q?leBYgMGgRouiBQaAQVniXcPgVVEgTwLgkeDUAEBAoIrgw6CaYghAY5RgzOCK?=
 =?us-ascii?q?4pggVEcA1khEwFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjA?=
 =?us-ascii?q?wgEAxA0AyBvEQMEGgQLB3WDMQQTRAOBOIl6gz2CIIQhCEOBAYN0gXgOYoZ1H?=
 =?us-ascii?q?UACAQttPTUJCxsGIh6hEoQPDll7CoE4kyaQeqEgNAeCNoFgBYFcDIh9gSSVI?=
 =?us-ascii?q?wYTL5c4DgaSaJhijXSVQoVRgWwEL4FcMxokgzZPAxkPjjmDYTOBC5tkQTUCC?=
 =?us-ascii?q?TACBwsBAQMJhUYBAYNagUgBAQ?=
IronPort-PHdr: A9a23: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
 QU=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hqlCqakcFCm7LjbVXNwvL7i5uubpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:4PkA9W801Yv/O8RbZGCVv2MOIOIiNSz69jDzcmzoIGNLcLipS3bFrQ==
X-Talos-MUID: 9a23:ESTE9gWYor4h7mvq/Dv01CpTH5cz35mjK18SiK4ilOCWPwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,258,1708383600"; 
   d="scan'208";a="164650377"
X-MGA-submission: =?us-ascii?q?MDGAEjwKH8qUOaBl/bbt1s6w79Gd/1K8gwr1s5?=
 =?us-ascii?q?SldTPfQIPwVadIw2j7YUaUhERE/2UQI+rG0GNWDAueWRkTRp8e7FDuYv?=
 =?us-ascii?q?R7KBvtFG5/aUKuH/SWBHGAo6HB4hgo+/2HmiM6Idl7wtF6puqxQhbKDK?=
 =?us-ascii?q?MUQOmZoGQ+U4X3oigmgR9UoA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 12:08:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714990116; x=1715594916; i=markus.elfring@web.de;
	bh=VDwkJ1sNnmeRopEEACbeFsqg4jk3TAw5A3K/SzOKpaE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NwM4KxonshuAyUsmVnsUcL/+lnnplVm7UoTtzXdW8Zgn0F3nipxZnzjeNJjpJ1LL
	 ZZVQZAxztl+x6/GIOrnBdbXmAPmg+ABxkSaOwlzcglVG5kUWCj5xSLqgXJeunhXNN
	 xIGW1nmQV6noqvCzDWA4vzv3tpyPpP88OmpVgSU93b10/uG0a6jzyv/CkNdagjHYi
	 MR4agSUmLqiKIBfAbzHvO6XgfVY47udV7QymwSTiqMbBBpoLMGnAh2+ESiADoCQjm
	 USTyIfeGyYtpyRgW0CK3lKod5JZ2xETqAjNIobYi7ZFBfwXGSiFVysxbZYPA0nZAZ
	 oMLvkLMRM6e4Y+03Pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mkmvj-1sTrgp1HYt-00mBgM for
 <cocci@inria.fr>; Mon, 06 May 2024 12:08:36 +0200
Message-ID: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Date: Mon, 6 May 2024 12:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YVzHFWwdLxXCarrGz0ANSV+oa3ZVyxTJ8ORWnOpGJVNfG2oiSHW
 oLKp5c5NN8zve5DtvBiFLQRb0GNYWARcTiWcQ7JS6UtCUj8DqYNI8lftq1BW+Hv6wW6aWlg
 vlRbcoEPwiS8OUQIs6rWyEp/ITNykdOv2UpfIOp7tY8E0Ce1rGoOuATzCUafM4C4bXADs5j
 xUXSZRlh0y0OGe2izoomw==
UI-OutboundReport: notjunk:1;M01:P0:8C/62c456Mw=;7Q7Qc86xkOI6pjsRtQG6ypcL5WK
 DfplFQ8587YIMUChO/mwSJKNPO1FQF9bK0ule6lA96UUDBnSSUQ5Icp79aCRNkno583dDc09e
 Ur0x3EORRJZRS2cqwOKb/Va7E93p018WorMOHde7YaklAtfS2CalLIDc4xN75Nubq/dgDQ1cV
 QROGw4IBFzFXx7JvqYZ2NUEPEjJP9GCrlFTpxzyiMapI9asRIhzmUjYjMHpd5mVOOZcDzhcEI
 tul4H4oTcXrs5PHPsbtE/uVxjTlzETrXVhGYQtfwBLd6rFpHsUxt0p8gn+8uN7AH3SWLwnU/f
 0GQ6MLzv2VkdalLhEzi7riSBP+lL2AYsAhEte04DxvsGJZ7vcZyMTm8L8ZdOHAb1uQpKb7mcu
 0qxqU15D7FZjheuMEHblCny+qOrFXN+KcnRkI5+Z5o1O/lj5dgKA4A/PrBV6pLeE8v0pS4/M0
 B/PLvUNYNYwgclaCdQXzzL3949yQ5K9kfSL+QeT0uOVATFPewkks/MH0LvrClWVLum3A5V0Gw
 d8aeeRya6ItgyTKG10Wmcp9A6INrpTlVGhXmtUeWo/gLVAqkRHOhLoch7yy6NDTQq5C/kKYDD
 rbBnl3Wzz4Ov4+kBzYnCJIyC/xTWY6t2idh3ja58hwgVk6F4ltKyP35gUivJJ3cS3xNcwxEbT
 PdQSj1WMcx/b0BARohutAveCoi/4FR3lICPQpIb5wUzB0f6TDMt3jm4hMbOktd/ohF02Jq7/k
 9Jqd4MwFxSTjs7ur36IV9za7GZK21D9cIQVqhNHGvJ1lUnWsIxe3kPP2sudQjViENwNUDhjw6
 oPWI8aQNZKSrCbUHsKqOVJXoF82Qu3etC7T/0UM0YFrWk=
Subject: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1701
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/bf850b64-b4bc-4738-9086-43018b8fbe93%40web.de>

Hello,

Source code parts can occasionally be repeated.

* Loops
  The control flow can contain ordinary loops.

* Recursion
  A function may be called by itself.


Such constructs trigger special consequences also for further data processing
with higher level technologies.

+ Computation tree logic

+ Linear temporal logic


I am still looking for clarifications so that the Coccinelle software
can be applied in safer ways.


Regular expressions support some search operators for quantification.
A notation is accordingly supported for the specification of a minimum number
of matches which would be bigger than one item.

I imagine that such functionality would be helpful also for the semantic patch language.
How will the chances evolve to extend corresponding quantifiers anyhow?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/23f7738a7881b02d016d278ee293cfd4a126fcab/docs/manual/cocci_syntax.tex#L793
https://github.com/coccinelle/coccinelle/blob/755250323b80f27701e78d325cc83509197b33b1/docs/manual/cocci_syntax.tex#L793

I would appreciate if multiple occurrences of code elements can be better detected
and transformed.

Regards,
Markus
