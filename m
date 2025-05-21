Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7F1C3ABC9
	for <cocci@archiver.kernel.org>; Wed, 21 May 2025 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6HZ8JQhY3iu1D+1yZuMNuG+MsPWjHOM0Woufswl65ek=;
  b=F25rqQ59N4rT7gSi1BOAD74kIaE/0Yfozl6AyuvyrDoqpOv6gWAyEenz
   1kkTRLYBhj6Vw01+Adv4yBbfCBnLlf44WO2WHgHW4BlkWDhcg93Bwmnqn
   t6830w/TC2XqlhvjgiclrEXqIzkbOgqUliJlNh24Uidb3I34NYBVI1lAS
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
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="223175687"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 May 2025 14:24:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB2B3E0AF6; Wed, 21 May 2025 14:24:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1B538E0131
	for <cocci@sympa.inria.fr>; Wed, 21 May 2025 14:24:50 +0200 (CEST)
IronPort-SDR: 682dc611_U/274lIOZlMS1eIRtZImE/QZgU4pgn/J+2jfLLWRDXr9qhJ
 HsB5KirsysCQORdhP2DWCAxldmFBRmAHyGpX6LQ==
X-IPAS-Result: =?us-ascii?q?A0EUAAAbxS1ogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVgzBAtJhFWIHIc0giSEO4c8h1OKTIF+DwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCi1ECHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjHQEBE?=
 =?us-ascii?q?SYBBAsLGgImAgJWBhUBAYJ+giIVAQMOJAeyM4EygQGCDAEBBtpeHywiV4FlC?=
 =?us-ascii?q?YEbLgGFbIJjAYlpeicPgVVEgRUnglIxPoRDg1uCaYIvgRZDEiuCHIl8ki1Se?=
 =?us-ascii?q?xwDWSwBVRMXCwcFgSZDA4EPIw88BS0dgg2FGYIPgVwDAxYPAYMTcRyDQIEjh?=
 =?us-ascii?q?EorT4MkgX5MGUGDNkACAQttPTcJCxsGPZdhhGiCM0nGKzQHgjiBZoFkDJ9nB?=
 =?us-ascii?q?hMvg3EBk1gOBpMCmQOpN4FoOoFcMxokgzZPAxkPjiGEM8gFQTU8AgcLAQEDC?=
 =?us-ascii?q?YVGAQGKdoFLAQE?=
