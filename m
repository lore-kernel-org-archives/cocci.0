Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FB0C7EE30
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FBW7f8MMxU6GiN+NCEKdFDOjnYvQrz0b1FaUrqcP6T4=;
  b=EutKaVDil10BgzFH/xwYiy3B2nKHZCrlclqaVz6nEIib+o4718NU1JuQ
   vccVymPop1EJdEnl8iwCr9UBuyxhdMoVGWiXg+WLOQv38ysleorOxQlgA
   oNK6FJgvk+eoGI7zwY33wAXr3SotfusOSU/K5oz8MEv9Z5NAPS2wXIIOV
   4=;
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
X-IronPort-AV: E=Sophos;i="6.16,274,1744063200"; 
   d="scan'208";a="229451889"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 10:19:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3B46CE0157; Sun, 29 Jun 2025 10:19:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A9E8FE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 10:19:04 +0200 (CEST)
IronPort-SDR: 6860f6f7_JKG1yDn1OcYtbC+XStRnQLVDdRpCh6EZRrgSVAOT9G9Czs6
 vhKku2enTKcYYgXlFv4qpcCxVLLoMyYwLH78/bA==
X-IPAS-Result: =?us-ascii?q?A0GJBgB+9mBogAQP49RagQmBU4JEgQAGVDMEC0kIhE2PU?=
 =?us-ascii?q?IZfjw+Id4FVgX0CDwEDAQ1ECgECBAEBAwQ3AYFUgi5BA4t2Ah4HAQQwCQ4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEXAg06bQQZAQERJzQCJgJzAQGCfgGCIQEGE?=
 =?us-ascii?q?AEDMgcNBrI8fzOBAYIMAQEGgmnXdR8sIliBZQMGgRsuhW2CShoBBW2KGA+BV?=
 =?us-ascii?q?USBPIJSg1ACAoIrgw6CaYImgRaEeoQYjx2BShwDWSwBVRMXCwcFgWMDgQ8yP?=
 =?us-ascii?q?DIdgSd/hHKBDoQsK0+FEkFag10kbQ8GgSFRQAIBC209NwkLGwY9kluEIz8ig?=
 =?us-ascii?q?iaTL7J4NAeCOIFmBYFfDIkHgSaVPAYTL5dMDgaTApkFjgeVXIVZgWg6gVwzG?=
 =?us-ascii?q?iSDNhM8AxkPkiEzvGBBNQIBOQIHAQoBAQMJhUYBAYpPgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:N2Ba+a81rSFa+li824Vuk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: 9a23:7ZRNZ2AXIfwpMx76Ew5M0k4uBeZ8S12DnHHQMmLgEj10YpTAHA==
X-Talos-MUID: 9a23:2/YoKgqVYtj2F7Aj/6AezztrJph6urTzNBgMiL8NpdCPb3VRAA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,274,1744063200"; 
   d="scan'208";a="120215316"
X-MGA-submission: =?us-ascii?q?MDE3VQR9/bS+2FzixIKl6QG5UynugIFKz1tya4?=
 =?us-ascii?q?r5sEJRh6sfehZGLCxMZVt0zmzvVTp0mBVH2Jf/JgQbegjSKtAIfD0/nQ?=
 =?us-ascii?q?dgL/YAzLft2DHrG1aE39NDefYSEZn6oZcUEC4ky9qsT6KQ5FBNuVy3PV?=
 =?us-ascii?q?8OhOTyeclDavM6qrVOQ9odlA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 10:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751185142; x=1751789942; i=markus.elfring@web.de;
	bh=FBW7f8MMxU6GiN+NCEKdFDOjnYvQrz0b1FaUrqcP6T4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wkiJhHxj2V0ME8Vp02aNYT7Hpxhqb1I4EkoiJZWRVW8QJmtOzN1wJ58Y15PEIpdv
	 a3RrUgUlmJY2e2ncU20ThLRUqYAB0nMUyq+ZqbaYvvzb2Q15Bz+OJbjaTBl9MOhnD
	 dAf1dMt3kEXNioMZL1gofbslAypY41lNEyW30J0fgNQQ/thnhksmgPZyyWPS1Df2d
	 zh+dlQj0DnE9v6VfXFqM4dwfUAd/2VkGmjFIf0G6sV/NPZ97S5/spM1FQ5vX6mzDn
	 0Bz9i1Q9mxiOkCxhfS6NFZppMvHqDQpzaAc9AV2uOmPlm/FEeaXpzVZ1CE75dQsA+
	 p1GFoS3KHelQcwe6Fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1uKQYz1Orf-00RePv for
 <cocci@inria.fr>; Sun, 29 Jun 2025 10:19:02 +0200
Message-ID: <fd69d396-7dbb-4d57-ae4b-666e30825cee@web.de>
Date: Sun, 29 Jun 2025 10:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qa44Bt22v7iKT9MOIq5+/x8Hx0rHrI9CkU88OON4HldpQTOxWmf
 g1l8GJFLqbbn7TId6vAR2zso2sXmD26NEND+dMddLmIQj+N3mmFs2V8ql8HcIGZjAddntuW
 2CtK+0utQJC3yEjknu4kgJZS3BbkLVQmmI2VHDeoGhFruHE/UKktWINI6xB7qVgNTfzGCZJ
 MV4hpeGhM2zjcBN1yjj+Q==
UI-OutboundReport: notjunk:1;M01:P0:+j4xHTZ31xU=;BfHXYTYFjfOAGtVenB/QOx7L5fa
 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
 Hhc3hfNg/f5nCcYEI32LsiEvVgcXK9Gs=
Subject: [cocci] How to improve the software according to stack overflows?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2809
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/fd69d396-7dbb-4d57-ae4b-666e30825cee%40web.de>

Hello,

I converted source code from a known function definition like cec_is_switc=
h()
to another script for the semantic patch language.
https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/cec.h=
#L1189-L1199


@special_display@
identifier las;
@@
*las -> num_log_addrs =3D=3D 1 && las -> log_addr [ 0 ] =3D=3D CEC_LOG_ADD=
R_UNREGISTERED && las -> primary_device_type [ 0 ] =3D=3D CEC_OP_PRIM_DEVT=
YPE_SWITCH && ! ( las -> flags & CEC_LOG_ADDRS_FL_CDC_ONLY )


I observed questionable behaviour (with the software combination =E2=80=9C=
Coccinelle 1.3.0=E2=80=9D).
https://github.com/coccinelle/coccinelle/issues/30#issuecomment-3015721749

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --parse-cocci ../show_cec_is_switch.cocci
=E2=80=A6
Fatal error: exception Stack overflow

real    0m3,852s
user    0m3,742s
sys     0m0,108s



I omitted the forth conjunction element from the shown expression for anot=
her
software test.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --parse-cocci ../show_cec_is_switch-reduced1.cocci | grep '^|' | w=
c -l
=E2=80=A6
255

real    0m0,150s
user    0m0,133s
sys     0m0,028s


How will development considerations evolve then?

Regards,
Markus
