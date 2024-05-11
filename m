Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428C3C04FFE
	for <cocci@archiver.kernel.org>; Sat, 11 May 2024 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zwpq5LAg0EZzpHfuHSqIk5AoXXH6tEC8lW81eNopunk=;
  b=DPoD1Ut425ao17UJ1V1X3lCjuapTMT+t3kxiTWGtMSBrdmdGVrrFe7EW
   gOu26IQQm/eM8Xas7yA/US9OujIA9j+eOiFX0HYL8mpuXZtvnpmcFLTNK
   2VPqouLf9zb+V3nNlsB4WfR5/avwzt/6IpGOQRPkVYlcAlkGtdTGqBS2o
   w=;
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
X-IronPort-AV: E=Sophos;i="6.08,153,1712613600"; 
   d="scan'208";a="165181620"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2024 09:15:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C2AFE0AF1; Sat, 11 May 2024 09:15:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ACEEAE004E
	for <cocci@sympa.inria.fr>; Sat, 11 May 2024 09:15:27 +0200 (CEST)
IronPort-SDR: 663f1b0f_h7jnJh9K6GSXcz4sUVRAGAojU5yb4Mbq6PgWby8s+g5lmrv
 YuAjf+paIo69j3CzGH5tAfkRgKDnYmlLVcKWwuw==
X-IPAS-Result: =?us-ascii?q?A0FdBQD8GT9mhwMP49RagQmBT4JEfARUMwQLSIRWg0+Le?=
 =?us-ascii?q?YF1MIQ7jwiMBz4PAQMBDTsGAQIEAQEDAQOCC4JqCgKIPQIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CYBiBD?=
 =?us-ascii?q?l5HAQEBAQEBAQEBAQEBAQEBAQEBAQEBARQCRyIBHwEBAQEBASMdAQERJwQLC?=
 =?us-ascii?q?xoCJgICVhsBAYJ8AYIvAQMOIwcNBrMVgTKBAYIMAQEGgQjZUR8sIleBYwMGg?=
 =?us-ascii?q?RouiC4BijwnD4FVRIE8C4JHMT6CYQMBXIECTYMOgmmaJJBPVH0cA1kyAVUTF?=
 =?us-ascii?q?ws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDCAQDEDQDIHERAwQaB?=
 =?us-ascii?q?AsHdYF8gTUEE0QDgTiJdgyDMYF3KYQdCENsFYN2gXcOYYNahTeBLR1AAgELb?=
 =?us-ascii?q?T01CQsbBiIBHaM3hHuBHcZgNAeCNoFggWEMiiGVIwYTL5c4DgaSaJhijXSbE?=
 =?us-ascii?q?4F7JIFcMxokgzZPAxkPjjqDYTOEYcVwQTUCAQEBNgIHAQoBAQMJhUYBAYNag?=
 =?us-ascii?q?UgBAQ?=
IronPort-PHdr: A9a23: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
 zRxIRslRly46CRFnrNgFmYH4nc3dYG5
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:SPTIuqDhMqrcinjlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:xS7bOWEr80z1ogBAqmJsyGJOIuQjXkGD0Vj3HEOZOXhxZ5m8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AHUPhwQ9l6hKb3ChCjVBBfxWQf8FS7IiPNlg/q8Q?=
 =?us-ascii?q?lnsnZCBRKeCXC0jviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,153,1712613600"; 
   d="scan'208";a="86762335"
X-MGA-submission: =?us-ascii?q?MDH19+RAc/6w7bWuM2s7jP3tGzmfDYRpypXx39?=
 =?us-ascii?q?JrFyS9sOSG5w+b+CDmSUjk5QXMc8yXNjTtr4awOvfn0mBcIif7JSwGR4?=
 =?us-ascii?q?QdxaHm7SVThNRgnyfS/HGiMxbdXoo+M2lqYyzVYcd0g7uXRfYa7Dfdcb?=
 =?us-ascii?q?EcfdWgfe5xAxa7DQlr1SiMiA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 09:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715411726; x=1716016526; i=markus.elfring@web.de;
	bh=zwpq5LAg0EZzpHfuHSqIk5AoXXH6tEC8lW81eNopunk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Vu7IWxMOJ7YXYl6aQ6SwUy8bA32Wib29HyCwjJ4pHHr+OASpF9aEXkC7H1Ty5ZDk
	 /ss/UfYRh47q7Qm1Go3AmNmJrtLTNCzK2mBTz/LnGHdnMpnX9Fom8SpKsbbhwGQ4x
	 PD2I3EM2uKn0kUU/XVm816x2eMHXyOlTpuwzgIvJnp6Y2HIOQe/YgZZp0kjSv4Q6J
	 h4JyjBlHSKqFDPf8faCESq/Oiy5sBKbXTw35hAFFu9DaOduBDMqExiSPmOa2EMwiC
	 QYlih5hG5xqG/MJjorfocr64OzLbo9fqT2fV8AoU68TzaKFOSSAoEy55UTbWtGS6o
	 XDJIdvVFVjOqtm8hfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1sgTdW45X9-0178NF for
 <cocci@inria.fr>; Sat, 11 May 2024 09:15:26 +0200
