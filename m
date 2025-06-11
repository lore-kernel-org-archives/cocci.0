Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013B7C71136
	for <cocci@archiver.kernel.org>; Wed, 11 Jun 2025 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=yR3PtiP0yfwY5lgYMCnzbfwJ6E5+R3xgYMH5bveC9UY=;
  b=ZjaCPZPNMD7RbIIU+ruXPVcoob6OJxLk4pgokjwdb1nWljbYwu8a315m
   eXyl+3SxqubH4LB1C7+Gc4YLEmpiQb6sGQ0ynHqF0DFVJ28X/NBDZL+93
   CSbeSiCRcwYD305VIELdBcrBaDpF6+74npRrdkIt8vezmfJ3oObrHxns2
   o=;
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
X-IronPort-AV: E=Sophos;i="6.16,228,1744063200"; 
   d="scan'208";a="226377235"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Jun 2025 19:55:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1DA31E0AF1; Wed, 11 Jun 2025 19:55:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8312AE0131
	for <cocci@sympa.inria.fr>; Wed, 11 Jun 2025 19:55:29 +0200 (CEST)
IronPort-SDR: 6849c310_Rdgiiphv4/Mvd0VxdqVSQw5cRYdO9yilzBSoqdwxP7PraQ7
 T2tG+5mGLYl0/VCGfccVzc02cXfDNmozxNLgnYg==
X-IPAS-Result: =?us-ascii?q?A0HgAADNwUlogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgQBaMwQLSYRVj1CCIQOEO48PiHeDUgIPAQMBDUoEAQIEAQEDA?=
 =?us-ascii?q?wGCDIJqCgKLZwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAkdEAQEBAgEjHQEBEScECwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ+AYIhAQYQAQMOJAcNsHyBMoEBggwBAQbaXh8sIliBZQMGgRsuAYVsgmMBh?=
 =?us-ascii?q?ieEPCcPgVVEgTwLgkcxPoJhBBiBDTmDW4JpgiiBFo0Wk3xSeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSBDAyo0MSMPPAUtHYINhRkfgXOBWQMDFg8BgiSBYByDP4EjhEkrT4Mig?=
 =?us-ascii?q?X9MGUGDXx4Gcg8HOEACAQttPTcJCxsGPZh4g2kIgQ0BKyCBPscNNAeCOIFmg?=
 =?us-ascii?q?WQMii2BQpN5BhMvhASNDYY6DgaTApkEIo1llVyFVYF+JIFcMxokgzZPAxkPj?=
 =?us-ascii?q?iE+g3WBC7YbQTU8AgcBCgEBAwmFRgEBik80gUsBAQ?=
IronPort-PHdr: A9a23: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
 oUDQPlXWQ5tfs4=
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:DI8sGa+lgzeh7aSHP7Zuk+AGI+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re5cjztCWE7gr5PUtKpTnuAsa9qB/nhPpICMwqTNCftWrd1ldATrsP0WKK+VSJdhEWtNQtt5
 uIGJIfNDSfNykYse/HwE2fD8sqxsWB/ZulnOHE0h5WPHtXgu1bjjuQEWygYzVLreR9dOEE/B
 Hw3KB6mwY=
X-Talos-CUID: 9a23:q29HemGqfsnW80PqqmJ3xhIuGs4qWUbT50zKMwizVUpZRrmKHAo=
X-Talos-MUID: 9a23:X50eawh8icV4KZKt9KQiFcMpG8RruYukGBE0qoxZn9e4MRJCNTWttWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,228,1744063200"; 
   d="scan'208";a="118806323"
X-MGA-submission: =?us-ascii?q?MDFTpRdSytsSr54ieEdZlJUSDx4gcqroYfTEfi?=
 =?us-ascii?q?+54FQybjwMyJg5NIDmOe8LQ6u7Kgw2UB5PKro+arcIwWvnNneprqtNIN?=
 =?us-ascii?q?WuB3ZD9DiUxNBygKZtFZVplZTsG4V1JuK0CMNR3CRVscBnN8+/h1IQDG?=
 =?us-ascii?q?W92GRGn5kT+PmVjUAe+ryCMw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 19:55:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749664527; x=1750269327; i=markus.elfring@web.de;
	bh=yR3PtiP0yfwY5lgYMCnzbfwJ6E5+R3xgYMH5bveC9UY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iCU+53RvcoA/AhdbPPLvxSJbkvXWv3PpyIHibRbVQTj2LKBG3NRhV77XPGYkzqH/
	 ajjFqZPOAkhuJ1WVqrlcvShg9DruntpPkNP4hhMrkzn+Ca0EYTuq5rI2ZLlR7bzz2
	 Ky/bj3XCbkT64mqoCKshEuryC7KoAM8QWiDOo/6vQ3PM6h0XXu3+qsF+Y1k3m2TO6
	 BGtDIBb1g05GN3B2oiXt8rLL+rkKlz4+UyW8xqzEO46UMOnhMrKZ4BJvQC2BcztUA
	 iMMoJTIb8G6tqBcCavble+WVFe9S2vhQtNuzaXK4JPIiJiTifz52ehSzVOgwl7rKq
	 BAHK4UwZRgyyjTSk4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1uO39e2UNJ-009xbV; Wed, 11
 Jun 2025 19:55:27 +0200
Message-ID: <9eeab48f-1bc7-4395-b998-6a49330cfc2b@web.de>
Date: Wed, 11 Jun 2025 19:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IrzDTV2XxfFrQy0f41Va3f8i7M14O0bkR/q0pDm+kPL19NlxcrY
 ODAyozqVHAF4LJY54h5zkzqljmrbtARtH12+sSU/r8ZzFvh2zSPxXE1f9jYH3aC/XYm1jpd
 itryIU0iTJLba0CJBGQmTndPZcSMypydZpDzM5/NJTipYRX1rJOP7yA+tHO6wJk6LdCIk9b
 lGD6FioVDhAl5vOHUfc0A==
UI-OutboundReport: notjunk:1;M01:P0:h6xNRAflamY=;KSHIoKOb/A+uNt6O914vqIvyWQk
 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
 jMmxV3A
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2760
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/9eeab48f-1bc7-4395-b998-6a49330cfc2b%40web.de>

> Could yo uplease make a small effort to make your reports understandable=
?

Will another clarification approach become more helpful for this issue?

A known information can be presented as expected.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> /usr/bin/spatc=
h --parse-cocci delete_redundant_checks4.cocci
=E2=80=A6
Grep query
kfree


> 1) I don't ned to know the paths of your files?  This adds a lot of
> clutter that makes it hard to find the important information.

Please reconsider such a response a bit more.


> 2) The proper scientific method is to cange only one thing at a time.

Can any software developers determine the concrete command which would per=
form
the indicated =E2=80=9CGrep query=E2=80=9D?
https://gitlab.inria.fr/search?group_id=3D10912&project_id=3D18465&reposit=
ory_ref=3Dmaster&scope=3Dblobs&search=3Dgrep


> In the second test, can you check whether the file you expect to be
> considered is included in a HANDLING line in the output?

Can any software build configuration be achieved which can answer
such a question directly (also according to a special test case)?

Regards,
Markus

