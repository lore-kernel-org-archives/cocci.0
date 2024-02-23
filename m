Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE015C48BC4
	for <cocci@archiver.kernel.org>; Fri, 23 Feb 2024 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=Va8RZ1Uqg+yOFEpg6rdOQgNcwKhPj/O7tk2fECOftyI=;
  b=ndFDHbAZozq/V4/+1C+jJbekjX5xvbPKf7h3hLm/kStcKASjDLxCOTbp
   BtmEe20jUCD6qSvyRj61PzR7co3x7yQDzh9mwaokWw4zeoN3Ewe44F4jy
   LAb8yTF99MGRzFm7h4McQmemRMpa3Aqf1CaoXE4WhgCVoRw1GF1XYO6w8
   I=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153405361"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Feb 2024 08:25:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 79BBAE0CD7; Fri, 23 Feb 2024 08:25:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0FABE008A
	for <cocci@sympa.inria.fr>; Fri, 23 Feb 2024 08:25:34 +0100 (CET)
IronPort-SDR: 65d8486c_ESddn9OWDm1zoD+4D3bbr0SPDu/u5qhP1SRzzGFt5i1Jhkc
 R/RlrgZMiaUrS5bJasAbeHWbqC6m1NQQNPD76OA==
X-IPAS-Result: =?us-ascii?q?A0E/BgCCR9hlhwMP49RagQmBT4I5YhoDUzIEC0iBT4MEj?=
 =?us-ascii?q?0SBdYRrgVWNMIhwgxY+DwEDAQ09BAECBAEBAwMBDYF+imQCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhWwNglUYg?=
 =?us-ascii?q?Q6BJgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?kdqHQEBESc0AiYCcwEBgnwBgioBAzEHDQaxPoEygQGCCgEBBoFYQU6sdR8sI?=
 =?us-ascii?q?laBYQMGgRouiAwaAQVliWgPgVVEgTwLgkeDUAEDgiuDDoJoghaDO4EmiDmCQ?=
 =?us-ascii?q?gGHPocLgVMcA4EFaxsQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FVANABkkLA?=
 =?us-ascii?q?wIaBQMDBIEwBQ0aAhAsJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2cfMgk8CwQMG?=
 =?us-ascii?q?gIbGw0kIwIsQAMJChACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEA?=
 =?us-ascii?q?yspAyF0EQMECgMTBwsHeINGBBNEAxCBNIomglQDGSsdQAIBC209NQkLGwYiH?=
 =?us-ascii?q?gKfZgGDNRoTLIIfk0CyCzQHgjSBYAWBXAyIeIEjlR0GEy+XMQ4GkmAemDuNb?=
 =?us-ascii?q?5U9hUyBeiSBXDMaJIM2TwMZD445hBSBC448QjUCCTACBwEKAQEDCYVGAQGDW?=
 =?us-ascii?q?oFGAQE?=
IronPort-PHdr: A9a23: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
 GokG6uohqKd52VUj6cnc1E=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CvV3E6piaNVEXhThxDs+bC8aV5oJeYIsimQD101hICG9Afbo9P
 xG+85rsiMc6QxhPE3I/OrqBEDuexzhHPJOkOss1NSZMjUO2lHFEGgK1+KLrgEIcBeOk9K1u5
 0BT4FDKJnXEUVwi9r87TK1CtA63bC8gdiVbKvlrkuEVmtRGsddBupCe3+m+sYafmN7OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3Avc0C7mvQTxGgIZ+UDEyFl1wX6It4WXbM/GjqGHa?=
 =?us-ascii?q?ELjhGFJPNFUG+o/p7xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AE2hixQ1R5C55qRzzNFZw8AxjdTUj3puvM0AvwYc?=
 =?us-ascii?q?6quaBZAZwOjWEkT+me9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153405350"
X-MGA-submission: =?us-ascii?q?MDHTqoGXQErUf/7Z1ioe4d4CFSDLw9L5GK3Zn7?=
 =?us-ascii?q?UCUQmyjRCIs9oq+FYlX4fXNP3kjCd+NHgxvMSIXFQVKE8R7KIbJGol/Z?=
 =?us-ascii?q?7NdoG5wgZ8/LA4EEg941GnZpd4pS9CR+7vMWUuqv8HDQKWLBVFzqVPMC?=
 =?us-ascii?q?6exFALd/jdDPI3noI9QaE28g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:25:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708673133; x=1709277933; i=markus.elfring@web.de;
	bh=Px1fQXRYzuThD1PWRNmaemuklpd+xRbE47JewbTbme0=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=NwGgdpqKKZnk6J/yIGYUV9fiUt0P6tDl2pg+vrhuiiT+VlOaFM5QiwLcNNhg2j2G
	 2h8i2xuzoJW+McPinLVSCpjv8M4+0kC2hlQai6iB82pz37R08WdWnzBMLsdoU4c/I
	 Ql+fMrhKQwDE4ojZKBEsTgTRVGY+8I3rtRQ614K0SiR3ghLZlDM2AUT3sIaahzXg4
	 3m1qkSl31TyOtnSlKFh4yL/2Os2ciENgPrLE6t7eEejCp5fgWGk0PP1yhUh0oSkWM
	 3gR7aZYIPVYyH3488q/R3ase2wPAaokhxO3QEfIqyqtco6UyCqZR+HS2c9VCZl6H7
	 FOGnVMzKaPVFKRnS1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1qhCe9177M-00yjFN for
 <cocci@inria.fr>; Fri, 23 Feb 2024 08:25:33 +0100
