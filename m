Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32131C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 01:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kOHyHFM92M7DY/+f07G7poSJoDU8vzmZNYd6RHHLC8k=;
  b=YpRTGCIMik2up/zUCwq+07Yh4op/y3gFGB0QK2mpTBxtOaGDTnAW5Ac3
   hhWRht6vAP+G75XHjfSv4tJB8xKbZySPqpVpY077qeEAqSfmWIF7B3n0c
   UAFtcMd4S3ttYykOT0PbF9kKnX9ReJbpRqo1b34UfXyouQPbhcyJFX4u5
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27114554"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 02:49:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E758EE020F; Mon, 21 Mar 2022 02:49:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F82FE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 02:49:33 +0100 (CET)
IronPort-SDR: yUnkAWGmWPItaPZuRTiW+edVNcJgy21sJgbHA96LdiCM7prNJOy61F6CwiczsnnFVc0rTdfcXM
 qy1cvFz4PfLEAtkDqbmYQ79+JyJC0Y6QP7dZke7I9uVcFeU+U6B20j2S/v+sDXj7M9r8Rwzryq
 CUvdOId9KjyDdMNHPzFiFeKdMPVlbph/NeDVzYHY/L0QXYSoLhpIW0nQwNwtdG+LPBH5UHq5w4
 1vPJ9uM69H3o4nhLY+YGnqUVPbxJi4BMS0NfrFaq23DffhGx8nfAtS4Rf1ss3xgiIKJu1oe7IS
 UHLDpVYg0nlfYRW0Hq3FbQAj
X-IPAS-Result: =?us-ascii?q?A0BpCQD12Ddi/0Xcza1aHgENLwwOCwmBWQOCJgeBTQEBA?=
 =?us-ascii?q?SkEC5lZeZpACwEDAQ1BBAEBhVoFg14CHQYGNQUNAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBVjIsAWMBZwGBTgGBeQYEPYI1IoQshRSDF601gTOBA?=
 =?us-ascii?q?Yl7gT2GExRCiAYcQIFNgTyIU4UyBJxAkhiPfpxogS6DU4lylWwaLoNikmeRd?=
 =?us-ascii?q?ZZboUoIhTCBPzokgVkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBCAEBAgGNd?=
 =?us-ascii?q?AGPFyEBAQFpAgYLAQEDCZFyAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:G4seC6MHrWqBs/jvrR2WkcFynXyQoLVcMsEvi/4bfWQNrUol1mZUy
 zRJUT3XOPqNMGv9f9p3a9jlo0IB78fQzoRmS3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWVvV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2rs/xow
 4sWk6WrTAkgB/WdmuUhSQhHRnQW0a1uoNcrIFC6oYqe0E3Lfn/h2bNoAV1e0Y8wo7ksRzsWq
 LpCcmhLMEHra+GemNpXTsFngc8oLeHvPZgDoTdt0jHUAPIrW9bFTrmiCdpwjW9g3Z8RR54yY
 eIhZR9PNTLieSROHXkPMMolurv5pFDWJmgwRFW9/vZpuDmMnGSdyoPFO93ecd2iXtRQhk/ep
 2Tc/m2/DAtyCTCE4T+VtH+zhuLCmS7hHoQfCNVU68KGnnWx6kAKA0NNc2KgpPewsxbvWdNjM
 V0Lr39GQbcJyGSnSdz0XhudqXGCvwIBV9c4L9DW+D1h2YKPvFnEXjlsoippLY155JVvFFTGw
 3fQx4uxbQGDpoF5Xp50y1t5hTaifyUKLWIPYSIeCw0I/7EPQb3fbDqTF76P84bv0rUZ/A0cJ
 RjQ8UDSYJ1K0qY2O12Tpwyvvt5VjsGho85czly/spiZxg14fpW5QIej9ELW6/1NRK7AEAXe7
 CBVxZDEtrlSZX1oqMBraL9ddF1Oz63YWAAwfHY1QsdJG8qFpBZPgry8EBkleBkyY5lUEdMYS
 ELMuQ5c4JJJPX2hKPcuC79d+OxxpZUM4e/ND6iOBueilLAuLFfflMyvDGbOt13QfL8EyvhuZ
 83ELZ7yUR73y81PlVKLegvU6pdzrghW+I8ZbcmTI82P3eXMaXiLZ60CNVfSPOk14Lnd8FfR8
 s1DLI2H1BVSXenzeG/R/JJKdQIGKn0yBJbXrc1Ld7fZflE8QDx4V6bckeE7Zohov6VJjeOWr
 HuzbU9v1watj3PwLwjXOGtob6niXMshoCtjbzAsJ1uhx1MqfZ2rsPUEb5IycLR+rL5jwPd4Q
 uMrYcKFBvgTGD3L9y5EPcv5rZd+b1KmmgKDMi6oen45coI5H17F/drtfw3O8igSD3Pt6ZBk+
 +D5ilrWGMNRSR5jAcDabOOU42mw5XVNyvhvW0boI8VIfBu++oZdKxvu0q09LfYKJEiR3TCdz
 QuXXEkV/LGfv48v/dDVrqmYtIP1QfBmF09XEmSHv7a7MS7WojiqzYNaCbvaeCCbWXz09aima
 P8TyfzgaaVVkFFPuot6MrBq0aNnvYe0/ecHl1g9ESWZdUmvB5NhPmKCg5tFuJpN8aAF6wG4b
 USCp4tBMrKTNcK4TlNIfFg5bv6O3O0/kyXJ6ahnO13z4SJ6oOidXUNJM0XegSBRNuIoYoY1h
 +o+uMMb7wGlzBwnLo/e3CxT8m2NKF0GUrkm78tGW9Wz11N3k1wSM4bBDiLW4Y2Ub4seOEcdI
 giL2PjIiYNayxeQaHE0D3XMgLRQ3MxcpBBQwVYeDF2Vgd6Z1OQv1Rhc/Dlfot65FfmbPzaf+
 1SHNnGZ4Y2L73Flm8hOUmShAUdHCQHxFokdDbcWvDWxcqVqfjWlwK4B1SKl+EEC73kacydb8
 bycxXyjVzv2FC00Mu3eRmY9w8EOjrVNGsnqnMG8A9/DEoY6bDfhj7XoY2cUw/ci7QXdm2Wfz
 dRXEC1MhWEX+MLeT2DXy2VX6FjIdC25GQ==
