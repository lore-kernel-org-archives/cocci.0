Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B22C54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=kGPsDbmcVYbzF625GnZxUW44viQSQugR4kAubbvi1P8=;
  b=RZzXBtGXB20a2viWaggvY1AHCxi0tW7uxEOqmDOnRDUISdnmjvFvjUDB
   XuDSIYnxaGcDsRl/FyIb1AloNjW6OIdOS3TvMKg6jehDn2Sz3R1RSXKNV
   rM5T9I7nbHz0YXSe9MYhTT9gI/aLG4zsqfw4KUpHUCeZcD09MN0Yj0Ref
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229434060"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 21:37:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD0ECE0157; Sat, 28 Jun 2025 21:37:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 52A27E0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 21:37:35 +0200 (CEST)
IronPort-SDR: 6860447d_++qmuVXEC1nirsdD1XBROYKFJYXpB3eB4X96JMV/965Zhqq
 /7h2sIn4izzN2qLTE5rS/mgwKlFE8cIQWBpHnTA==
X-IPAS-Result: =?us-ascii?q?A0HPAABdQ2BogAMP49RaHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAA?=
 =?us-ascii?q?otyAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBO?=
 =?us-ascii?q?wcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+giIBBhABAw4kB7JPgTKBAYIMAQEG2l4fLCJYgWUJgRsuA?=
 =?us-ascii?q?YVsgmQBhieEPCcPgVVEgTyDAz6EQ4NbgmmCJoEWhU2UAFJ4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIEMDKjQxIw88BS0dgSd/gU4cgx6BG4RFK0+CKAF7gXpBGUGDXR4GbQ8Gg?=
 =?us-ascii?q?SEbNkACAQttPTcJCxsGPZMCgyGnOaJ3NAeCOIFmgWQMn2kGEy+DcQGTWg4Gk?=
 =?us-ascii?q?wKZBSKpGoFvCCuBXDMaJIM2TwMZD44hhDO8SkE1PAIHCwEBAwmFRgEBil2BS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGz384sYWQcTZepvvDQ==
IronPort-Data: A9a23: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
 YT4qa6oja17pYPM/R5cRkNo
IronPort-HdrOrdr: A9a23:gH8wtan+hEA5hLfXmxEvtfknjUzpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:lAv28GAPfm+aDK36E3BG32U1B+MqTibQ92mNc12kCDdYQYTAHA==
X-Talos-MUID: 9a23:qWg7/AVYvTBs2Djq/Hjnlm1DPdV02qf0IX08gakKltOPETMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="120204054"
X-MGA-submission: =?us-ascii?q?MDGllTe2Gn0vIiQ+S5RwvhwB3X1iCb7rVEV73y?=
 =?us-ascii?q?2wxSCQ/xE1inIcqQhcbqZqHsGXRK6RUcyBz4Q6Le0BEWan5tQwOWA2cO?=
 =?us-ascii?q?yIRAQuFdY6zXJUBxRFZb2B26d30+skfwUPA+lratbXjaojE/xZHKUR99?=
 =?us-ascii?q?Bqbi1njkglq5iB2n/AywkxKA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 21:37:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751139453; x=1751744253; i=markus.elfring@web.de;
	bh=kGPsDbmcVYbzF625GnZxUW44viQSQugR4kAubbvi1P8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IZWMWCrvxd/oPRy7qY4F6tS8ALPbnq/VC5QW5jhdvW7BnQVx5qhxcS3TaQkUSoC4
	 kBEnaa05EPl0zRMGhEEThcje98F7zTkaQN+FEwlfODS1InzxFoxAuUai7AQD6TKfM
	 yQbE3iN45jbK7K7Dsoy40Z1dBtdUeo+LE6JbNGWV+4nHV7nOpI0eOSJMWNCKZkoH2
	 HtURGA1kkYVhsyVhevaWhsrWRxZx+QMup5MB4ZAki1aweZs5VmKECu5f4vC2yJTsv
	 xpNahEpGlInyDKnicCY41uCD+U/03crv1ZSDLU7bid/zaNvWwv+wZF7zMf51pynKE
	 0/PCxe6WE0KhbViPUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Voj-1ujCI80rTN-00rO9f; Sat, 28
 Jun 2025 21:37:33 +0200
Message-ID: <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
Date: Sat, 28 Jun 2025 21:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
 <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
 <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MBHPuQMuX4S8Yyj+zNXLKkJAhWgDfvC0U7QgP2ohGdO59opJ6t5
 WjlKwGgY12L6weytI0kFAYaVU8Or47oB2rCrxGH1PwOehOZ1QZ5KUWVN0FkL8ml0lUmVqsS
 WxXCLYY5BLgdu+/aqX7/OyNFbJTb4/zotGfsi2tNNXtoT0nyDQ7ptZ0YHmEOwS3uG7IwdZS
 7gxy3g0niBLNKzeXg4Bog==
UI-OutboundReport: notjunk:1;M01:P0:I5CDzkTt1r8=;a2248ffLavdA+vR1sleQYqtHrNr
 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
 TyJU7BbIOgA==
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2801
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/8737f8dc-a10e-4f2f-8a50-87edc5c2aa78%40web.de>

>> I would prefer to distinguish a function argument from a data structure
>> member (despite of identical names in this case).
>> Can a manual rename be avoided here?
>=20
> If you want a metavariable name that is different, then use a different =
name.
A manual identifier selection can occasionally succeed.
Which chances do you see for automatic data processing here?

Regards,
Markus
