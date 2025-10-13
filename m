Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52635CCA476
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BAyNqSSrJGUl7HzMWFCaJF4Em7mHepMhTO6rd20deF0=;
  b=u6h/xxnIOEzp2YtKosnvKeUTi9dXBwf28m8OysnMxN/0pvS3iYxoPmUv
   hgIcUd7BTxLNpuKlGH04LLhRaV13pUStDJ0GycElZ6cO8Oya6LJdlREun
   PlF84rbOZrft5y9vz9RUAqTLvRGKFYzVXkDaC9vyVvFS54yAZHL8lZiGX
   4=;
X-CSE-ConnectionGUID: oaFiJcY2RXyIC2HycuZoQg==
X-CSE-MsgGUID: 3ocjNVJbQy2pvrChtVSVIA==
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
   d="scan'208";a="243885223"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 14:17:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7C2EE0C55; Mon, 13 Oct 2025 14:17:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01FAEE0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 14:17:01 +0200 (CEST)
X-CSE-ConnectionGUID: Y/Jsh8jqTry1EM5rOg2iVg==
X-CSE-MsgGUID: rv0faDWbTA+ZGed6jwsEnA==
IronPort-SDR: 68ecedbd_XHzpcJWMlAM/VXO9skz/ebDSdA6lCa2uU4grIbsFkzNsFg5
 OEt3f1UGIrKhvuhXL9hjLCEJXGJkAQlAiEPqfVA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkAQA37exogAQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4FAQELAYI/ZR0GWDMEC0kIhE2PUoIhbINSjxGIeYFVgX0CDwEDAQ1ECgECB?=
 =?us-ascii?q?AEBAwSCDIJ0AoxKAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECEAEBOwcOCjGGFQczDYJiAYEkgSYBAQEBAQEBAQEBAQEdAg06R?=
 =?us-ascii?q?AIBAyMdAQERJgEPCxoCJgICSwsGARQBAYJ+AYIiAQYQAQM2Bw0Grw2BMoEBg?=
 =?us-ascii?q?gwBAQbaXx8sIlmBZAMGgRwuAYVsgmQBhVxLg0N6Jw+BVUSBPAuCeD6CQwcXB?=
 =?us-ascii?q?IFeg1uCaYImgQ6GNJAVUngcA1ksAVUTFwsHBYEgQwMqNC0jSwUtHYEnIiEeE?=
 =?us-ascii?q?2A9F0CDSRsGaA8GgRMZSQICAgUCQjqBagYcBh8SAgMBAgI6Vw2BdwICBIIxg?=
 =?us-ascii?q?RKCKg+ESwIBC209NwkLGwY9kkGECRsQgQVAeMY9NAeCOIFngWQMii6VPgYTL?=
 =?us-ascii?q?4QEjROGOw4GkwWDV4JLhHONcSKNZps5NoE5ByyBXDMaJIM2TwMZD4k2hGsMF?=
 =?us-ascii?q?oNeM7kJQTUCAQE4AgcBCgEBAwkBgVWDcAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:utkjJq+YoKDnPiMMpuFuk+AMI+orL9Y04lQ7vn2ZhyYlEPBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3Aljpf1GkpubR34nfT/OWF+9ZyYZDXOUya7mzQc02?=
 =?us-ascii?q?hNXx4EZCwFEW39/llrcU7zg=3D=3D?=
X-Talos-MUID: 9a23:HagYewoPVf/7awjaejUezyt8bMlhz5ukNGlOo7oLt5eGKjddPR7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="128026856"
X-MGA-submission: =?us-ascii?q?MDFVjAo9V/rrdEDmDrimORB2e56kWTSWWi7Rw7?=
 =?us-ascii?q?/pQfgYsuk7dvdwUTR9pdNmdM5DfyCYJWbIaz9ggwDJyWHex3nOjLEZVP?=
 =?us-ascii?q?Ig7EvjU1dwo1PN1QpCaUaP4G7KOnAHa4EG8nTQTdCSLGUm/bR6ffDvx1?=
 =?us-ascii?q?uvT+LafcadbEhk2htFXgmi2A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:17:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760357820; x=1760962620; i=markus.elfring@web.de;
	bh=BAyNqSSrJGUl7HzMWFCaJF4Em7mHepMhTO6rd20deF0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=heQINvJRw8qPIiBjyZl2G+iwcdJ+yQ/UPQK02jCjhFoPi1KkTPPyQLmqOP730zgO
	 kAuf0agCBM5z0ws2NyMlzarFqSIMbOvW44CyDsIi/oX+NoxJ17cr8BB4j2QhD7zaj
	 fQlUnAZB1qEzWkrDtlhz9F7b88JvoBCDg9XD8JpaSOd9GyRYkSsGm71wpW0/9HNUR
	 IhrdsFzxYdlZUA8nlw+lo+VUkkw0kDkcy2LIK0NPH3QXX0RmJEH/WkvYUPQf9gxZE
	 jtBe3Qci444MeGa4/32EwCLgCJeYcPQH0GIo7IvU16gBiLdPtOK1Z4QSeXYPcXG7P
	 IqWOtOTC1AlqaYJO/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8C07-1vDWXf37rv-0051Fv; Mon, 13
 Oct 2025 14:17:00 +0200
Message-ID: <1865e9dc-c6aa-489d-8945-e5a29a470523@web.de>
Date: Mon, 13 Oct 2025 14:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: linux-cifs@vger.kernel.org
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
 <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NyWp/2GHyBJad5sAMyy+Abh5FesQUWopNdIxWqM72LF6H2tZ12N
 G1Up4cA3IgfTppe/p3+psqeuOL3AltZtrT4mcPBhMV7MJ4UjO8vlutIl5ouz/WZRK2HWVkZ
 dzZX2ozUHGLS5auDtlN6aHU7VSCYAi1edsjbv/7YyK9+ocJ86BQyj0M15G/h/tl2ypgj6CN
 xC7pffsgRstemlbwNvk3w==
UI-OutboundReport: notjunk:1;M01:P0:t9j50hlWv6s=;Y8myFg5Mqn1he0prNu8Jd2GU4LI
 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
 +bup92JsERF0kc7ki7BtmB3U8KCruoqEq1I=
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3068
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/1865e9dc-c6aa-489d-8945-e5a29a470523%40web.de>

>> =E2=80=A6
>> bad: static int cifs_do_create(struct inode *inode, struct dentry *dire=
ntry, unsigned int xid,
>> =E2=80=A6
>> fs/smb/client/dir.c:211: passed:#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGAC=
Y
>> fs/smb/client/dir.c:280: passed:=20
>> =E2=80=A6
>> nb good =3D 679,  nb passed =3D 7 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 0.72% pa=
ssed
>> nb good =3D 679,  nb bad =3D 283 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 70.79% go=
od or passed
>>
>>
>> Under which circumstances will data processing become better supported =
for such files?
>> https://elixir.bootlin.com/linux/v6.17.1/source/fs/smb/client/dir.c#L17=
8-L455
>=20
> If you want the problem to be solved, please make some effort to narrow =
it
> down to a smaller number of lines.  Like 5.

I guess that you can recognise remaining development challenges for the Co=
ccinelle software.

Will the chances grow to support preprocessor directives like #ifdef and #=
endif better anyhow?

Regards,
Markus