Message-ID: <784320f8-7731-47df-be6f-9ddc71c20d61@web.de>
Date: Fri, 23 Feb 2024 08:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kRNPkV24f4Uv1FI0ZW+xTAqnYGcgQmodSNgVUSW9srZ43H5l++P
 dC31nJXxVRXJ1u9ijRFrrceLHm4zIUJDpDDnSee3UA8IaCiO1gJ98I6AA51RVNTcO8cOvqz
 t12M7p7Zt7oWT1teFtBfBgezJYolHC+qwuDX4EooXRLxt8LNFqdc8ty/XxiIi+s4rG6urd8
 y3h8SyuKnc33I1RyZm+7g==
UI-OutboundReport: notjunk:1;M01:P0:sh9oduYeFH0=;UEjlwpo19Xj5eusRBKViVILuHsE
 5sF3v02xEyPCysKRIxi959HhiIAgh5atHm9s7FN4HhwkTKWJXlE8JpBciz4iuJdVMSRSehMKi
 LIfAc66OHHY0G5bGg4XzuYoNIGBDcwhnhNkPt1hyfTHCBIIj48d9Nyf2LRi6jcKf5xsFRFpWA
 X7n3fM7KhYiCow9Fd1J2Nda/6V14XgQhnGOCZeF1yTdfZqsQZgb5u9J60nrRT5ojleVqWCB5G
 ezLB6ik/ctlIsJ7AisuLiFvcx/wM/JoYVpQbe5WC22mCDLwmBgp5BOQlcTcXSRs7hs1q4fiBA
 82hrEn9ckerzrcMRR8zHsYMAfNknJGYkANtq9ww0UZI4Ie9NDpAbI2UV6RBZQQnMx0xyCFbz8
 2utRo6MEyDGvKLT9otTdLXPAx3co+iEN+J0Z6uYX0azcaAvkKGS79fsvSa9/Z72rzlWshDw4X
 /iKaO3mmw1mlgQhNIHsxaQ7pdSl2W7tCcGqBvyYCdELae3VWCi9inEc0AsXGfbfgiECiurxQn
 bMYXzDN24p7qgkV8KJ1Kj6izqamkg4NpQyGy/sJtwy1jCwtv9s+Z8ZjyI49OJbYSsHjyF0Bij
 aLDk4To8czj6zFdH4K2gLho2Jo89qEc+5xArVHEd62s7BGJxT2RocYTGwj0B5NAUV64L+mDlH
 rr/GfLdatKmKPniZIw38oAANEpqZllQK+h3Ypagr8SPSIp0vn/dUkRwFgljKll7DnS77m+W8L
 DPZdTF3rExKYhphJ5LUrUW9nBS+WBHXUovAIlnhfpKZXiOgbiimxcafXr9dgQK0oaVBT1klEO
 qfEVCRMOlcfxj+a25RfITApXXGX5K+xzqlAYstx3IxknM=
Subject: [cocci] Using inherited input data for SmPL script rules?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1598
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/784320f8-7731-47df-be6f-9ddc71c20d61%40web.de>

Hello,

I tried another script variant out for the semantic patch language
also together with the software combination =E2=80=9CCoccinelle 1.1.1-0073=
9-g68c580f1=E2=80=9D.


@first_search@
identifier id;
@@
 my_work(id);

@second_search@
identifier first_search.id;
@@
 my_log(id, ...);

@script:python selection@
x << second_search.id;
@@
if x =3D=3D "apples":
   cocci.include_match(False)


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi test-inherited_input_for_script_rule.cocci
=E2=80=A6
scriptmeta: semantic error: bad rule second_search or bad variable id
  File "test-inherited_input_for_script_rule.cocci", line 12, column 21, c=
harpos =3D 161
  around =3D ';',
  whole content =3D x << second_search.id;


Can the application of input data become supported for SmPL script rules
even if such data would be inherited by longer SmPL rule chains?

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/68c580f1f1abf9979d591=
371e5b2e474f97dac90/docs/manual/cocci_syntax.tex#L655

Regards,
Markus
