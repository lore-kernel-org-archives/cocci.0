Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9BBC35FF3
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 12:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZmW+vLInL4TVw3R6aLHnH+2nNOzUGxFUKwW2uHXTgP0=;
  b=Kdz8eEPa6CsgIaymp7m4ZhDstKkKftzSt4iLdwek77HHpgvrGQxr6nkk
   7TXoBc/MIAIj1YxV51nfUER9Mf5W9kSgSKG1uwyqy7woYEZE21aGkNYOP
   wuwxvzXAyyS/X625MF9onrhFb7DqjCTYCcPnemQtF8nl718ePHRf+2pgm
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213469496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 13:03:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CD9CE0D1D; Tue, 18 Mar 2025 13:03:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0A8ABE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 13:03:52 +0100 (CET)
IronPort-SDR: 67d96127_GXBMcgPSj5hG/BZjN6a/DedtjxfBzPQmPrAyz5iEW8aNEzX
 B198dlJmy+6pCP404aocB4fW5tglplkK1FcXpbw==
X-IPAS-Result: =?us-ascii?q?A0HVBgBrYNlniw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRGJ1MwQLSIRWj1CBdDCEO4c7h1OEb4QGg1QPAQMBDUEBAgQBAQMEhQACi?=
 =?us-ascii?q?x8CHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQE8B?=
 =?us-ascii?q?Q4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+gjABAw4jB61lgTKBAYIMAQEG2lwfLCJXgWUJgRouhW2CY?=
 =?us-ascii?q?wGFbDuDQnonD4FVRIE8C4J4PoRDg1uCaYIzhENnmXuQHFJ7HANZLAFVExcLB?=
 =?us-ascii?q?wWBKUMDKjQxI4EiBTQKKg44KYFjaUk6Ag0CNYIbJFiCKGoEBYEkgjeEPoRBh?=
 =?us-ascii?q?VCCEYFdAwMiAYIwb3Ucg0h2PoRkLVCBTR1AAgELbT03CQsbBj2jSYRFgX+VE?=
 =?us-ascii?q?ZNrnx00B4I4gWaBYwyfXgYTL4NwE40JhjoOBpJ9LodlNZA2IqkRgX4jgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIRmEFLZBQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 TeUsdNk5V2rwLHn9w==
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:gMMuTarqzvqD2H7GY6cXuJQaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AlSemyGqsSqcBLQcXiZS/KOTmUeEMKifv6m/UGUW?=
 =?us-ascii?q?9DVxtaLS2F0DM35oxxg=3D=3D?=
X-Talos-MUID: 9a23:l1PHNgXBrbH+ZBnq/BHpmBAlE8RG34OFLGIqt7wfoPSkBxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111897318"
X-MGA-submission: =?us-ascii?q?MDGyoXwUTtiJTjKJohB4tHIrnFncF84dekqhYW?=
 =?us-ascii?q?1hvLPehTnn1D8RgexDwFe2DobQJO3l+dJZ02i/klXY/uLGyUkHpEofZv?=
 =?us-ascii?q?vvuuznz6GCLqRfRTk57iM1HQ2/5VfoaWhttHX6iFwkQHottCZj7k068W?=
 =?us-ascii?q?CkttuqcVFRzOYgkILGYAo0wQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:03:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742299404; x=1742904204; i=markus.elfring@web.de;
	bh=ZmW+vLInL4TVw3R6aLHnH+2nNOzUGxFUKwW2uHXTgP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7Wg0P2djKNFAD+O3Q4ZHqvrvUPLNcIejMj0ZeqsYJMtm/Fc8us2LOJ7r015w35M
	 KdNfqQfvp1fTspYyTtwT+KP6RQA8rTLVJDtcfsJXEb8KR4on6ypnyvuw3rfBZQIrn
	 ZZFgkyqM469cpFP9dEzwK98LbWBvifBSnKiIwmA2lnppZZR7/cXKnT6GOjUjdnvvk
	 pkCpToHBCYWJlIiQ8QyBB0+LvXeZ0joFIr/aIQabV5b7Xfd6txQRelnrHqbHF8rXB
	 EHWu9pA7XAKt3s59KS22C/rDb0Sg0twPoTV3gjX409P9MdJM/1gypkelckwdCp6oQ
	 C9fZYMYJ5TknFGmV3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1tGn8P2vqb-00gpfH; Tue, 18
 Mar 2025 13:03:24 +0100
Message-ID: <bf19c4f4-5ed5-4210-b123-92f79d27d6e7@web.de>
Date: Tue, 18 Mar 2025 13:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
 <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de> <87o6xyab2r.fsf@bootlin.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87o6xyab2r.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MPLm0VzdlVlkA1TXNIOswRWGxRtA2+1bMmklnR4aPrxPWMr3Kf1
 CZZtRDu4IfbAjT2N0xiw4T3bz4HqMQ9Kb4smmMzg8HfiFF+vpjS4qscsSbgrEL8hwb6sfu/
 GNL09pdf3gx4eH2m3b+TYvjv0Jhnhbse3LC0KyibcyQ3BezfHu9NpP0HYz5xAeb8TljbnTZ
 dStNLKYXTiPBMcwTjHnyQ==
