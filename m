Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF5BC3DA61
	for <cocci@archiver.kernel.org>; Sat, 27 Jul 2024 07:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IAP/cmL1k21jj+aPFhBvJsn8BZe4aqYzc0NRUvYqKz8=;
  b=PaXE9K3L9eq4inFN4mH+fq70ZUFnskDwZb/IdYgTgmA0FqYnmv7FzKJK
   XEZ78pRolulWtPcnq48tyQAwh0quVflMnNINJ6Pg9mY8wz61xJJAtHiyW
   7bjhVoxDcNOwuSp3Khvy3q7LsLzKkuCPp2agU+bQX7ORDb/JhEjjmtgeF
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.09,240,1716242400"; 
   d="scan'208";a="177179306"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jul 2024 09:07:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 85A07E0035; Sat, 27 Jul 2024 09:07:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 510BEE0035
	for <cocci@sympa.inria.fr>; Sat, 27 Jul 2024 09:07:37 +0200 (CEST)
IronPort-SDR: 66a49cb8_loyLJ5xTDTIPEFqlfBj1lkcaIMsRYKXRuuVHn5k8onaG46s
 kHC65m3UfvsJW1HQl4Ad8Z/zzkXIkpC9PfMir7A==
X-IPAS-Result: =?us-ascii?q?A0HMAABOnKRmhwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYhpaMwQLSAiETogdhy6CJYQ7jwuIdYFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwMBhH8CiT0CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOCTKFdQ2CZwEQgRKBJgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAEBAQIBIx0BAREmAQQLCxoCJgICV?=
 =?us-ascii?q?gYBFAEBgnwBgi8BAw4jBw0GrTaBMhNuggwBAQaBWEHYQB8sIleBYwMGgRouA?=
 =?us-ascii?q?Yg8AYYMg016Jw+BVUSBPAuCRzE+gmEBAQKBXoNbgmmIHYoni3wmjXxUexwDW?=
 =?us-ascii?q?SETAVUTFwsJAgUQiWAKgyUpgUkmhBsIgS0Vg2SBawxhh3ZigQ+BPoFfAUmCd?=
 =?us-ascii?q?0uDaByBZYEkHUACAQttPTUJCxsGPaJNhFkaEyyCTsVUNAeCNoFigWMMiiWVK?=
 =?us-ascii?q?gYTL5c8DgaSbh6YUCKNWZsYgWc6gVwzGiRPgmdPAxkPjiEZg2EzgQvKYUE1A?=
 =?us-ascii?q?gkwAgcBCgEBAwmFRgEBg1qBSgEB?=
IronPort-PHdr: A9a23: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
 sJmol5zUVsoCrUFB04jENFQeP9K
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:Ii6PT6nSYyYx3tqJMf2r1ZPIjrfpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AMHALHmsha7IIjti9p32L1jjV6It7dEPt4XTiIHS?=
 =?us-ascii?q?pJjlCaOHScU3A2p9dxp8=3D?=
X-Talos-MUID: 9a23:mKFfmgZ5wjoZtuBTiS+3pjc9LcxS7IeLLHg10pIKo/GjHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,240,1716242400"; 
   d="scan'208";a="93064834"
X-MGA-submission: =?us-ascii?q?MDGMPbw7sBg+ZFaQG08WaXV7wK4t19QUoGWfE0?=
 =?us-ascii?q?maq6QFhVmyRhkXYTpNfb9WYIWyR4ka7k0aATK+VK06k4VlGqxHP3/5kD?=
 =?us-ascii?q?ssRq98Aya2F2FAmqUxaNNX1VhDZdSX7vqyekHe3rfY7pVlyFHupctjbi?=
 =?us-ascii?q?1MQA2tkI9a57uHjoTeMgUobA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 09:07:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722064046; x=1722668846; i=markus.elfring@web.de;
	bh=IAP/cmL1k21jj+aPFhBvJsn8BZe4aqYzc0NRUvYqKz8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aA17eBtQ6DnSqBiVfl+UMR9bkhEl1J/1EBMRDhqsGaPlXOocE8YfWIVGWA22b+z6
	 tQgCzehVPh6koJTCflI9W1n0dxPz9N9PIEP6rzK4m0AeXXg2noeGV90umSFS6/lAS
	 g59cgJVwWL4dwgeeE+lOJjZtaQYJxojd5HnfKVw4OTYllqu5c0WwjMQD5wuab4BCP
	 kHnjxCWqIYH6kI9CXa0lDPALjibLA0/E4v/40eogcCoSGA4YkHCE+yatKT+ivLmdM
	 3Ni2XU5KnI5FFnGW5QfbUeiORmujx23SvL90uViGD6OIL3UaU6m79xXuQbxT99P3S
	 eJV7nNEKjYcMzdGsoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJP4-1sIgCa3Aa2-018DyZ; Sat, 27
 Jul 2024 09:07:26 +0200
