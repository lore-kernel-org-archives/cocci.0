Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA3C47DAF
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KBLCtOtyqac8x3lLPrq67tXcJZwAG+cUNS759ZZ4Pjo=;
  b=I6p2GCfouky9LoKoqoxfHsV3XoBMHujJkSMN+ZiayOt7TTgb+id61iyC
   B8LvOTR2retuYhgAJx2vkOVaEIFAlGL1LqyqgOQAR+E9zya2C63Tr4mGw
   PSucWcTQkWvJEIzJrAlMah/cs5+GSI+F9LLQ7eObvLFGVR/du5o6CwrzQ
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147880870"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 10:17:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7513BE0CD5; Mon, 22 Jan 2024 10:17:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C5AA8E0035
	for <cocci@sympa.inria.fr>; Mon, 22 Jan 2024 10:17:06 +0100 (CET)
IronPort-SDR: 65ae3291_Q0xvxOUoOpCebP38m7sFJNnclcDHoxnGGrJG9uN7sj1j27j
 8QawQsU4dq22v3JcEDsBzWJ9tCRyRGFhgq/D0Sg==
X-IPAS-Result: =?us-ascii?q?A0GVBACaMa5lhwMP49RaHgEBCxIMQIQIf1MyBAtIhFOPQ?=
 =?us-ascii?q?YF1MIQ7hzaHToRrhASDFj4PAQMBDUEBAgQBAQMEhH8Ch0YCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFbA2CXAEQg?=
 =?us-ascii?q?QyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBAgIBIx0BAREmAQQLCxoCHwcCA?=
 =?us-ascii?q?lYGARQBAYJ8gisBAw4jB7RdgTKBAYIKAQEGr1kfLCJWgWEJgRouiBwBhWeDQ?=
 =?us-ascii?q?XonD4FVRIE8C4J4PoRDg1uCRiKBG4RBhU+MA1R/HQOBBQRcDxsPHjcREAUOD?=
 =?us-ascii?q?QMIbh0CMTwDBQMEMgoSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQA2UfGBoJPA8MGgIbGw0nIwIsQAMREgIWAyQWB?=
 =?us-ascii?q?DQRCQsmAyoGNwISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd4ghCBQ?=
 =?us-ascii?q?gMZKx1AAgELbT01BgMLGwY9ApkigUSCX8RwNAeCNIFggWEMny8GEy+DbpM5D?=
 =?us-ascii?q?gaSWS6FBYJQFpA7IKhNgXojgVwzGiSDNk8DGQ+OIBkfg3OPR0A1OwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N07y38N8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:MIsAcKzJqXFh0ZMBRVbEKrPwOb1zdoMgy1knxilNoNJuEvBw9v
 rCoB1173HJYVoqM03I3OrgBED/exnhHO9OjbX5VI3KNDUO+lHYTr2KhrGM/9SPIVycygck79
 YET5RD
X-Talos-CUID: 9a23:xPL1VWwu5q5etLxoSGHsBgUFFMEUTkXh0kzrYH+8O3R2RZmWVH25rfY=
X-Talos-MUID: 9a23:e5z+Jwp5vddQo4gca48ezzdmH5hw7oC3MmIAwdIpmeicLy92NB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="77436951"
X-MGA-submission: =?us-ascii?q?MDHT+HpFN4huG5FsFo23ZehCDx816/tOa12NWj?=
 =?us-ascii?q?M02X0/yteWG9wfh/T0i5Dux0fyOSvrs0jT8SksAUEuadSoNpe6pPIbVH?=
 =?us-ascii?q?ZdLdwnP8i5ygSecMSOasdV/+mHt64M+C8HtwX+vf6D/N9jS1pEhgLkHA?=
 =?us-ascii?q?x9FSyWubhxcJs5mndTI65X8Q=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:17:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705915024; x=1706519824; i=markus.elfring@web.de;
	bh=mtduuqe5/RkHoDCDNXg5CIs7GgpBB82qessFrFtHGRE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OcGyh8ihnBJ7xBdweAtrMrBhltHejXE1NMEbhNmn0EgSlbZdzWIe5feCMBLpYz04
	 afKRQvKaXBgjq63Olm8wXbBUvJnd1HgPGDV6GEN5xE7EA0ujJmefjlWlBmlpOfKWJ
	 +QaACQUcalUHTNw3Vnymr7Ch2102Xi7KOvj5D+2Brc7N46DvtmbLHwxuOC/V+S6j4
	 9VBIC5M7ro+H1yMsMM0QR7ZGHw304+/9uYf/S7baFPAKWF/0Trt1Jrz4ReNZvGko+
	 msDneRJQuKu1RnYsDrM2EXvkMLJ1UluyMCpQR/mQzR6TcxOYtxMqokemKIjNsbAzZ
	 dyh4/Yxkh+/g9UgEyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1qzhdZ2UhN-012Iu6; Mon, 22
 Jan 2024 10:17:04 +0100
