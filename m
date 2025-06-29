Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85155C7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=CNi04PE5CN8zMzye/AumYFAfP0YcwbAKCyrGOF06oVg=;
  b=hsHcgtwgc8e1vZvy3B+f2ib+lpQrWp1saQbn5M+hrStJXUrcEfDD0FNa
   +ed/kszkF4wrwYWU4reaorCIw1fr6cSninWrTFp9XaqwXnK0rhnpesiVB
   szZQFhviTOhnE0jgT9gTKYOttPNqWB14ZWH65cciK8Xn6vjWPL3e/63Gg
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229461738"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 15:05:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 33925E0157; Sun, 29 Jun 2025 15:05:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4625EE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 15:05:29 +0200 (CEST)
IronPort-SDR: 68613a18_3E0UCp6XPMlZzTXo71p9/YVZsecLSjW5AwGoSEo9BbSL28H
 WkGk4K3iaF8FVNvXNWHlSov+AVWLgkvdSETrppA==
X-IPAS-Result: =?us-ascii?q?A0GvIgA0OWFogA4P49RagQmBU4JEgQZUMwQLSYRVj1CBd?=
 =?us-ascii?q?IRrhzyHU4h3g1ICDwEDAQ1OAQIEAQEDBJB0Ah4HAQQzBg4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAkdtHQEBESc0AiYCcwEBgn6CIgEGEAEDMgeybYEygQGCDAEBBoJp1?=
 =?us-ascii?q?3UfLCJYgWUJgRsuhW2CShoBBW2KGA+BVUSBPIhRgw6CaYImgRaEeoQYjx2BS?=
 =?us-ascii?q?hwDWSwBVRMXCwcFgWMDgQ9uMh2BJ3+EcoEOhCwrT4USQVqDXSRtDwaBIVFAA?=
 =?us-ascii?q?gELbT03CQsbBj2SW4JlgVKWIpE2oUI0B4I4gWYFgV8MiQeWYgYTL4NxAZNaD?=
 =?us-ascii?q?gaTApkFo2OFWYF+JIFcMxokgzZPAxkPklS8YEE1PAIHCwEBAwmFRgEBik+BS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:H7EtdKnxcc+94vsX/38LCurhzCfpDfIO3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE7wr5OUtQ/exoXZPqfZqyz/FICOUqTNWftWrd1ldATrsP0WKK+VSJdhEWndQtsJ
 uIHZIfNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9J/jJjtWLD2DcMtbnmFE4+ugYzRLrIIqP/AEKK
 Y=
X-Talos-CUID: 9a23:1tXfT2Bl2h3oq5T6EzVJ034IGvgYSELYwm3gP2uAKUt0eITAHA==
X-Talos-MUID: 9a23:IIb/AQmonbP//D1cmZK/dnpeBf5hyq6vT3kp0oQWn8SqDTZofAqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="120222183"
X-MGA-submission: =?us-ascii?q?MDHXQlxq9Qn9Pjg1styAcPawOrnuhWEPwbHu0v?=
 =?us-ascii?q?TiGnkqVd7l5yubqO9DK6BH2NrqW58RtKKdAucgOcqK8/+zmOfgF7hUnF?=
 =?us-ascii?q?yyoke837fEZa2An34pSQPga+fp14sYUDuo94f5I9mPcXAd44Hp7DY/ko?=
 =?us-ascii?q?qNl2NoU9iMwPvSCSCAbHIsHw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 15:05:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751202326; x=1751807126; i=markus.elfring@web.de;
	bh=CNi04PE5CN8zMzye/AumYFAfP0YcwbAKCyrGOF06oVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R7bY2sbdRRKqVcp+Q5VEQ/XWJ0Om10ZABTMqRQV/ESrEFbee7aLl9AIugnDBckY9
	 r7YAPy4dDX3zROk/wCEr3Ars8nJJK4fisDenXFJRvQq7AnKdC/pjxCFOp++5zsMfS
	 j6GL8sRwZRZrQLgLX+TRykn2z6DkLP/h1u9IxF4Wc0DZ8yu5l8efbaUYmKWquMg/7
	 XZQeRKEchjuc9JRnKHhGUQVHTG1HJ3VsL4cnN+Gw+hVjYRRXZgt1ABfHcaIdbbdF7
	 q7DwyN1b1GTRCd5/VZT182oOCDdqR2Ok/RXuDlwLQtMrW1lxFFh+4LvjiDDzqZ4Mo
	 qnTNja/HnA8cstGP+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1ueq060U1g-00zOzo for
 <cocci@inria.fr>; Sun, 29 Jun 2025 15:05:26 +0200
Message-ID: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
Date: Sun, 29 Jun 2025 15:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zVvCdgBzrpFzf1HcQWKg8CirWwXPD28SSS1NE1o4qvEez/rRLHv
 5ZN75bcKXlAkACrzZzZybdfvPJcRHqQcE3hQt9V3RINdDQfgHSvWjPiXWjrAqADvppx0J3n
 bvjm5hSya76NipZtVRsR9J/MI/OEJr6NSxF4Q4zngsUnQZ1WzkeXLMjlI3pjed6qlnDDeG4
 IYgX/IRVzz2ZeUZMyW3Yg==
UI-OutboundReport: notjunk:1;M01:P0:3FOhiwczSgs=;lZyWeUYRkbMR7tq8BF+IBlITW9P
 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
Subject: [cocci] Searching for longer conjunctions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2810
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/bd0e8447-49a9-4bdc-a642-05cb48d54384%40web.de>

Hello,

Is there a need to refine a source code search pattern (like the following)?


@display@
expression a, b, c, d;
@@
(
*a && b && c && d && ...
|
*a && b && c && d
)


Would you be looking for more powerful data processing systems for further
static code analysis attempts (also according to Linux source files)?

Regards,
Markus