IronPort-PHdr: A9a23:JCuk3xRzZS49JbCHFLoOUnTnGdpsorWVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBsODs7kf07We8/i5HzBbu9DZ6DFKWacPfiFGoP1VpTBoONSCB0z/IayiRA0BN
 +MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4VvJrwtxhfVrXdFdfhayGF1Ll6Xgxrw+9288ZFt/ihOof4t69JMXaDndKkkU
 LJUCygrPG8y6MD3rxfPSheB6GUBWWsMiBpIBAbF7BD+Xpjvtybxq/Rw1iqHM8DoVL44QTut4
 btlRx/ukycHKiU28HrLhcxqjaJUuwyuqhpiyIPJeo6VNf5+fqTAfdMGQGdKQ8hcWzBdDo66c
 oACFPQKM/pGoIbhplsOtRq+CheqBOPz0T9Dm3v60bQn3+g9DQ3K2QotFM8MvnvJttX4LKQcX
 +66w6bG0DvNce1b2Tn95ofKbh8vruqBXa5pccfL1UUjCx3Jg1eWpIf4Pz2VzOMNs22D4uRnT
 +2vkW0nqxxqojOyycksjofJhpgUylDC+iVy3YE4K9qiR05hYt6kDYBQuzuVOYtyTMMiWWBou
 CA1yrAdt5+0YjMFxI46yBHBcvGKdZWD7R3/WuiLOzh4mG5ld6ylhxa06UWtyu/xW9Wp3FtWs
 idIjNbCu38O2hHT5caLV/Rz8Ee91TiByQ3e6/xJLE42mKbHJZAszb89m5gQvEnCAiP7nET7g
 amLfUsn4uil8/rrbqj4qpOGKYN4lAPzPr4zlsG9G+g0LxYCU3Cf9OmzzrHu81D1TK9Lg/Ayi
 KXVrZLXKMAdq6WkHQJV1psj6w2jDzi4ytQWgHgHLVNbdx+fk4TkPUzFLuriAvelmVuslS9mx
 /DYMb3lBZXANn3DkLD8fbZh8UJdxhQ8wstF651JFL4NOPPzWknvu9zEFhI1LRG4z/j9BNljy
 I8TW3iDDrKbPa/IrFOE+PojI+yWa48UvDb9JeIl5/nrjXIhnlESZ7Op3ZgKaHCjBPhoLEGZY
 XT2gtcAF2cKsREzTeL0h1KZSzJcemi9U7o65j4gEI2mF5vMRpixgLyd2ye2BoNaanhcCl+QC
 Xfoa5mEW/AUZSKMLc9uiDkEWqOgS4A/zxGjrw77y7tiLuXP4C0Xr4jv1Nlz5+3JlBE97yZ4D
 8qH022VVWF7gnsIRyMq3KB4uUFy1lCD3rRkjPxZDtFT/PNIUgIiNZHG1eB6CtbyWhjAftiTU
 lqmTM+mUnkNSYcWx9YAK2ZwAdSkgViX2C6jDZccmqSFAJFy/q+KjFbrIMMo7n/c17Q6x3QiT
 NFOM2Lu0ot27QvOHMjkl0uDlqClXbsR1mjB+THQniK1oEhEXVsoAu3+VncFax6T9IyhjqujZ
 7qnCLB8dxBE1dbHMaxSLNvgkVRBQv7nftXYeWO43WmqVl6T3r3ZSo3sdi0G2TnFTlAemlU29
 GyFKBN4KyOvuWPYAxRxGFipb06/ufJmpiaDR1QvhxqPc1Un0rO0/hAPgvnJbvoJ3a8f/golp
 S91GlmVwN/cTdaN9EJ6ZKsJR9Q77R9c0H7B8QxwOpv1N6d5mlsXaBh6pWvr0AhrTJpNm44mo
 RvG1SJULqSVmBNEfjKchtXrP6HPb3L15FapYrLX3VfX1JCX/L0O4bI2sQerugbhDUck/3h9t
 rsdm3KB+pXHChYTWpPtQw428RZ9vbTTfig64cvdy3RtNaC+tjKK1cguAaMpzROpftEXN63hd
 ke6NsQABNW1bsEulUKoaB0sI+1YsqI5foune/aAxK+3LbN4hjv1xW9D4Y17zgeN738mE7SOh
 cxahajHmFLdBFKexB+7v8v6mJ5Jf2QXF2u7km3/AZJJI7Z1ZcANAHuvJMu+wpN/gYTsUjhW7
 g3GZRtO1cm3dB6Vd1G40xdX0BFdhHW9mjajiRFwnSsoqKW3wyHEhejvPkliWCYDVCx5gFHgL
 JLhxfUTRku1dE4EkBW/5ED177dWruJzIiOAJCUANzizJGZkXKyqs7OEaMMa85IkvxJcV+Gka
 EybQLrwy/cD+xvqBHAWhDUydjXx/478gwQ/k2WFanB6sHvef8h0gxbZ/t3VA/BLjHIKQyxxi
 D+fAVbZXZHh2NyOlIrY9M26WXigUJJ7biThi4+N/Ce2/mxlBxSjkuv7wIS9V1JgjmmiiJ8zD
 23Bt17kb5Pu1rimPO4CHAEgH1L658dgW8l/noY2mJAMyC0fj5SR82AAlDS7OtFa1KTiKXsVE
 GRSmZiPulejgRIldyjaouCxHm+QycZgedSgN2Yf2yZmqttPFL/R97tc2y18vlu/qwvVJ/l7h
 DYUj/U0uxt4y6kEvhQgyiKFD/UcB05daGbJng6L8sv4gaFZfmepfpCv2UA4kd3rX9Tg6klMH
 W30fJsvB3o6y8xlM0/XllD35Jvlftb4ct8Z8BGZ2USl7aAdONc6kfwEgjBiMGT2sCg+yuI1u
 hdp2ImzoImNL2g+tLL8GBNTMSf5It8C4jy4x7gLhd6Yhsr8e/cpUiVORpbjSuikVS4fpeiyf
 RjbCyUy8z+SS7/YABPZ90ps6X7CW5n5MnaKODwJw9J4WxCHKApAjQpSUDhf/NZxH1Kvw9H9N
 U1++zYa6xjnpxEKxu8gPkv6VXrD4QyzYCowS97GJRxat0dJ4EKwU4TW57B2GDxEu5a6pwuXM
 irCbgJEVCcCXUnMEVnnOvPGCcDo1e+eC6L+KvLPZe7LsulCT7KTworp1IJ6/jGKP8HJP394D
 vR91FARFXZ+U9/UnTkCUUl132rEctKbqRGg+yZ2stH38fLlXxjq7JeODL0aOMtm+hS/i6OOf
 +CKgyMxJTFd35IKjXjGrdpXlEYVkD1rfiKxHK4osCnQUOTPl6URAxNaIyJ/Oc1U7r4tiwlAP
 cmI77G9nrV8j/MzFxJETQm7w5vvP5ZVZTjicgqdVyPpfPycKDbGwt/6e/a5QLxU16BPsgGo/
 C2cCwnlNyiCkD/gU1auN/tNhWeVJk872sn1fxBzBGzkVN+jZAe8NYo9qDQswqAvwF7OO3QdN
 zdUbE5H6LGdp3A94L03Cyla43xpIPPR0T6e9PXdI40KvOFDByNpi6RF7X58x7Yfv0QmDLRl3
 SDVqNBpuVSvlOKCnyFmXBR5oTFOnIuXvE9mNM0xGbFfVHyC8B9ftA147jwVqtEjBtC948i4K
 /DKk7/vbihP+ZTY8JlEb/U=
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:gTF7Margf0i+/f4bERF3ajIaV5oyeYIsimQD101hICG9Ffbo9P
 xG/c566faaslwssR0b9exoW5PgfZq/z/VICOAqVN+ftW/d11dAR7sO0WKN+VPdJxE=
