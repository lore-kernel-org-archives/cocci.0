Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B4CA1002
	for <cocci@archiver.kernel.org>; Thu,  4 Sep 2025 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=+82l2EAGRFXhCq2Zw7876HOR5usr9GLXFpqedRw0X7s=;
  b=SGHiayY/rFICPEpKqaozmF8WvuVCgHe1b9K+zXpPiEuzC5j2+PuaTvr6
   5f5SW/DcU03Trc8D9UfKcTjZruuU4EaT4aHYshTiyg0ma5vKmbc0KqNU4
   s9b+qqEUWsgdCgBiIDSDJopETToe3t99KpWzrBdieNmmBLPHWhlQL1d6D
   E=;
X-CSE-ConnectionGUID: zCE54fqWRD6jlmJa9o18kg==
X-CSE-MsgGUID: bkTOOsPgRsiTPP3R2YIWKw==
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
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="237508480"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Sep 2025 14:37:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E112BE0B0D; Thu,  4 Sep 2025 14:37:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C204FE0171
	for <cocci@sympa.inria.fr>; Thu,  4 Sep 2025 14:37:33 +0200 (CEST)
X-CSE-ConnectionGUID: y/BjCpaERfO7BBAh4K+cTQ==
X-CSE-MsgGUID: oM6KZKzqSmq9hDNhu1IbRw==
IronPort-SDR: 68b987f6_DFSOiFm/VsXiHIt1E93Iuvtp6vH5UhMj1FLHnumDFcViHsc
 HmlhCl3+kmTDGV88yCTxxVxGYEe0olgV/niHUBA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E+AACsh7loeA4P49RaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YI/gQdUMwQLSYRViByHNIZfhzyHVYh5gVUUgWkCDwEDAQ1OAQIEAQEDBIIMj?=
 =?us-ascii?q?x4CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?UMOO4YgLw2CW4EsgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdtHQEBESc0AhEVA?=
 =?us-ascii?q?nMBAYJ+giMBBhABAzUHszaBMoEBggwBAQaCadd1HywiWYFkCYEbLgGFa4JKG?=
 =?us-ascii?q?gEFbooXD4FVRIE8glKEa4EGDoMOgmmCJoEWdT9VgU+Df4hbgneIMYFKHANZL?=
 =?us-ascii?q?AFVExcLBwWBYwOBD24yHYEnhACBDYQdK0+FAj5Zg1Mkaw8GgRWDXYQ9QAIBC?=
 =?us-ascii?q?209NwkLGwY9lWSCPXOXMrMBNAeCOIFnBYFfDIkIlmQGEy+XUg4GkwWZBqNoE?=
 =?us-ascii?q?4VGgWg6gVwzGiSDNk8DGQ+NeAEohDO4e0E1PAIHAQoBAQMJhUYBAYxWgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 4qX/EoSADJF7s6S4sYWQcTZeprvDQ==
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:ONOv+aF+S+e64c5tpLqEyseALOsnbusQ8zAXPjNKOH9om6uj5q
 eTdZUgpHvJYVMqM03I9uruBEDtewK/yXcX2+cs1NWZMDUO0VHAROxfBODZsljd8kPFltJ16Y
 clVbRiA9vtClVAgd/9+xTQKadZ/DDKysGVbfy19QYKceiGUdAY0+/zZzzwLnFL
X-Talos-CUID: =?us-ascii?q?9a23=3Aff02SWrnmi/hHakIdmH3cLHmUdFiWH/21H79GUG?=
 =?us-ascii?q?fVkxDYb3JahybxJoxxg=3D=3D?=
X-Talos-MUID: 9a23:1lYgYwo8rN4ckJ1/YPoezzZHauRawLa3M0UUwJUqncmZbA16ASjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="124637345"
X-MGA-submission: =?us-ascii?q?MDER/rVKNpG+TxpqaywkHn0WILW3YcEFjRC6Fv?=
 =?us-ascii?q?qNLCpovZ7QBnrN0G/8SZXvnrdZUY3WCsVJdIcZod/CwRkZVkBq+j8p7s?=
 =?us-ascii?q?bSP/1NnPE3FajaEu7KniSvA83NrNI1dnT80hGD++3iQdoYYO6YB7Yu0L?=
 =?us-ascii?q?ITlDWxx19CASSGxSeaOPXswQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 14:37:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756989429; x=1757594229; i=markus.elfring@web.de;
	bh=+82l2EAGRFXhCq2Zw7876HOR5usr9GLXFpqedRw0X7s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DL6Nq11bNYI1cGw5QyRk3yBx3Rl05dIVNNXOfQjp0dT7CkUKN99axZjdIjHcdSCP
	 rsTvzGHzWb6d0BLdZWhvyQLV29iIPyr9sMLAXtd4U24ZXeFhn9kr0aKK6otO01Ond
	 YBeb6TKjuvAKp1XsPOdkdiAWc0hH96tzx8X7RM7l57P3r1MSYEzU9NALYi785xu6i
	 Sotx5YffRKuULVWbwR4NMwNgLxuKAhf2bnjjQPs0IHKN7fq5rDi04klc40iJVS98F
	 bAuLLyclKulTtfiQk/QddWUtr+ITk43nywy9FCYbh5mT3pwN5zOIkaOw1XpvF3bJd
	 x9+iOsBa32R18gJ26g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.243]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1uEmmU44du-00b4is for
 <cocci@inria.fr>; Thu, 04 Sep 2025 14:37:09 +0200
Message-ID: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
Date: Thu, 4 Sep 2025 14:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6bX7LT2LyBKz2BgSeaCdSYozDIwF3TZgQs4lXi6u0NWHuvEOhUY
 r+yhgN97iHfhnffW1z616r8ikQhUZP3svIyppIpe/80OLeAjc0EA61JqJeNGwtTyipYk62I
 +KlptUk1qxerge7FD40Qo2XEyrOmeSwFmhSx07WszwYZ6HgabV+UcBuM8tlz7ivbrfpcTJq
 4BysrO3sbmd3ZDYCnzUtA==
UI-OutboundReport: notjunk:1;M01:P0:Tlqbr87wO34=;CjbGEfZn7q1yRIfGOAnnVopQ94P
 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
Subject: [cocci] Searching for missing cleanup function calls (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2990
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7%40web.de>

Hello,

I tried the following script out for the semantic patch language.


@display@
expression e;
statement s;
struct device_node * dn;
@@
*dn =3D e(...);
 if (!dn)
    s
 ... when !=3D dn


It can be determined then that the software =E2=80=9CLinux next-20250904=
=E2=80=9D contains
80 variable assignments where the object address might not be used any mor=
e
after a null pointer check.

* Would you be looking for corresponding improvements of such a source cod=
e
  search approach?

* How do you think about to take further data structures into account
  for which objects should usually be released by a cleanup function?
  Can the search pattern become more generic and safer?


Regards,
Markus
