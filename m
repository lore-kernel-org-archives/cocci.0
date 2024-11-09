Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC0D5E368
	for <cocci@archiver.kernel.org>; Sat,  9 Nov 2024 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1c9XpO4wkJBPO2tu967XheS20E0y2qFr3CrCYN8hurs=;
  b=EejN3ETsVbWuX0p/ps1LgBs1PrG3UanUrMweBUhk5voDe4TpNBlGuHxT
   jMYUx3wENvFwgP/qOkG5QjXAm68wLL9hIgy1JLtme4oSwQ5FGexR2QBa7
   xjPaMCQUHBQa39KudUYs6bGpBv52P572ByVoNhXaqSEQVlo8cNhtR8GHi
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
X-IronPort-AV: E=Sophos;i="6.12,141,1728943200"; 
   d="scan'208";a="193051080"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2024 14:15:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CADAE0D1C; Sat,  9 Nov 2024 14:15:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1897CE00B7
	for <cocci@sympa.inria.fr>; Sat,  9 Nov 2024 14:15:07 +0100 (CET)
IronPort-SDR: 672f605a_Qg0jo3YtGrT9BPrHcCiP/JwHtcXSaXAplCH6dZTkJI2DaZ1
 uvsaOFAl1NfSWDOS+9GcDHYmDXORvnSNnEbrNVg==
X-IPAS-Result: =?us-ascii?q?A0HOBQCoXy9ngQsR49RagQmBU4JEYiFUMwQLSIRWj02Bd?=
 =?us-ascii?q?IEFg2aHOodViHWBVoF+DwEDAQ1BAQIEAQEDBIIMgmqKRwIeBwEEMQgOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYVMLw2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAkdtHQEBESc0AiYCcwEBgn2CMAEDMQexIoEygQGCD?=
 =?us-ascii?q?AEBBoJo13MfLCJXgWQJgRouhWqCSBoBBW2EB4YOD4FVRIEVJwuIRoMOgkcig?=
 =?us-ascii?q?kqFHIhSaJhagU0cA1kyAVUTFwsHBYF5A4NQgTmBUYMgSoUbgQCCSmlLNwINA?=
 =?us-ascii?q?jaCJH2CT4ElBAWDb4RvhGiCIx1AAgELbT01CQsbBj2eEYFjhDsBCpYRslE0B?=
 =?us-ascii?q?4I4gWWBYwyJA5ZSBhMvg3EBk00OBpJ6mHejToVVgWkCNoFcMxokgzZPAxkPj?=
 =?us-ascii?q?XgBhFXFPkI1OwIHAQoBAQMJhUYBAYh4gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:N+5B7a/Tl7wOkOyeXbRuk+D6I+orL9Y04lQ7vn2ZOiYlF/Bw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nlaKdgrN+AV7BZmXbUQKTRekO0WKI+UyCJ8SRzJ8+6Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AMPKn3mvEbXi8NpUixDU2HgAL6It/UEeB0XLVP3S?=
 =?us-ascii?q?IMmQxcKSHGGWOpbxrxp8=3D?=
X-Talos-MUID: 9a23:0BbhZQpcnRffLIf2SHcez3JLMtpLuIDzMgcAuocJsOamCClKGQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,141,1728943200"; 
   d="scan'208";a="101186150"