Message-ID: <a9dcafd6-07c3-4bff-9203-ce1f9f114b75@web.de>
Date: Mon, 22 Jan 2024 10:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, Li Zhijian <lizhijian@fujitsu.com>,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
 <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
 <alpine.DEB.2.22.394.2401211159350.3743@hadrien>
 <161c3be1-011c-4ffd-8646-1b95f1a461eb@web.de>
 <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401211220480.3743@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVJhxdUSwmU5DKJWNtg0qUNfPYJKuqsTX/0gCW0acueX+/ppdcv
 Wx0Rtg69phOAOjypmM0hyuUcApBj2idDM4ffSaXwWosbW0EyESpVPD1FYG9A5M7lt3RJEhL
 7mYvovfIOva8qCwUP9UXjgo6h675gApggYA3C8FXMOJo9FFrTFBj+qDG2wWqy3qGv4bsa1i
 iniDevwdPi2E2irlp2PVw==
UI-OutboundReport: notjunk:1;M01:P0:TalHp1KW6BM=;aViEpTEmyLlfBptGi/00su5EYsw
 huGHvpaFA37IeBIBonlz8BDCRBq9UXRPOVH3GkFcDTsshWhPhZUzCmDMiFkL7jOqSn0XowByS
 7VdLDprefbwPDJEQwXXj7kN7kVfvcRUV91S6EW8dMX7XdV1szRKrOYCVsq3pgNH/BZCN08w4p
 7wTLuFnL/LgczFTm32zHJqgI0xC6wKZ8Fh81kvvh/uYFbzBVxFHIRytBiLJm8Spt5/Z4NlVJd
 TXkl1ckpZnNA/babNZf9HZhJ1soKZVQyUgzaTZ0r6cOxguyzPXW3R0ckyGgqCEwnRGkwFAa78
 8LiQHULR8QCnV8kDXz015Pg52R7Mq1qQiB+SziQDs7Sd7040D5CChExHPn0kGTax2n91naEVe
 eKKupjkXFsAVsQegcLpDo0P5jphOyKTFTbEsUWLlHh3enA/GQzucYAp+DblsbT/QoY0EXivv4
 S6XqGtXZwSNH1QPwphbB8B4HvvXUJKFuuTk9XKUo2IgHdjC/KAecoSS56YzpUUJvKy63OWy7V
 j6kZd53E2dwiXkQG9Jkq9+9VlVUJcwp36vJCvsFfxc9KYLsDl2Jn+awqFDLiyWfQOEQJB9+BP
 nkxKNJKYPqg3XtZQ+L70pQQVQYWrdTvClVpZiRD6Tch7cbruAXqGoEkAUfFKmeLLEFj2mhr0Q
 IgRkQI1v7bH+RRmWCcGD06hcQSU7dsr6x6wL7LWSOH+Gdgs/r5S5pNSRgcvoXD6NIHstVU4F9
 s9twKtIjXO6w2Ke4qA906kbPpmHzqHkWun71GQdAtx1wVCPuOA5MWZtu+4bXt9bRIvswcXo0b
 MhNmKWGKUScHeQjXdUWneC+UOjIhw9kZguDYLkZxi3wpL7dguCidac8zZzl1I7oAazRWwu9pL
 zS1PEtjZz5L5KOJAXtjMmcJNQZutUSZoRrhBMLgptTlNjLuygr8c+Ca4eTxTo5bwPH5jjjKnm
 dubvhQ==
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1474
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/a9dcafd6-07c3-4bff-9203-ce1f9f114b75%40web.de>

>>> It's ok too.
>>
>> Are you going to integrate such a transformation approach?
>
> No.  I already pushed the commit for Linux v6.8,

I suggest to reconsider such a view together with the metavariable =E2=80=
=9CSTR=E2=80=9D
which became obsolete in the discussed SmPL script.


> and I don't think the change has any practical impact.

Can you ever get into the mood to increase the granularity of
a source code change specification a bit more?

Regards,
Markus