UI-OutboundReport: notjunk:1;M01:P0:dgWHoFijdxI=;nNogpUYmWqfRtvqVrL3ZzCSY+ov
 fdNZHYsKx7QloW5WopqUncWZCZvpT64zD7g6jW4Rr8z3ezVgpwOtaykrijwjjs/TSwE5XMsge
 Cvqe8Qz8Vi7+13bQCTrIF3xo37KGM0sc6CuoN8/WPtd5XhaCUzwFJV+qCsUbGCM2sLsg1/ttI
 /9PdRALH7wc5aE9TLH6yow4kVFlXMbHSr9O506Pp+I8kBWH+2nXoGfDG1TTcKuCEjKhcog3cC
 L2C1S9QY7kKdnKdHjKD17wqAsX6V98H1sTTRyPwc7Zi1emq2Cm6ZDDedsGfaT8PqEL10WlVw/
 zgK/I2LoxPYdEW1yqkqb4JYD9iAVf+LOkSoLsS6pbsnnzw1nyp0wiU9IZeLwBpOkl1ZmOSBQm
 bQ3WzozxW001mj4+oemclwY5mmi/kUD4AKVorupai1zkbxpkDWwIG7ElTjTnfvB0pNKSoXEXR
 2vq+5zuWL4vsgLp2oFebCr1tL/DAaTsHjPZ82fPV4QHZBojI73b7xwOCejbdjcqd7stP7QdvK
 kSY6yeCJdKk4ZUiMovMCdZ0101qMil+U3nLynYWhj9VJesc3zrozrMJ/PaJLnUEConlAasujD
 9ySrN6rV9D8NlcTPUV4CGBaeG/7pSWsYSeqtXt3WRe8Gg//iqK7BuhCMttZEqR/upNn1aNNqC
 lurBqqbBO4f/CsqTZEi6ZFQd10OFRjXVPPvndFJPg0a3Gm6vEU7UB0WsGIpuPJWyo3jYcl69E
 P/aDcZjlTEZy6A7STh+jifGrtAgpkwLTzoyqKt4Ju5WPt6Wwksqn4SbtRe6QXK4KESczCDO4T
 VWJiIXmY6n2ixeDbySYfJvoBwJ//rH6PFSbwK9T18v8gIrqc6Z8zqY0oR1K/+PklJqd7YnMJO
 m0rgGd8EHhuaDd5LpXBQIeI22aqj5135lWv4cDLblgfklcJz8VpfRlr22aoVkuZb3tf/06U61
 gzqiXMFhL2MH45Zx+ey80HvbnAHnofRmPhSLt/fUoysIZr6Ndm3BXFko4RuTUNdR/X2CzQLRx
 wUAdw2A6XzteVSrwNjEoP9vv7nHUQWzPXtVi+Ff1YWXhGNihDFW3XB+5zlUOGZBIoJkdn0zNr
 wdaK8/qFzJxpGzemwDGnujRB0fw9jUFStSBtHwvLfSOpNrE4awVmsFzox1imb/lRqWJK+MYKG
 shV+ZeWCxWx/DbRLxIq6G6os754LOYwVXzslOSptOGwM3G4ro3cJWEG2ytxFCAjzHEYGqWfXk
 E4lzHqW6Hh07S/qzClpTqF9QTMIOoS1Dngq++zGHt6QNY965Q5W7Pt0aePyUrU22ILVYRcFZC
 +zhTTJ4bnGUHA8jC20Lq5qzU/8bQjb/lKVZQZCU0PyUeM4tv2czblXi82vRM3HAiHHHjfekJq
 8vGnhp/xZLv78SYmG3fseLT5zarvjZCWOmTm+pGTxlIzZHe3un4DZGnMXCE6Ty9ruBDuc2yqH
 RsvVU/Pkbhfz80C9ye8vVGzRzoFZzwKJqcIqKMiRToEzGBw+b
Subject: Re: [cocci] mtd: cfi_cmdset_0001: Fix exception handling in
 cfi_intelext_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2613
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/bf19c4f4-5ed5-4210-b123-92f79d27d6e7%40web.de>

>> The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another point=
er check despite of
>> the detail in the implementation of the function =E2=80=9Ccfi_intelext_=
setup=E2=80=9D
>> that it was determined already that a corresponding variable contained
>> a null pointer because of a failed memory allocation.
>
> Can you please rephrase the commit log? It is super hard to understand.
Which wording variant would you find nicer for provided information?

* used jump targets

* null pointer assignments


Regards,
Markus
