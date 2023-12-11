Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB49C4167B
	for <cocci@archiver.kernel.org>; Mon, 11 Dec 2023 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9qziLOXKnORq9SgIPGClXLdoEhSw5zZodLChxGx4O/M=;
  b=CWE2c5M8jnaM6vBG6Iwv6W7+U/vcivpxLSZ0ydA7KZ4NBFZd9dJykpxS
   B3DBhkmSpywcvUBTq9NXJJez02QXtX6Y7i9iH0AnGmROXufaEXqM2U6Gc
   78Ib7ivmv5aAotP7k9VLwlhAUBPDWGIBtrfzUnsOuGpVoXIMjWmbTyABv
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.04,267,1695679200"; 
   d="scan'208";a="141496169"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2023 09:37:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87290E0AF1; Mon, 11 Dec 2023 09:37:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 05826E00B7;
	Mon, 11 Dec 2023 09:37:33 +0100 (CET)
IronPort-SDR: 6576ca4d_mSsIFgHKBaFXm6vhxpjdM2sKpay0Lh9j3fTZO3xU1pyT/ER
 iQezu3gpZGVNosirG0SQGXBrj3WFh/MNkopYKxg==
X-IPAS-Result: =?us-ascii?q?A0E1BAApyXZl/wsR49RagQmBT4I5B3QDVDAEC0iBTwKDA?=
 =?us-ascii?q?oNPi3KBdYEZg1KBVY0piG+BVoFAPg8BAwENOQgBAgQBAQMBAgENgX6KIwIeB?=
 =?us-ascii?q?wEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAUBAoEGE4VoDYJcA?=
 =?us-ascii?q?RAiaoEdAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAg06ax0BAREbDDQCJgJfARQBAYJ8AYIpAQMxBw2uQoEygQGCCQEBBoEHP?=
 =?us-ascii?q?gIMAgUPL60+HywiVoFgAwaBGi6HeBoBBWOEfIRiD4FVRIE8glKDOYVUgmiDZ?=
 =?us-ascii?q?oU4B4YkgSuPOn4FQXAbAwcDfw8rBwQwIgYJFC0jBlEEKCEJExJAgh+BEwp/P?=
 =?us-ascii?q?w8OEYI+XjYZSIJaFQw1BDURdRAqBBQXgRJuGxIeNxESFw0DCHQdAjI8AwUDB?=
 =?us-ascii?q?DMKEg0LIQVWA0IGSQsDAhoFAwMEgTMFDR4CECwnAwMSSQIQFAM7AwMGAwsxA?=
 =?us-ascii?q?zBVRAxPA24fNgk8CwQMHQIbHg0nIwIsQgMRBRICFgMkFgQ2EQkLKAMvBjgCE?=
 =?us-ascii?q?wwGBgleJgcPCQQnAwgEAxAbKwMkLAMZKx1AAgELbT01BgMLGwY+AqF4LIEKA?=
 =?us-ascii?q?YFogS5XAoI9kxqxWDQHgjOBXwWBWwyIc4EjlQ8GEy+DbpM1DgaSUJhCII1Il?=
 =?us-ascii?q?SiFSIFqBDKBWTMaJE+CMwEBMhI9AxkPkhgzgQuDVopmQDUCATgCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 UE2bV/5
IronPort-Data: A9a23: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
 Imw
IronPort-HdrOrdr: A9a23:Wpgg260cnRtHWrHAoeCB+wqjBJokLtp133Aq2lEZdPU1SL37qy
 nKpp8mPHDP5Ar5J0tQ4exoVJPvfZr3z+8N3WBpB8bFYOC+ghrOEGgA1/qA/9SDIUDDH4dmvM
 9dms5FaeEYZWIRsS+Q2maF+rgboOWvweSFrt229QYIceicUdAE0ztE
X-Talos-CUID: 9a23:/G03M2zE1F9YmBINhbxQBgVOWdk0V1jc4EvJCEq7EV9bZZqxaxiprfY=
X-Talos-MUID: 9a23:SehzLwprb/FrQgSJ3xEez2lPapxp3p2gMWxTlJZWlPmIFSVAJg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,267,1695679200"; 
   d="scan'208";a="141496140"