Message-ID: <20987ebb-4bca-47e6-8957-211560c55cd8@web.de>
Date: Sat, 27 Jul 2024 09:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Chen Ni <nichen@iscas.ac.cn>
References: <959b8771-76a1-4cee-a7b1-2b391deb23cc@web.de>
 <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1584412e-94b-4c10-6f96-9da68f4ed1d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iie5PXQvMpX+QR41WcBJuNCk6/8IV71KCVWwmz4C2D3zDlAF2jZ
 61QF1fK0I+4vEpVm54pc8W4mbmPPesVecxtRSrkXIXOHEZJJurd3nxhSxexyLharchjTizz
 NF04Am7kVeoOseA1cQFDdZS1YLt2EtngnJbOazDjR3lTXjbdRR6QvCrBEqEOBbJslBvHrlH
 mH3SIbTF/m3xkNW3erAeA==
UI-OutboundReport: notjunk:1;M01:P0:TP0fckvmqyY=;inu2CehOgb3R137l3F11IkLdTbp
 iw4b8ZzlgQb7s3ZeW12wMyIWdgyp0YoYp0aFfbFOwmgptd8qSEzAT7jtxTCmQmPGbzC/sm7gM
 9ZpPDjipqhZE5BPbORrqvJgI3m6HpXRY8MKWLkd/YmjrHCF+adLf0Q7nx5YlBPM1qhxXN6fIR
 /FKZihZSI1IBNpRTwVJF5JEyyDDmH1DW9dvzytlxuhbSaEEw4gyXRRdYg3Tbuw69l8A/LyeXf
 EImUTZ+IASsfRmEYh2biBZeBURU2OupAMdNLSaV6uMJ4hLE+lxlYFaoprUwBTOJBSDZoYnD2g
 Gh3NBU8zQdrSjWGy05h8wcybw+x0kuGmv056gmakqKfW4TinHT5Mm8rhxUF6ylqeG86G8Segk
 f8Snd7VOPtKd5dwA1OU5V/JZ2hOWGiBVJ5mIoLHjSLHgQFnmPT3XdFNAbL45OpE10kRZhTSX/
 GHqY3PsbjtLpzp17NrW2NqKJ7LE1PlU7Yu88IwFQv44DM1Vc7Ez+gm10Jl9CkoUTDyEvj2+wl
 zd0i5QfsCbBx4UlOvJ60dfV2VOckZ+azi+wOj02RrOjabkmqsamsGgWtdmDKfjR9Pw6gfQ4si
 p50iZ7nC/EV9Sa4TvD+3pOuz6eRUXb0vW+HfbsloIhZ63aej4MkDenqRJgP55ipCosL5cC/t6
 U8FQ2JMVC/aBnwq5qftJSyTdLJnOMj9CeWwNaZ6jfrOq+Q/YsJqyqUzpFcwhssCLneffBKAsi
 CsMppAbg0aDMWrkpfw5xFp+yLB/ohco/Mj0QhOM5lGmIBfcLV3RYPCmDtcswp2Qkc/l20mlol
 wcd8Hhahhz8ROoa/4FahJgWg==
Subject: Re: [cocci] Data processing challenges according to the comma
 operator
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1824
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-07/20987ebb-4bca-47e6-8957-211560c55cd8%40web.de>

> The above semantic patch does not parse because te ao e, is not a valid =
C
> term.  There is no term in the C language that ends with a comma.

Can a source code search approach (like the following) become supported?


@display@
expression list el;
@@
*el;


https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/587259e014d0c83ac0517=
02354da4d53e0905d12/docs/manual/cocci_syntax.tex#L359-362
https://github.com/coccinelle/coccinelle/blob/2297fc0f90ce8bef78d2977e9aac=
c188d7e87c6d/docs/manual/cocci_syntax.tex#L359-L362

Questionable test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/janitor> spatch --parse=
-cocci show_comma_expression_statements.cocci
=E2=80=A6
minus: parse error:
  File "show_comma_expression_statements.cocci", line 4, column 1, charpos=
 =3D 34
  around =3D 'el',
  whole content =3D *el;


Regards,
Markus