IronPort-HdrOrdr: A9a23:/CdzKanWWAVR39O/wd5rmwUmXlnpDfI83DAbv31ZSRFFG/Fw9v
 re+Mjyt3fP5wr5N0tPpTntAsi9qBDnhPtICOsqTNWftWDd0QPCQe1fBODZsl7d8kPFltK1Cp
 0LT5RD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="9083772"
X-MGA-submission: =?us-ascii?q?MDF9vwcqMZqOreQiiYJENsxbFfJUYDr/GFoJ1c?=
 =?us-ascii?q?LkWKVR/8Zy00hyLXkZVZ3WH9AbRDCsncML/UXKAK7rs7yBttaSSwg+uz?=
 =?us-ascii?q?my+Pubs/5GJjLSBiI0orxkEif56enlg6ZwvlC84+FLaYF1WpVh1h0JNJ?=
 =?us-ascii?q?H/2gxr33U9cAmYJZIx6JVwrQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:49:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 2DDA749
	for <cocci@inria.fr>; Sun, 20 Mar 2022 18:49:29 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QmExB_2Enfaa for <cocci@inria.fr>;
	Sun, 20 Mar 2022 18:49:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 7094D40
	for <cocci@inria.fr>; Sun, 20 Mar 2022 18:49:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 7094D40
Date: Sun, 20 Mar 2022 18:49:25 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Is there a stringify operator?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 268
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/a28111b-90ab-1d57-58de-113a50f61f41%40ewheeler.net>

Hello,

I keep running into situations where it would be nice to stringify an 
arbitrary metavariable.

For example:

	@ r1 @
	type T;
	identifier I;
	@@
	T I;

	@ r2 @
	type r1.T;
	identifier r1.I;
	@@
	++printf(#I " has a datatype of " #T "\n");

I used '#' as the stringify operator provided by macros.  This alternative 
format would work if I define a stringify macro (I think this works):
	#define STRINGIFY(a) #a

and then:
	++printf("%s has a datatype of %s\n", STRINGIFY(I), STRINGIFY(T));

Not sure of others would find a '#' operator or some other stringify 
functionality in Coccinelle useful...

--
Eric Wheeler