X-Talos-CUID: 9a23:d2LXzW9h+TO44/0LG/2Vv286NvAZd0fh93rzc3WoCkhYc5HER0DFrQ==
X-Talos-MUID: 9a23:TIK2iwphoH+kOPUWUeQez3JDasE4/47wM1gmvLcamPSlMR5ONQ7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,303,1739833200"; 
   d="scan'208";a="117172192"
X-MGA-submission: =?us-ascii?q?MDE4io1hxucxzjcwT5W/YwfyEnk+Sa4Fa1OpnC?=
 =?us-ascii?q?Ry3sTFC4Vm0XQrtNEhjFHsSedTZJpEKx/XiDrsGVIop6e3DN05jqA9Xx?=
 =?us-ascii?q?aaPLUOs+us7iM7sNMMevusftAZaob/mR4G5N9GyCfv4DR0sQ5d40Ds+O?=
 =?us-ascii?q?3BLLF4zc+IqevN0018C2ilkg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:24:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747830287; x=1748435087; i=markus.elfring@web.de;
	bh=6HZ8JQhY3iu1D+1yZuMNuG+MsPWjHOM0Woufswl65ek=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CfYExPv//lwpC9Epw5hyyAKisIhFPGPd4PIarWlDJiMc1xU1dwFEW1feO5iG0eHJ
	 NBztKjmbvV7bzYkWJzzeVUj9O3oE4f8w0/nzGg9Xanhzrxl1yuqHBXWT6gLFgdyVL
	 InXmuAgYII7oOVo3mdFd9uPjhmX54WEuD3VxZpfhi7ilh9FDlnyDawT+Eg7HbhdF4
	 Mru8sO7GaaZh2nA+ckez3R6f+lZCOQRmGx8LeJn3CCmBKbLz5ny6RWPxEx+uUj3h9
	 5wTB+Ii4nCc2zwqCjfUlIRUWjTRhI9yTsPCGGJJGNCwVRXpgaclIBTyBLEWP4OgLf
	 BxOwqCpEsykqregZGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1v9hfF2t0J-00yhFZ; Wed, 21
 May 2025 14:24:46 +0200
Message-ID: <059a9742-f033-47fe-b80c-9ffb76383f88@web.de>
Date: Wed, 21 May 2025 14:24:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>
Cc: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <55052f14-dbe4-467c-a7a4-41ce5fc1cc99@web.de>
 <6007e0f7-3d15-4490-a000-b10797c9d579@inria.fr>
 <fdc8e894-1d4c-4d55-bb5d-12cd0fbceac1@web.de>
 <e552401f-1dfc-4273-9fc1-cecb2c1ba635@web.de>
 <20250521141433.7dcf9ab6.olaf@aepfle.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250521141433.7dcf9ab6.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ngX9x/XZ/A8VAGNJ8XwTR+HwTkJcXC3hACx8jTGzFcxyx3oRUBV
 NMu7wUv1af0kKVkzWZEyQ+PrRLqOf7GZm2K2oLNw0WLHGjFXKkQ6bP0lu+2gsFvns99sBZZ
 XvcymHR6tuxxgC5Jv4fG5A/mePOId2sEHzZMxtd6vXtuBLhmYuIfeNOXd4M7ZWmd4H4FaPy
 cWLGQibJFbNkh4VTyWazQ==
UI-OutboundReport: notjunk:1;M01:P0:kRd3zY0AWT8=;9ks2wdmh9dGa2IH5SpugDd7BeFu
 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
Subject: Re: [cocci] Reconsider software dependencies for PCRE support (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2746
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/059a9742-f033-47fe-b80c-9ffb76383f88%40web.de>

>> Error: /usr/lib64/ocaml/pcre2/pcre2.cmi
>>        is not a compiled interface for this version of OCaml.
>> It seems to be for an older version of OCaml.
>=20
> Run either 'zypper dup' first,

I tend to execute such a command regularly.


> or make sure OCaml from /usr is used.
I usually expect that OCaml components should be picked up from my OPAM sy=
stem configuration.

Regards,
Markus
