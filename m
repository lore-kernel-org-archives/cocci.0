Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ABEC87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AaoBMY6Z8K9FVQun6zCS96WPO87LB9KRPdA7d8ry4yo=;
  b=oH154TOWh8t9W2DYkoBrbiCDyEWk6Y8hYqz2s7rgOk62n5R6v+tX7trn
   QhpJYuTDlGOm6g4NPOJefSGEei+9UYM3GI4yga73jSkQQTful9/0m0P18
   KuygJp6aubu0KJg+1ZpZC51r7p7pCFO3C6ocXY/3nyT2VnobDvZwsGHJh
   Q=;
X-CSE-ConnectionGUID: 7Boc6kD8Rxeq/G5PEhzKOg==
X-CSE-MsgGUID: PlV34ClKQD2i41UTtjXqug==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233951241"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 13:18:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 51897E0B0D; Sat,  2 Aug 2025 13:18:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B022DE0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 13:18:42 +0200 (CEST)
X-CSE-ConnectionGUID: 2OJIYZ8IQYS2/gwlCoN8Ow==
X-CSE-MsgGUID: 0WqnF4trSsej4ZnswWINUg==
IronPort-SDR: 688df412_kouHa6zr79OcXtmBZD9X7cBjhMpVyJzfXu2b4F9g42u0CGn
 hhGh7W3IR7DLNYUn/kaFXNd5b/LLQ+jMhUbAkPg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GvAQDr8o1ogAQP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDBIUAAowaA?=
 =?us-ascii?q?h4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLC?=
 =?us-ascii?q?xoCJgICVgYBFAEBgn6CIgEGEAEDDiQHsEWBMoEBggwBAQaCadd1HywiWYFkC?=
 =?us-ascii?q?YEbLgGFbIJkAYYnhDwnD4FVRIE8C4JHMT6EQ4NbgmmCJoEWg2ONBIhwUngcA?=
 =?us-ascii?q?1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1gXlBGT+DUx4Gb?=
 =?us-ascii?q?Q8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIU2gXSWRq9sNAeCO?=
 =?us-ascii?q?IFngWQMn2wGEy+XUg4GkwWZBiKjIYV+gX4kgVwzGiSDNk8DGQ+OIQwWhBG9a?=
 =?us-ascii?q?EE1PAIHAQoBAQMJhUYBAYtbgUsBAQ?=
IronPort-PHdr: A9a23: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
 3PgJJvnII5VOoCpgyRf
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fgp2DKvQ6zR0kFhZgddeTnYq7skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHjJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniEhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:gxYuwGB4xhEXgQ36E3NA1m8lKJAES0zmljDfPEuTDkA5b6LAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Am4mGFg4crPiD2xAD+FY5R3Ohxoww3L2oJhwRi64?=
 =?us-ascii?q?dtsvYByprJAi8qgm4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="122655557"
X-MGA-submission: =?us-ascii?q?MDGTMSi5/wfRcKs4lrDLr8aVXwKc4hDwb43Z7+?=
 =?us-ascii?q?Rd3hK1krRb4kfuO6e2P1hDOlw6/9oOFhWgGIS8CrbKQV2/KebEgkvoKr?=
 =?us-ascii?q?G00UEup/roweiRhJ/dSnWRVDdfzFQr9RJX95hkeLZNvISK9n6iArPqSS?=
 =?us-ascii?q?/JlL85Tv0iPaw1RnmVzRCvRQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 13:18:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754133520; x=1754738320; i=markus.elfring@web.de;
	bh=AaoBMY6Z8K9FVQun6zCS96WPO87LB9KRPdA7d8ry4yo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DYFmWFNcbRTUPLyzhZ1PEVPOhHihMIG40/z+70NbVwZ+qRqkSprjn0TOYbvAVhqi
	 HVLbUBnyBvQ2ctBC8O7kDmwkt+U2LNfosaAZlhVR1PaTv6mo81RwjguH3JKEp1MHF
	 JRQ/ZPc6UuJS6uspplCcBmxiL/K7h5WuEAhM7FKPsZlNzrr4DHMoGSQ3eBKuxM3EB
	 035pdKEEoULcCuAtaneEEJJBpN9gQLm+r2MC3c7/qi+TPkzcCYZhOE+s4clGRiSpQ
	 Ee/+Z4JtjWlFHN+h8E4UzhkN/SI6PcDS0f7v+z4U4refZKEmscpdz62MOMbXpzunt
	 NzgFsLy1TIMtl7Qsiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1uh3nP424a-00F7v5; Sat, 02
 Aug 2025 13:18:39 +0200
Message-ID: <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
Date: Sat, 2 Aug 2025 13:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <fc1427ca-c2a6-4c12-a8d9-c8c692f1544a@inria.fr>
 <b0a5a727-c972-4cd5-baef-adf5dda72992@web.de>
 <41b71929-b32d-507d-eff6-ca19ea3c965@inria.fr>
 <b7298dde-48c6-4e0a-87af-2046ab999ec3@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oHo8bWfs5yZoZa6JAOlKiqdtVc/BA5b6BssNLQWse8/eJ2IKKhI
 2xB9BjNVj8NTgVoq/yzKk30AIQDo38xw7WUIdZXSUIVdLM05kUtYQPgEI0g34lt64Nyqz0o
 1AQyUL3BdzFXU9HJbNV5zhfMnuLABQNuKCoBzGrwU33EExKCzMYk+gKnIVRhG66enumKq+P
 I65fvt+A2By2p5w0YWiTA==
UI-OutboundReport: notjunk:1;M01:P0:JiXOWyIhEQw=;p+vjiLEROnoorI87muq3pwtme02
 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
 XMCbSQLMt4IaremkrqXrNHM=
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2926
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/c1d74aa4-44db-4618-ba59-e9b6dab28c0e%40web.de>

> Would you get into the mood to clarify data processing challenges better
> for another source code search pattern (like the following)?

How reasonable would you find a test result for another source code search=
 approach?


@display@
expression x, y;
@@
 action_lock(x);
 ... when !=3D action_unlock(x);
*action_lock(y);


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch ../janitor/show_second_lock_call_variant.cocci test-action_locks-2025=
0725.c
=E2=80=A6
@@ -2,13 +2,11 @@ void my_action_test(void)
 {
  action_lock(&blockage1);
  my_log("blocked 1");
- action_lock(&blockage2);
  my_log("blocked 2");
=20
  if (my_surprise(123))
  {
   my_log("surprised!");
-  action_lock(&blockage2);
   my_log("blocked 2 once more");
   result =3D 99;
   action_unlock(&blockage2);

real    0m0,067s
user    0m0,045s
sys     0m0,021s


Regards,
Markus