Message-ID: <05e493f2-8918-435d-879c-7b317d392fc0@web.de>
Date: Sat, 11 May 2024 09:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PoHrxcrDM1HzCmcoiW/1mJBbD0+l90SXKtEb7knT8nvtChmm16l
 10rJ3QsksiXyldPaxZWMwnn44uNMYB7wkTtzUrah8aZq+2qZvK0ZblBbstpOHJLC0v74RDh
 aMp84cqpua9BT6JcE1Hcb/5XfOkcFXpy1hdSidLUEhuAZCqZAOCU1XzrjNT0LEYJAloE2fd
 YqRLyGflCzlybFPO95jzQ==
UI-OutboundReport: notjunk:1;M01:P0:5pkiSF4D0BE=;f/SJMTFHuzjcmhVVc00vv+Qh/0A
 D9Bv1C77XUuPe648apVQn/2w1JNoJr/bdySO2uEkvgQq1mRnfpUFsbAlOPqT6NiqssrkTDN3w
 2Zh0mQ5xZPelE9lXW4o+KF/ZeF2keyqeu/JtFUfSJ/z4ozTWJIBP08yurg9LfxxiZa+wN1Avv
 4exkHj7PgKaB42H2yA+ZPkK2MxEiYKUFDrxKnBuuoRb+vOtWjFPYS1yEVhCgv4F2lC1ClRGUf
 2gOMn4y7fmqdz9p1PFZdBSZuZY0eRDUaHH5io8FHIxMv7KyfroJYe5v4eUSrMkOfUU9rVcRwm
 /pLBw6lSLdq2u6B5HypSS5nymAnB9ooq3JzC3AxfVUZm09i7LR7mgHnp3RYoVblM6cReyjIvU
 9ehHdXaG6XnHswc3eHFf234L91tXyT7VlaE/dxYN4C9kwFWSkNG6vAbA3f6wKhyAhk/1TlUBP
 O3AIZ3ll8YGtme6tryK+DaVrECuD7AZNJdv5ati6JnRYKXk6aU2TjZwNmmjSYEA66pP5UowjS
 e8MhserSxfd+27QmrjAn3w3b53OPHxr3YCP8fPc8B/f2FpUucOM+FQ7Q0XZ6QJuYAgVysmOrW
 p1fok9Zx4TRMau38N1M0612+jQomfMg3p/TW0vB+98ffbFLsnT83RqgYMqujmXPYK8QLL6WiP
 Bj+72R5BEOnSSUcXioWnzqlvHy56mZQ9bJslfpmvXcm4UOZq64Z+vroQw/nxqHrfkzJKHaeFH
 BXy1478pvXHwz4IMZainin1U2KwD7P3qCHOkY0HIJPYY0VHdTsFIbLladunmaI5LfKnEKePuA
 DtGNG5kIB6HRfSQuxetd3NUKjYkV6K+raWdyCJgAHtUyY=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1712
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/05e493f2-8918-435d-879c-7b317d392fc0%40web.de>

> Source code parts can occasionally be repeated.
>
> * Loops
>   The control flow can contain ordinary loops.
>
> * Recursion
>   A function may be called by itself.
>
>
> Such constructs trigger special consequences also for further data proce=
ssing
> with higher level technologies.
>
> + Computation tree logic
>
> + Linear temporal logic
>
>
> I am still looking for clarifications so that the Coccinelle software
> can be applied in safer ways.

Would you like to acknowledge that data processing is influenced also
according to handling of loops and recursion by the means of the provided
technology =E2=80=9Ccomputation tree logic with variables and witnesses=E2=
=80=9D?

Do you find a paper like =E2=80=9CCycle Detection in Computation Tree Logi=
c=E2=80=9D
interesting for corresponding adjustments?
https://www.fabiomogavero.com/publications/jarticles/2018/fmmps(ic18).pdf
https://dx.doi.org/10.1016/j.ic.2018.09.007

Regards,
Markus
