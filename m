Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C063DC677C4
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lWVG5YkkmIdbOMfxNLvjKWKL4w3DWbU0LoY6NFqIWr4=;
  b=IMdZud6w1M4O8mMsXcnwSZ2O5TNbftmJx27IlVaKaRpy/jVWh4TVWJ4k
   DU+PPIicQRSIxrSHKbhMAQsxavqGJUuyHBbH/IlQ3R52kAlHio+FEA7I1
   GRcJzfnB9ZgvGfeA1fjQpwoFJ9DHXQ5rSiIbFJ+kXUlAdKWfMJvRVm1qP
   U=;
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
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="226166430"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 19:00:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 19E8AE0157; Tue, 10 Jun 2025 19:00:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4F191E0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 19:00:18 +0200 (CEST)
IronPort-SDR: 684864a1_IPKcb0ZHebicbtEXYGif5tz6AQZ0Ud18FGz0+PDr5A/xR29
 M+cUFtLsu/NDIYNCyegipi0/FhA49rSZVWeS+RA==
X-IPAS-Result: =?us-ascii?q?A0E4AABBZEhofgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVozBAtJhFWPUIIkhDuHPIdTiHeBVYF9Ag8BAwENTgECBAEBA?=
 =?us-ascii?q?wSEdgoCi2UCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BA?=
 =?us-ascii?q?REnBAsJAhoCJgICVgYBFAEBgn6CIgEGEAEDDiQHlAGcRYEygQGCDAEBBtpeH?=
 =?us-ascii?q?ywiWIFlCYEbLgGFbIJjAYYnhDwnD4FVRIE8C4JHMT6ECjmDW4JpgiiBFo0Vk?=
 =?us-ascii?q?29SeBwDWSwBVRMXCwcFgSBDAyo0MSMPPAUtHYINhRkfgXOBWQMDFg8BgiSBX?=
 =?us-ascii?q?hyDP4EjhEkrT4MigX9MGUGDYR4Gcg8HKEACAQttPTcJCxsGPZhuhH4BgTCzB?=
 =?us-ascii?q?JRiNAeCOIFmgWQMn2gGEy+EBI0NhjoOBpMCmQQiqRaBagI2gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIT6DdbcmQTU8AgcBCgEBAwmFRgEBik80gUsBAQ?=
IronPort-PHdr: A9a23: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
 9KJmK+hcF+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23: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
 aMJqayoja11pYMd0SqtRpKNJCwkgQ==
IronPort-HdrOrdr: A9a23:rgt6X6w6anoivnwlzyeCKrPwyb1zdoMgy1knxilNoERuA6qlf8
 DHppomPGzP+U8ssRAb6K+90ca7MBHhHPJOjbX5eI3SOzUO21HYUr2Kj7GSpgEIcheWnoU2uJ
 uIMZIObOEYZWIK/PoSizPYLz9U+qjlzEnev4fjJhlWIj2CIJsQlzuRQjzraXGfb2F9dOAEPY
 vZ4tACqyureHwRYMj+HHgMROTPo9XKkZnhcFocAQI76A6BhT2l76O/CgOf1BsFST9DqI1SjV
 QtvTaJm5mejw==
X-Talos-CUID: 9a23:6lm1Nm9g3oE+suLtZH+Vv2cbFc83XkGG9lbJJmWCOD1EQ6SwcFDFrQ==
X-Talos-MUID: 9a23:wFLP+Qq8MGYZWYnie2oezyxgE8E22YXyMUEyg44sotePDBZcaw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,225,1744063200"; 
   d="scan'208";a="118685855"
X-MGA-submission: =?us-ascii?q?MDGMFkt/4mNKotZ5Shc84VuGyWLxiPaWbHKGfz?=
 =?us-ascii?q?9sZbmedV+UCdmlrl6EUGE6VeOGnMNRibced488RtMXzYADsaKoiViPqz?=
 =?us-ascii?q?quZ8B8G/F2nGECNseWN7CjKoKa72WVNPlF9ghSkkuvWj3soWg7S2evBc?=
 =?us-ascii?q?FAVnKXuaw5eN/P+AE388XA3A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 19:00:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749574816; x=1750179616; i=markus.elfring@web.de;
	bh=lWVG5YkkmIdbOMfxNLvjKWKL4w3DWbU0LoY6NFqIWr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KzyR4qVU6Xhw/8t163fi0EcgjnDSuytvC/Qd2BKtCkn0jjYdESkSv+UYZkYVToO2
	 dqFW5E2CEsk0C6z4vVo8g+u7K6Kr4AieL9xODEgI8wotnDExxXp4ttnZu/ohp5EQB
	 UmPvj78q3yFmWhXGt8HD99R1ybxG5qLVujjAb8xfkLtJoVxc+TOWtHL/y+oESF+Ba
	 3bqCsf0K3zndzVEw2DOqCjSVibIo1XjWzywWZxzpJD/a+pMNQZnV43hfKKunMtaSw
	 LJo4iBchYWEoylFc6q8M0AlA0qLLspb6k+HZYrMBfSlvMQptmg+hc9yADr7JODhh1
	 CkPe1qjP4Dbqm24IoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1Lwd-1uo6cl2NZb-00wN7q; Tue, 10
 Jun 2025 19:00:16 +0200
Message-ID: <3f9b8788-e9fb-4643-aee7-5ce5400e94e7@web.de>
Date: Tue, 10 Jun 2025 19:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <90822099-5434-4421-a611-785511926ecb@web.de>
 <alpine.DEB.2.22.394.2506101739440.4658@hadrien>
 <629fa64c-ccd0-46ba-907c-97bebc00fa0c@web.de>
 <alpine.DEB.2.22.394.2506101831510.4658@hadrien>
 <be43fd17-4386-4ddb-bb14-72d2d33d793a@web.de>
 <alpine.DEB.2.22.394.2506101850030.4658@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506101850030.4658@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JRh3vlOrIM7qL11k7kD+v5Q4q7pQEjQ+Js04dyTPgY7JxPacAMM
 F34Aq9PnmUFqC3wLh7wDlu2Dhvg737ledl5vao9YqZm77OwiSviYyAdQ/Xrwz3J8Mmx9+ei
 IydTjtk1UNBUKabmHANWuTRogLw2igtL77mChXpnz++Wrj6lFq9Khum9zWL+Hn/8Kg9GSQF
 uJZVNxBaF1Tt/hkBQ8mjw==
UI-OutboundReport: notjunk:1;M01:P0:s8jOREzirD4=;qiDac3O44Vjnq42fvpUyb3Vr2Ut
 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
 D/hrJXT
Subject: Re: [cocci] Checking another deletion of redundant null pointer
 checks (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2757
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/3f9b8788-e9fb-4643-aee7-5ce5400e94e7%40web.de>

>> The log file =E2=80=9C=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/d=
eletions1/next/20250606/delete_redundant_checks4-errors.txt=E2=80=9D
>> contains the text =E2=80=9CHANDLING: ./=E2=80=9D 7675 times at the mome=
nt.
>=20
> Please actually look at what I asked for.  Does it contain HANDLING for
> the file you are concerned with?

I reported that I miss one file path at least from such a data processing =
result.


>                                   It seems obvious that I would not care
> about the number of occurrences of HANDLING in general.

I wonder about such a feedback.


>                                                          What would I do
> with that?
I would appreciate to clarify if mentioned files would be completely acces=
sible
for the shown source code transformation approach.

Regards,
Markus