X-MGA-submission: =?us-ascii?q?MDF3ST5OkATakKLRiXW0ECxL55OyCZn4Latgi/?=
 =?us-ascii?q?5EDldaUtZFP0IFxM2o8vUSPwHXsqeYfepJl7iqhhyic2aRM4RKFH0bOa?=
 =?us-ascii?q?kZW/ZBJq2mafQGF8dnmb1pUAYkqeRRQzMcBiuhE9eG3O/wnwBzbvWXfe?=
 =?us-ascii?q?LVc0x58tFDQCgLX4PodOAqbA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 14:15:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731158105; x=1731762905; i=markus.elfring@web.de;
	bh=1c9XpO4wkJBPO2tu967XheS20E0y2qFr3CrCYN8hurs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=shoy1er5TYShoif35MfwdbW8qHQLU/tTW4X3HVyn3RrVwY/7lPfFGiUhD1SqJp04
	 dqqNOAM91R16NwpbhHHM8aifSuCBwQYWd0I6+GZnVWGxhjnQXkdYyg27o0gcSNbfR
	 /X/ICZ8hdzXVrrlBoMEVlBj7CezPI0wyUCJeFZdhVmBTfSs0ApallKi1lw/N39Yz3
	 ECyFsbO4u34BjE4VmAfiTUnUKC0EqBfVPy2JST8uV9VI/S9w9HF2FgG1QWpsd9JT+
	 3YJempqCoUyyTfy0jE1baropRCLUWBLo2B58fAob/SRtdgb5wKal2AKr6P7iTWDhu
	 kbP6NdSjJyy0iNWeAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1td2Nz1Q5W-00c1Cz for
 <cocci@inria.fr>; Sat, 09 Nov 2024 14:15:05 +0100
Message-ID: <2406a49d-1609-4af1-9af9-ee3496e48606@web.de>
Date: Sat, 9 Nov 2024 14:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7YB4Q9wMMv9dsQsDvQTuymPBfSkdlvX5aeWXUJyMmzn5djzwRr5
 DmKFsroOys5T8dra9g8PuC9oz0/H0KJvOFIGGyVQFFP0gG/LOl94gNIyiKO0ex6GdeTRMGj
 jKWelO1zScpBVRQxFLyrGExtd8EgpamZ771tKKSgNw/z3PKwaf5V5l0kkf3/sTe/NLX34cj
 uTRkx6mj9ResZXYCF19fg==
UI-OutboundReport: notjunk:1;M01:P0:k9+NjCy6ZEA=;COrE4aOUeLCDcMO1yAqBtszWnWt
 QyDKBqwxfBSgLIYLWALiheha7c8QWKwhq7sgK2p0PmfzacRKOjlS+pGTVLMDMqRcLL0SXfdPz
 AReL8cQQGEVmUGAnQgcA7Mr0KS2ObNEnPexWSIYRS71Nmm/xK2hi4M5um9xR3rpQ+G18DTKti
 vLq37RRPIDYRsMIdkGREzJlKKbHz2YZ5CXpwvuPne7OnvMIlQRg5loTYqkfzck+Z3AvouRIM6
 aFs8khNARMyx+JYAU+Ihl727MnnT0LKz6q6WBgnqyVvICFKiJSqZQYxwz/FgdeJ+JE5aOm37Y
 WUzhGhI57UD0Y4pusYGrmwLYht6EwuJhQ0YicXVifyj8Ts19Xb1Q4AqnxuIoo+57I7crcazQD
 sFa6ZeuEeDYdCNrpKqc2draZTMluL82XDuGlclXkN3/XYseGgm+J0e4uvd0T33e6a2yC4PaNs
 vQKwmv3oNngD3hGqXcykEwe7pfKvebg3DNDMmrt2Z/B+zciO2joSka2YuvoR7ffJ6spJ97aBc
 D1vE8h2hxP+V+dJuM5lp3rnLrsxcRRUFvT1+oJcFJWbvirebZkog80Ta4ZhyrH6+1USuwXFY9
 mugeIB+76XauAGj7/zeSpa0IksyNfykK9e2XL6wsM72swYl9Jdxu8zFQHZnOV66IOQprebILP
 SbX7MhpXSVXueExi/QrDic7GQwuwaQpGBWu4O/fiRvGmkrwwkGAzJtAqcUYKvYpl/J6VHM6Pv
 Y8J3B/iXdGF5Pai6TqHjwoR2tG9hElHTVMhZAGba4AuFudgjkHzLiIxBkeAl9nfp9le5qbpEi
 RMTX3aaIC9CFvx4auBgznaXQ==
Subject: [cocci] EBNF for Coccinelle file formats?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1974
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/2406a49d-1609-4af1-9af9-ee3496e48606%40web.de>

Hello,

The Coccinelle software is using some customised file formats.
Will grammar descriptions become available as extended Backus=E2=80=93Naur=
 form
for involved input files?

Regards,
Markus
