Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB48CCD18D
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hXnTdgAPjYrdiEgZ19r0NNXYw0VFBc80NTYwccBdyYY=;
  b=r4/SbKmz+oytwyj2+YEaFiGfgsOCkIKmvnll2Srw7B/keciL2JXMuof4
   EXh4DHKWnLQ76R97Y/btcf1Y3r1bF+hmkOoe4Ka1Qogy31uhJnUyYcsmZ
   3BUrJM4BGxwWKewn+ezT6/S6QC9EekTCL+ryr35H0E9yXxvWYjqqf/8MF
   I=;
X-CSE-ConnectionGUID: iTygUbDmSX+PwcSHhVAP7g==
X-CSE-MsgGUID: 0TiOBCEBS0W8rLLU5uK0Mw==
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
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243950629"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 17:00:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A76E4E0B0D; Mon, 13 Oct 2025 17:00:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BD74FE0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 17:00:34 +0200 (CEST)
X-CSE-ConnectionGUID: SDJn0BIeRXyaTB08EFHdug==
X-CSE-MsgGUID: fBNAp4SdR/a0X3c+dgBSpQ==
IronPort-SDR: 68ed1412_FHV6fq0Dhk/r3NMBUorMV+id5lyLkugaP2PafD2VJbqw7uV
 4RsStp9YmP1EdSyZRPo1j+M6uc8JJPGWwgSEzOA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HyBwDOEu1ogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VCCQGUjWDMEC0mEVY9SgiSEO4c8h1WIeYFpgWkCDwEDAQ1OAQIEAQEDBIUAA?=
 =?us-ascii?q?oxKAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBESYBD?=
 =?us-ascii?q?wsaAhEVAgJLCwYBFAEBgn6CIwEGEAEDDycHrzeBMoEBggwBAQbaXx8sIlmBZ?=
 =?us-ascii?q?AmBHC6FbYJkAYVcS4NDeicPgVVEgTwLgng+g3xHP4McgmmCJoEOhjSQFlJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwWBIEMDKjQtI0sFLR2BJyIhHhNgPRdAg0kbBmgPBoETGUkCA?=
 =?us-ascii?q?gIFAkI6gWoGHAYfEgIDAQICOlcNgXcCAgSCMYESgioPhE0CAQttPTcJCxsGP?=
 =?us-ascii?q?ZJChDiBVscgNAeCOIFngWQMn2wGEy+XUg4GkwWDV4JLhHONcSKpHzaBSSOBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hDBaEEbkjQTU8AgcBCgEBAwkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 w==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XdRchao7jUH1R0xuLIaXo3MaV5r/eYIsimQD101hICG9vPbo9f
 xG785rsSMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaGSS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: =?us-ascii?q?9a23=3AxwBsSWnFY7bj3zyqpxzcej5eyXvXOUbx7nGICW6?=
 =?us-ascii?q?1M1Z4QYG/EQ+91oNojsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A7IkO4A+A2HM8Kvub2MiM99OQf8lCxY22VHsBq9I?=
 =?us-ascii?q?P4/nfPm98NB2mlA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128051170"
X-MGA-submission: =?us-ascii?q?MDGefvqH7BlVho2j6ZeOP2kVPz0nURzx7zDTZr?=
 =?us-ascii?q?QxDONRjDdQqqvB45SNJ8tYZ1UfMeW0LVWTeZ37LUW5VCok7aqSjaRvB5?=
 =?us-ascii?q?6RqUa4jEY9h1WiNcfpaaJrn9P8dPpFlPKf5wF7JpUnfao2VUTFbVvH1e?=
 =?us-ascii?q?Re9WPQsbn/KDxVPKyZzB/Ftw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 17:00:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760367633; x=1760972433; i=markus.elfring@web.de;
	bh=hXnTdgAPjYrdiEgZ19r0NNXYw0VFBc80NTYwccBdyYY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q4a/NOnDZKIPgbCSQl1yrmOWfZT68fzobEDlvvUXqet5EahD2hi3vgahuoay9COc
	 zDCQ7xWk+mlY7ijSUJuWbx72J6wcjBoVbZDHT+7xrhqrZWeSI2FZiAnZnHs7vgwK3
	 rrZK7D261Ga//jnXCvKGngO4FST0I+c3N2Y1vzXNEkDnwcAT5AUf99iwHRfxKOMCd
	 4edmSw7O8xDkSoia/RBWUylI2t/FEi36FTqcTe34ZcJFx5aned4mzVeG409IBP7TE
	 pBFrgJR9rrF3L/Jq/LJagsZdO9vMk4inceAu6MBcJ6KOPgaYQa6clySW8MKe3hM5f
	 bXNGf1oBE6dUlcWVZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtyA4-1uERAL0tau-017Hub; Mon, 13
 Oct 2025 17:00:33 +0200
Message-ID: <72c12d4d-3edb-4838-b131-a0d210acd615@web.de>
Date: Mon, 13 Oct 2025 17:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: linux-cifs@vger.kernel.org
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
 <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
 <8480276b-ee1e-454e-954f-b25890c79add@web.de>
 <dcfb5c63-ce1a-f487-df23-cadef6c45a32@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <dcfb5c63-ce1a-f487-df23-cadef6c45a32@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MifiNqkh69PsypW5fhJ8oAz229rudCJbuXROS8fFszplJBtJ0S7
 RetQUee+sUiOzYFSrMM4ZwyM+6M4kPO1sQHaPwrQBeiaHIAmtatjotTEiHSN9sbXxIUeF3M
 vSlw6yDcKq9PEteDAyfSgMELpWmf5j+Axqi8r98fQCxwUhhx+YZUgeEelDz+Lb6+1+Isl/I
 V/rNLuIO/MoV+T62nInSw==
UI-OutboundReport: notjunk:1;M01:P0:+7rkQam9mNo=;58ekecpjwUJeZ8W/TD9EAfz8de0
 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
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3072
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/72c12d4d-3edb-4838-b131-a0d210acd615%40web.de>

>> static int my_test_condition(void)
>> {
>> #ifdef MY_CONFIG_LEGACY_OPTION
>>  if (0)
>>     {
>>         my_log("working?");
>>     }
>>  else
>>     {
>>         /* Test comment */
>>     }
>> my_info:
>>  if (0)
>>     my_log("reminder!");
>>  else
>>     {
>> #else
>>     {
>> #endif
>>      my_log("special part");
>>     }
>>  return 0;
>> }
>=20
> Thank you for the more understanable example.  I think it should ignore
> the code under the #else since parsing is not successful when that is
> taken into account. =E2=80=A6

Both source code parts provide an opening curly bracket according to the d=
esired
conditional compilation.
It might be possible to move this bracket behind the preprocessor directiv=
e =E2=80=9C#endif=E2=80=9D
so that an =E2=80=9C#else=E2=80=9D branch could be omitted.

Regards,
Markus