X-MGA-submission: =?us-ascii?q?MDEJKImD5bmep4JeHpDqGADBriIZzde6RWDuMz?=
 =?us-ascii?q?mfhewXTvijVbLE57mdGZM6/pDZcu1CFY7ol5aw6j8AxwY2NM4KkKoD27?=
 =?us-ascii?q?Q7KqofKrDV220efPxm6YZkAWvapHoOi0sQkNbSp8ZgL/G1Yu5Prxa8vO?=
 =?us-ascii?q?tYlhikXc3qoGxWFr6F56eVeA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 09:37:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702283843; x=1702888643; i=markus.elfring@web.de;
	bh=9qziLOXKnORq9SgIPGClXLdoEhSw5zZodLChxGx4O/M=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=XiAabm3E2weq1yh+BtP628KP+pa+4QGczeEjvFhcc6ss8+H+JSjFdFFjbqf4T4yZ
	 iGxvaGeWrX5RxMtO4VV1+EMAPtHUjBm+nTLEdDiC/0rHQIRWAsWukR1mGr6cYm9e4
	 knMLss6U6hLYe/5giueK8PRp77NXW18v8TzAB2GzJtEYP0IQGYu1Nj0c8UCzB4rBc
	 YtbFQWWbpYsmHgE5LtAqVvZXXn08sKYyYCzHX3HSeyHlfRoUTvlf6HtMOSWsbaPR4
	 ol3IiD0meLZW/fR7KuMQdx+Ock5uB6VNcEJkbNmrFyJ6DzmhgxVQ0TEIEExMIvvdS
	 DLqrmpuWr0boqmOQfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYtx4-1qhnF50G4u-00Uy41; Mon, 11
 Dec 2023 09:37:23 +0100
Message-ID: <dbcff3ca-a7ac-4bd8-92cb-02a8821e2257@web.de>
Date: Mon, 11 Dec 2023 09:36:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, cfr@inria.fr, rust-for-linux@vger.kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmbrS5IKem/dNiYvhnV07FYz0LMczschdHYk+JIoA3adVRBmfPm
 mwMIWuXgH/j+AzedE3+w5D6cJ69tIL4dyxXgpiWZ3CO5AIWa9+BDuJF6ubEji9vDXpfxO5Q
 Qbb7S/j4xRUHEhtQGw0gIw9YcpAIZgjxqTSAf6jMFaEQWLuiHY+yeC4UN7cflyrTrLAjah7
 etqEIVAton/zFIJe5vbrg==
UI-OutboundReport: notjunk:1;M01:P0:aji7ZJ0iR5A=;HeoE4s6diATuwHXtd2kcOIekMHj
 O8JhdX0Qr+MFmULsw2Oav4C1Bpe1P9Rt8d5bn9aG+zlGvFY9z1xmGcfDx8rxUDWV7J8UYDTRu
 LiqrvPMUEDBik7ojYg1ODYtNhFuRKafqktuXykH/rjP2/oOmduzF336eJB3zH8q/BAdR8k1q1
 K1yobOPhyBGi+sx0eD5D+9IkrUusJVo4FttL3uIy/jaqLUZeiyJ/n7fetAh8yPxRU+AvDltOZ
 R0I7YBDaqwucVLDsiBvcJrvbYMcHj7vP4vkwCdNDz8+iHaPM+nM0n9BKGjymY/1C984UPX19D
 ARkrQhXeBnihk8f56fC7OE2+o2fkmTnaavF4Y4OIK/mSoo7ye5FjbTxLseTjKZJ+c8w4GpE2j
 Q7ZpsA3YI8WweCZiwuvjhHdJiKnPEdO/FkB2pOIG4FKuHix1zxWZvDRl3DUCChrYa4Awe0uua
 G8NK4ValeMsdq/hrR5qvVoJZjObaEp38whszuUPWqnr5PeKbH37P15GlwnFjQvhRDabNA/5/p
 Decb17z5BLhmSEgW8svbFGfMCoEqV3zUNytfQnqAARx26E96ConYti9IftD6ziJyu4A9GOVr2
 D2WE5jUziFwb4va1seVqoQXcTnZMpy6CZQ8P6bAdNWE/B/HP3G6GvYN+8x764w0zVvjZot7a2
 r0SxXOWY1Dl+LZR8rUosZG63zxICgR3SONNN2BeLFoBenrMN+bJfSHWoPKuaZDgcs3r03ksr4
 w8R69sS0BYeVckix+0mlt8aL+Un7PKRbV7i50gaEi4bqFK4CmqCJU2EP+vHQ5fBmLXbzAqqL8
 Tc443+7KmUDrdY8G+9nE9pfqRltt+bB5fvAViCKdISz96jIJvsEuwI7LhMuT/IpLa5lezudRY
 YhvgG3xnj9WIEcg+RLVtHDJ0UxnsSp+BOBGHRctVrdWHVxRmvDYu5nwJ0jM5QyBmQU+2hoK18
 9rEeqg==
Subject: [cocci] Extending support for mailing list archives?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1346
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/dbcff3ca-a7ac-4bd8-92cb-02a8821e2257%40web.de>

Hello,

Discussions will evolve also for the development and application of variou=
s
software components according to the programming language =E2=80=9CRust=E2=
=80=9D.
https://rust-for-linux.com/coccinelle-for-rust
https://lore.kernel.org/rust-for-linux/

How do you think about to support another mailing list archive
on the platform =E2=80=9Chttps://korg.docs.kernel.org/lore.html=E2=80=9D?
Or:
Would you like to forward any messages between existing mailing lists?

https://lore.kernel.org/cocci/
https://sympa.inria.fr/sympa/info/cocci

https://sympa.inria.fr/sympa/arc/cfr/2023-12/

Regards,
Markus
