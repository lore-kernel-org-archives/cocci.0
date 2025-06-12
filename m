Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF857C61CE8
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ynqVteSJ3yJhSmkE4VHWLviCYm2u44T+BWvuYH23Yls=;
  b=eMp6eaiVeRBlkjQe4me+GC2oRRJynqmhXiRRjDJWN0uqbdWlWdMCnfEl
   60xwEJyYpbc+RtjzswoEMACrw6q/K09w2wdD1Iv0lBrYknWDkrXN95VU2
   QTWF+mEGWM1l8jpDi9YjVREkktc5ZmQ8SD7/Tsj5zee24903p/54UbExb
   k=;
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
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="226879923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 14:54:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 874EFE0AF1; Thu, 12 Jun 2025 14:54:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 06A38E0131
	for <cocci@sympa.inria.fr>; Thu, 12 Jun 2025 14:54:10 +0200 (CEST)
IronPort-SDR: 684acdf1_CSHL7AxB48nVJ+FaXtZ51ifVpZBfVZ7jOTw80fQkg7Jp2r1
 +Nzv1BB2dvwC7OUwLVU14BLDxHlkHYSwz1mguTQ==
X-IPAS-Result: =?us-ascii?q?A0FJBQCEzEpogwsR49RaHgEBCxIMQIFIC4JEgQBaMwQLS?=
 =?us-ascii?q?YRVj1CCJIQ7jw+Id4NSAg8BAwENSgQBAgQBAQMDAYIMgmoKAotnAh4HAQQzB?=
 =?us-ascii?q?g4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06RAEBAQIBIx0BAREnDwsaAiYCAlYGARQBAYJ+AYIhAQYQAQMOJAcNB?=
 =?us-ascii?q?rFAgTKBAYIMAQEGgUYCgSHXdR8sIliBZQMGgRsuhW2CYwGGJ4Q8Jw+BVUSBP?=
 =?us-ascii?q?IJSMT6CYQEBAoElOYNbgmmCKIEWjRaUCFJ4HANZLAFVExcLBwWBIEMDKjQxI?=
 =?us-ascii?q?w88BS0dgg2FGR+Bc4FZAwMWDwGCJIFeHINCgSOESStPgyKBf0wZQYNhHgZyD?=
 =?us-ascii?q?wZHQAIBC209NwkLGwY9mH+FKoFRYJMesxw0B4I4gWaBZAyKLZU7BhMvl0sOB?=
 =?us-ascii?q?pMCmQQijWWbMYF+JIFcMxokgzZPAxkPjiEZJYNCM4ELthtBNQIJMQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYozNIFLAQE?=
IronPort-PHdr: A9a23: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
 hFOzb6qdewu
IronPort-Data: A9a23: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
 lTZiYyJrI9XhKIx/Qtdl6ZpJSwk
IronPort-HdrOrdr: A9a23:kAuvJqjjmWKfMewj4Hvr9BOmn3BQXgQji2hC6mlwRA09TyXqrb
 HLoB19726MtN9xYgBHpTnkAsK9qBznmqKdjbNhXotKGTOW31dAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQlTuRRjz7LqVsLjM2fabR+a
 DsnfauLFebE0gqUg==
X-Talos-CUID: 9a23:e5Hkx2GrW30SYH3oqmJj+BAaQpsVeUbt5y/8GnG3J2A2WJysHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Aamo0aw36pSi4SzL+B6bcNAXI0DUj+YuOCnEWsK8?=
 =?us-ascii?q?659THBAd8GS6SgCaJa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,230,1744063200"; 
   d="scan'208";a="118893778"
X-MGA-submission: =?us-ascii?q?MDFXQpUjQ2fDnrvTgkz98amnNjOtLbqMCShgxi?=
 =?us-ascii?q?bp1EboAHW+eoJ20EuC+cRO1zM21WM7FNMNkKDS++72FodTTlME6+JXz5?=
 =?us-ascii?q?2k7zOpaQ2Kg6uTzQvh4bWOoHCaXKu3CrL8MB3ldixLnNVOYsFHu3Jj+2?=
 =?us-ascii?q?OD34Jktm6TO+/BBA+GYb25pg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 14:54:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749732848; x=1750337648; i=markus.elfring@web.de;
	bh=ynqVteSJ3yJhSmkE4VHWLviCYm2u44T+BWvuYH23Yls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l0NHRGbxiGXJNSjMoqGpjakepFib5EFszV4IaKTThP2hWeeu4xlPrpIEKOXzAdhh
	 cdHhMaf99+DFKyCyZVfr//jLguQZEsfU5Ke0QyS23evWIrM0G/a8bF2iHM+l6uIN6
	 /dxAoSFPFMsascrMkDdQKGj/xGCHi6KuOIq0mZeme+NhUnhJo392Kd63ieq7LqPJF
	 YlN75Wzq/D9Nb/G6wDfALggmQKhWiPLrnceGxcvzOrv2VD4pFcRMAz7AL36Yf+iVz
	 yKaw8kgSO4VSW9k1VTbVq6Nax2aOlGiNshw+0JrOUfCDkPQdP4de7gVs1safi+3Tw
	 jbfH+0DJGEiaAKQeAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1umbW73N6S-014eIn; Thu, 12
 Jun 2025 14:54:07 +0200
Message-ID: <45eb943d-1ae3-439c-8b05-7c355a54c48d@web.de>
Date: Thu, 12 Jun 2025 14:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tCn1B8AuWRbx87ymalcL+gvie9sNqauxXJD0xYqYkhtNl1xjow9
 Ep1xWhB7p/dXNOhUTAw6dJM+FykFIYGpV83owCpqTNPBvkFYXTVYgGrfPTL9M/cGGOpBtBC
 TDJAWxndbJ7xiaXYLiIF1+0stUFcooC3sfP8KcwioBWUx3ZMaHrx9Updg04Cmlgc2oKizcP
 LqB8Ay66neEt3Rwle3Z7w==
UI-OutboundReport: notjunk:1;M01:P0:GxDOUx+UeTw=;IuvkXIw8YXgVBI4PMR9sJlZqHxD
 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
 UVAZH2Co1LPgEZSmC8mpO7Zu+X9bg==
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2762
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/45eb943d-1ae3-439c-8b05-7c355a54c48d%40web.de>

>> 2) The proper scientific method is to cange only one thing at a time.
> Can any software developers determine the concrete command which would p=
erform
> the indicated =E2=80=9CGrep query=E2=80=9D?

I got the impression that a function like =E2=80=9Cinterpret=E2=80=9D cont=
ains interesting
implementation details.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/582d2ebd4543dd7febf06=
70f4a104679ec8bbc2d/parsing_cocci/git_grep.ml#L9-35
https://github.com/coccinelle/coccinelle/blob/4093aad2da23ea5c86916de0a71f=
43032fc2bb2f/parsing_cocci/git_grep.ml#L9-L23

Some data processing results can be produced accordingly.

Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyse=
s/drivers/infiniband/hw/cxgb4> git grep -l -w kfree '*.c' | rg -v .in | rg=
 device
device.c

Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyse=
s/drivers/infiniband> git grep -l -w kfree '*.c' | rg -v .in | rg cxgb4/de=
vice
hw/cxgb4/device.c

Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analyse=
s/drivers> git grep -l -w kfree '*.c' | rg -v .in | rg cxgb4/device


Would you become interested to clarify why I do not see another search res=
ult here
(while the program =E2=80=9Cspatch=E2=80=9D would still generate an expect=
ed diff output for
the selected directory)?

Regards,
Markus
