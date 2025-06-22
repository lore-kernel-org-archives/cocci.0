Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE4FC7115C
	for <cocci@archiver.kernel.org>; Sun, 22 Jun 2025 07:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=pUAFvdB+RxlnEE2WCaV1xD+MXjeXakWSyyvkaNSbJog=;
  b=dsV+xPk6MIuDy4PHDkHRB8Q85Eze6gMeqvnzQexDSrFkRliEKX0w071S
   MYoKIfiqkCYzK8HF2mPEsAUiJv4QzlMdwLEoxvq1Ww4EVK23WsknFHVDn
   WpG62ekoYR4Z0JqcInqO/KHt0gJ5szMagTnlQ+05SLnzmTafBl0Dtkoe9
   E=;
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
X-IronPort-AV: E=Sophos;i="6.16,256,1744063200"; 
   d="scan'208";a="228352698"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jun 2025 09:30:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 47FE9E01A8; Sun, 22 Jun 2025 09:30:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 855C7E0131
	for <cocci@sympa.inria.fr>; Sun, 22 Jun 2025 09:30:35 +0200 (CEST)
IronPort-SDR: 6857b11b_QacsBzuFBEGtLdz5Lo6uD25O9c8f/+9dsd5XGjE17AYb4nK
 6z6IhlXlI7oDLd2F9vLKzEtAX3qKkQQCCUZYaPg==
X-IPAS-Result: =?us-ascii?q?A0GQBACtsFdog07ASNlaHgE8DAILFYFTgkSBAAZUMwQLS?=
 =?us-ascii?q?QiETY9Qhl+PD4h3gVWBfQIPAQMBDUoEAQIEAQEDAwE3AYFUjl8CHgcBBDIHD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4V7DYJbg?=
 =?us-ascii?q?SyBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?kdtHQEBESc0AiYCcwEBgn4BgiEBBhABAzIHDQauGIEygQGCDAEBBoFYQVDXd?=
 =?us-ascii?q?R8sIliBZQMGgRsuhW2CShoBBW2KGA+BVUSBPIYiAQOCK4MOgmmCKIEWhVGEU?=
 =?us-ascii?q?I5ugUocA1ksAVUTFwsHBYFjA4EPbjIdgSeBAIUNgRuERStPhSBMWoNgJHAPB?=
 =?us-ascii?q?oEhGEACAQttPTcJCxsGPZJmhAgtLJU7PJEyoUI0B4I4gWYFgV8MiQeBJpU7B?=
 =?us-ascii?q?hMvl0sOBpMCmQSOB5VahVmBbwEygVwzGiSDNk8DGQ+OOoQagQvHK0E1AgkxA?=
 =?us-ascii?q?gcLAQEDCYVGAQGKcIFLAQE?=
IronPort-PHdr: A9a23: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
 DTfpJhirgP++gFu4j9gTQYItTtBwo6G7x0KBA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:UrmBV6pXlJHOf496F+tq0FgaV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: 9a23:XhZD/GCCNxywKg76E3Zr9xQlE+c0S1rYzVneCkGHAnRKbITAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AA3eeJQwF5c6skGhmys9KIbGcXzuaqK7+J04o0pp?=
 =?us-ascii?q?FgdKVGxV6ZzqhhRqrSaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,256,1744063200"; 
   d="scan'208";a="228352691"
X-MGA-submission: =?us-ascii?q?MDHBf+hlh3I5pukoVnQkbj4FgwPHioERQItOAE?=
 =?us-ascii?q?MZCg1rw5CyTL+RQkyPCsh0feV0BQfTAQFKa26MISfOI/XmdzoXBt1YED?=
 =?us-ascii?q?4MHcH47Wn7yZqQfTMdnzDeLlLHa2qIWDb0113/wLYTGRzgZVanOvOOyq?=
 =?us-ascii?q?2jlPx5rAQDP27utw+14X8Dyg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 09:30:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750577434; x=1751182234; i=markus.elfring@web.de;
	bh=pUAFvdB+RxlnEE2WCaV1xD+MXjeXakWSyyvkaNSbJog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FQCLKx1W99KjfspKCG7at7C+DbOd+V9Vd+LKXDeAJRMP0F8OeaqvCNDKBBdEgnEw
	 ce8rAn17/G1eorTVGDGTt/VBBpFeFvGkpT2gaZYDHMaSTmRURucvHArXfTlnDzxfY
	 ++x3uoa/sjq+fIH9aFlhKpAqU5nWTV9RR1YW0dFEAjb8eEDoSpiqe/3649/bfTmAZ
	 FMrQCoR84FohrlfKXnKyRS59kMguC83gj41q5pSL2G430xl1YuiyPlFIrwk9UsIUr
	 uYgosXkxHOC4ophzbWU9v5qn34MLQIJ83Cic+X4HMQqmUQZbHX4iOVZKlP/2ff5nD
	 BsxJKQ8P/ag8IwQeng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.181]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1vCBMb2zW8-00ajjw for
 <cocci@inria.fr>; Sun, 22 Jun 2025 09:30:33 +0200
Message-ID: <2dc257b4-d310-47dd-90ea-9b081727be2a@web.de>
Date: Sun, 22 Jun 2025 09:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n9K31SmflB//VxjJFdWD+k/6mBxHfy6ZCUDz4g1yhevQqYJkHAs
 jNRKE5KZf/bCeYbuiayrgauqE8+YNIjpXku9j0Da05IXPma5z/xq9pTz/0WAcEL4xpHwWsE
 0ssffX/UrH5Noh41L4LwRBsRandOamUYEqfflD3mNQZWR1pNbHjwFr7iD3eKfIQ6Feswe81
 zI1XrN46BryU9MyFf/tIg==
UI-OutboundReport: notjunk:1;M01:P0:XRAkQaq1knc=;spN+NfzmznKxPa32xSk5FJ2trU5
 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
Subject: [cocci] Passing code replacements by APIs (for SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2792
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/2dc257b4-d310-47dd-90ea-9b081727be2a%40web.de>

Hello,

The semantic patch language supports the specification of source code replacements.
Such replacements are specified within SmPL rules. The evaluation of several
SmPL rules would trigger corresponding software run time consequences.
Thus it can occasionally be preferred to combine some data processing selections
into SmPL disjunctions.

Desirable source code adjustments can also be generated into SmPL script variants.
I imagine that it can occasionally be nicer to avoid such script generation
because the Coccinelle software can benefit also from source file analyses.
How will the chances evolve to extend application programming interfaces accordingly?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/c52d87d02775dea45d51a3c9440646525e4b5f29/docs/Coccilib.3cocci#L26
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/c52d87d02775dea45d51a3c9440646525e4b5f29/python/python_documentation.md

Regards,
Markus
