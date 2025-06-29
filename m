Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A9BC7EE39
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5Ucj8Y53B0zOQJVaCKcmlhwA56JQBNGVSTVuqfQ6V5w=;
  b=fR91a2wPrR3XjuhMLceHv881rc9SunudxzWir8sqIFZP68aY3y02V/k2
   8EpoYQ9IMUsebEs75Dd5Vq9wLcFZq/Q1K3iNHVLnkSPKRcUWWh/aa8BFK
   GSrLRZ9DQTIPTzaj6vN5EVQZn9WhrARNRw11srIIYUZJ14bt7L2oNkb9G
   0=;
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
   d="scan'208";a="229462989"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 15:37:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A3950E0157; Sun, 29 Jun 2025 15:37:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3202AE0131
	for <cocci@sympa.inria.fr>; Sun, 29 Jun 2025 15:37:02 +0200 (CEST)
IronPort-SDR: 6861417d_UgoBRaeoKxXMVp8zY89NmO+TtY/+Bkj26hn/9yOcgETF7/D
 qg65ZjTmPJZL3jrlRtEbjaN4mqdx+Qr55i4ZKTg==
X-IPAS-Result: =?us-ascii?q?A0GrFABiQGFogAQP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAAotyAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWBgEUA?=
 =?us-ascii?q?QGCfoIiAQYQAQMOJAeyaYEygQGCDAEBBtpeHywiWIFlCYEbLoVtgmQBhieEP?=
 =?us-ascii?q?CcPgVVEgTwLgng+hEODW4JpgiaBFoR6kzVSeBwDWSwBVRMXCwcFgSBDAyo0M?=
 =?us-ascii?q?SNLBS0dgSd/gU0cgwmBDoQsK0+CJHWBeUEZQYNdHgZtDwaBIRs2QAIBC209N?=
 =?us-ascii?q?wkLGwY9kluHKsYnNAeCOIFmgWQMn2kGEAMvg3GTWw4GkwKZBSKpGoFoOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiGEM7xgQTU8AgcBCgEBAwmFRgEBik+BSwEB?=
IronPort-PHdr: A9a23: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
 8SJi6/5bjtPoYq8FS40GMXebs6KYiJJDA==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:nVwvi69ymmqx1NfRYrluk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: =?us-ascii?q?9a23=3AWFMl+2kPIvJrR7kFZbhWDADioGHXOVPyzFH5DkC?=
 =?us-ascii?q?dMjs3b6y3EF+W6ZtFlfM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AqbCIBwywTozqIPfd97XEzhcu4A6aqKiDDlAOvbw?=
 =?us-ascii?q?LgpCnMjR9YgiN3AWwQqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229462988"
X-MGA-submission: =?us-ascii?q?MDHaGZ8uSEOIhabXn7gzT4flIkcxFWOKSGv/nB?=
 =?us-ascii?q?Ut/B2EzaUBlNBMsK/aS43ZcmN4tcv6YYxj9gdv2IUxL3z9fOY/UOlM8p?=
 =?us-ascii?q?k/8yowVeBRIxLr0NCLrm2KsFDN3fD3emgNkiByqbVHEShwOwsYlayIAd?=
 =?us-ascii?q?Pp5XyvJ/JokEnrfEeBoLErYA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 15:37:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751204221; x=1751809021; i=markus.elfring@web.de;
	bh=5Ucj8Y53B0zOQJVaCKcmlhwA56JQBNGVSTVuqfQ6V5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qWXp8lCHCEp85Kdv9Niyr3sVEFm21lnMtSiFmnE07DuyZBfGru2LPuOGIVNQUm3o
	 f4xvCGoiua68lIrQAFuiV9sBs2KeLbLkElgquWDvOVbbfgit0wLMpiQLnvJX2BdEH
	 Rkn6tz0iybCaFqup219EfmNpDBRHwEwOEeJZAarUA7Au8hMNz0/Moow9CeLNvGJc5
	 +1Dcz+QJlUAxIcXbNRfvhh8Og0rEYGh1w55KlCRxqOMAJ2LS/21fk6a7C6For9Oc+
	 7zT9Ite2QXXhBq3p8qS+MmrEWVWnAHQTDVciJVkIhsfXcu5bJy52IXT52Zb5F4i71
	 lFC/ZXWxk07W9LFZTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1uV77D37Lb-0009ic; Sun, 29
 Jun 2025 15:37:00 +0200
Message-ID: <36062929-58d6-424c-acf8-8cdab4ffa738@web.de>
Date: Sun, 29 Jun 2025 15:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bd0e8447-49a9-4bdc-a642-05cb48d54384@web.de>
 <alpine.DEB.2.22.394.2506291528480.95572@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506291528480.95572@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUJknxotQd6ZDY/awNCXBVLOE2rv/Qxqw5W0HWGUTto37Y5c6oJ
 1PbeLzpdNoH2/wK/hcNITJP1OFLDjfC9b45J+6uJQpX2JICaGd4p6xWVsVAAtCWfHDTp7bE
 90VyzNjxu0npATTS0LP3AuGtIZA+UiB5/q/Or5RcQBSNxHvV6NIhCRL+y7CBwaHtG7cw5Pk
 AedqEOb2wBM6it6BvwTBA==
UI-OutboundReport: notjunk:1;M01:P0:C3yYc/ZVvjo=;+jQYkYRt9xirU2SA6DYgaoymr59
 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
Subject: Re: [cocci] Searching for longer conjunctions (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2812
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/36062929-58d6-424c-acf8-8cdab4ffa738%40web.de>

> I don't see the point having both cases.

Do you expect that the following source code search pattern should present
a bit of diff output?


@display2@
expression a, b, c, d;
@@
 return
*a && b && c && d && ...
 ;


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_return_with_=
four_conjunction_items_at_least2.cocci include/uapi/linux/cec.h
=E2=80=A6
real    0m0,149s
user    0m0,116s
sys     0m0,033s

Regards,
Markus
