Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC3FC0218A
	for <cocci@archiver.kernel.org>; Thu, 30 Jan 2025 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+t4JrvrPiLsj7bfb840h38pFA44a5hm5mtWmRSYdCpU=;
  b=afiEpnTQN7cI+iHLtAerhu1IVryx+JZZv0OcWFP546Y+NTkm/L4VXumz
   68yC+UZTAZ43bMeS5gJRyZabD1uEbsIXmtltRbPfuKik1DlVxQBrWDtbR
   s1Y67KJXIIPGRl1Q5U32iY8Lb8RyFKfIGOZ9UboJfzYwDygloOH2cq+Vg
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205748597"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2025 12:02:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BB777E0D1D; Thu, 30 Jan 2025 12:02:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8AF9CE0260
	for <cocci@sympa.inria.fr>; Thu, 30 Jan 2025 12:02:31 +0100 (CET)
IronPort-SDR: 679b5c47_MMeoInFnurDSLGYf4mND0hIpS2qllnhXWu3avZEMVts+WVl
 DrI7KXQR4W0n6QiqULkEMrl4NjpMdEcWzlSraqw==
X-IPAS-Result: =?us-ascii?q?A0E5AQBMW5tngAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQwgRODKIc7h1WIdoFWgX4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEhQACinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBxQBAYJ+gjABAw4jB7hHgTKBAYIMAQEG2lsfLCJXg?=
 =?us-ascii?q?WUJgRouAYVqgmMBhWs7CYJQaXonD4FVRIEVJ4JLOD6FEIMOgmmCM4RMZ5dDi?=
 =?us-ascii?q?hRSexwDWSwBVRMXCwcFgSlIAyo2MSOBJgU1Cjc6gg1pSTcCDQI1gh4kWIIra?=
 =?us-ascii?q?wQFgS2CPYRFYC8DAwMDgzaFXYIUgWUDAxYQAYMneByCVB1AAgELbT03CQsbB?=
 =?us-ascii?q?j2eP4dxllUBjhKhOjQHgjiBZoFjDJ9cBhMvl0QOBpJ7LodkkGoio26FHYFnO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiGELchfQjU8AgcLAQEDCYVGAQGKO4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:nuiXXK8G+Cnd6Z1jJLL/DrUDa3qTJUtcMsCJ2f8bNWPcYEJGY0x3x
 2tLWGzXbKqDZWH8LYx3Oduw90IP65DUnNJqTwtv+SpEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWcvWo4ow/jb8k435a+q4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE+M9fI0Y2MZ8iyPtWD2wXy
 d5fEGxccUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTupkBhl/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUC8A/K+fpqszi7IApZ4YjEC/OOZ/WxS+prhEK8u
 2Dl5WPWDURPXDCY4WHZoir31rCncTnAcJwdHbiy9/NwqE+Sw2YJAVsXU0G6qL+3kCaWX9tAI
 kgQ0jgvqKIo/QqqSMP8Vlu2uhastRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNkhqdNwWjEgk
 FOE9z/0OdBxmIaveF2a9ruGlwGvGCYYdFMgIhdYHBRQtrEPv7oPph7IS99iFou8gdv0BSz8z
 li2QM4W2O97YSkjiPzTwLzXvw9AsKQlWSYZy23qso+N6wRkeMi6aobu5VWzARd8wGSxHgbpU
 Jsswpb2AAUy4XelynDlrAIlQuvB2hp9GGeA6WOD5rF4n9hXx1atfJpL/BZ1L1pzP8APdFfBO
 RCI6VoOucIOZCP2Msebhr5d7ex1ncAM8vy6BpjpgiZmOckuKmdrAQk1PhDLjzyFfLYEyPpiZ
 M3znTmQ4YYyUvg3lGHmGI/xIJcqwSY53ivISPjGI+ePgdKjiIquYe5dajOmN7hnhIvd+Vm92
 4gFa6OilU8BOMWgOXO/2dBIcjg3wY0TX8CeRzp/LL7belIO9aBII6O5/I7NjKQ+xv0OxryQo
 S7gMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AR9bQz66Gtpeou18qYUer0+eLRtpqQpzud5Q
 7NBM4+MC+hGAGaPsTkMT4jPnKo7fjSShCWKI3WEZho7dMVeXADnwILvUTbu0ygsNRCJk/UCj
 Yeu7D6GfqpbdT9eVJ7XTNmN02KOuWMsnbMufknQffhWVkbe0KlrDC3T1c0IAtw+BijC4hC41
 A+mJwgSiseQgo0y8fjP3bulqaXwGcRAP0NqJUvpxpfoCjvrpU+Y3p1lfNuTWDLgCFPP56SpY
 NtKw8HGMPEomEhAt6x+Ge1JyZ0SysTOpbgA6ChZB1TOMkqWD41/Lkm83cVgsrNHwplbs1CUX
 mON4txrBqWbCvj6EVI+JBsXUcrb7Ks6wgLt1PUSJFn2wARV/7DdCEVbAESquRxndbBwNNso/
 PcltMso8DeAsxsNMOudryVq5m+Jf20hUaImi8kgO7XVqDEXk3NMXZ+NLRXNwsCrS85NOUwUM
 DOrlPL8p7BD9HHjLVs3N1bwhNR4u7pfmSp33GcjJkuIkOXrnvUY/gNc2hVpQxV3zido6fNSO
 G9qPXIkfKmlomxau+lebU+RGiVqJh6QymruwXQnyUzbSEiJUDTWDWsfYOyiwmEQw1h+TBN6o
 o6K7XnDUCmwWtPcxQ4gcBdBh926avIp7SzEusSsP/rdLqkAeTC/35OfPzsZmSXoEeYapRPhp
 9Az2M1SdKeiFyobg5NjOrmgzb5KFSy1fj1Tc8pAopEMM3rXIgyp+D60LEu0RMNBCtrK/WK8C
 O1sPsh/bAu/5gnfsgEkAbMwHJEskM4L/NYifpbZFVwCuZabrRtrt8v03Qr6j2kJXd5vsJgcL
 qX8SjG8KVGT1EBkwzL1kMp5O2SDcYYlYi/417uL6+knLc8In9xtVkAQ6YGKmUupHjFpxD+uh
 zObVZTql7Rj7a9Og7rTFr5yAlToCNHrC8WN3gOBk/VPStLtavXxlh4nhWTmGy90PrIhfct9u
 prQkdzw3WLD5K0XVUKAkba/NqB53+eAd8sJDdDGd1xhgjmndPL3xhk+p1CDNp1Cle1C6vmdR
 weXbNW6cfgXUYx/wEJ5Rjd/ERFHLYjKdYbl+D2AqsqTBign0QDoKM2t8VnrZzp5cg4KI5jPN
 R/mic2x59x3rJV+OzFcPqtIW6RHGV7EXbcqU/bTtjPCV2mhvQ6ki4vYzBEl7WnGN2mAHMPE+
 qn6fxnZdimpmaT23dpc4p1TvBoWMS5HutMOXHkhovx4tzPrK1Q9D7UtAc1TQNUc2Cn/z4rxa
 zzxfXMvQ3e1FyhNdRLnps/vREGDD+gJIc30PSEt41jSUSqtGYecG/F0w0+MOZutlufLl4lL6
 O3y+0Ec+jC0xYx1A/ke7Lq3jI+LAx8cKm0goSjAfw7aWn7ywonmEFR+EQALWSGv/wTlihDQP
 WZsLYxbaBjTdKMyePqMv1ZKFRtfsD6HI/DEq8uQ6I63hrh3B9GsBBEy1y8fH1HDgAk3yGYye
 E7K
IronPort-HdrOrdr: A9a23:daD9nq9UN+hQeXP5R/Juk+AMI+orL9Y04lQ7vn2ZhyYlEfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIK6PoSjjPZL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AljApXGlfqj8uKq7ecxpVlDO/OEfXOUbn/VjXI0O?=
 =?us-ascii?q?qM1R0abOYEGOyv5s4wtU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ATrytOQ+Mk7wfZQZGIZf3g3SQf/ZYyp+HU10kqps?=
 =?us-ascii?q?phdOAETFyGC2aozviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,245,1732575600"; 
   d="scan'208";a="205748588"
X-MGA-submission: =?us-ascii?q?MDHxrHSjWo8ljk2ObkaWWE7QjLxhBC7x028d9W?=
 =?us-ascii?q?Zve+aQ4cH0XLC02XXV8dHjdjLlDrBoU9MwoKp+wtsKsprKtOEonT6YFZ?=
 =?us-ascii?q?QkGGGJMSPtNrvHpH5qyZ0ApRbbX6nPM1wX2d8UxAxWNAO7zQUdjwE6zU?=
 =?us-ascii?q?jQZRr4gZ0Bwz192qOuOonNvA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 12:02:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738234870; x=1738839670; i=markus.elfring@web.de;
	bh=+t4JrvrPiLsj7bfb840h38pFA44a5hm5mtWmRSYdCpU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EbrlbQSAj+f38PA8703tTZaMiR4ayuD9Qrvyd9QGYqJH7YthbOq//pBZda9lk8L/
	 8Z/bzqm9AcXAMhwbS7RdUkARLZ8bEvd0EdUhD+FRE9AbkWXJxoHLcoT2yUZDnoAru
	 AEpVtrhhTX6gwbMUeKZ3owYdgRazmCSF+8S1sKEY3QoZ9646CKqHg5lS86sDrdRD4
	 GAbkiHBdMvF1FSVgBio0MksJCA2Iu2Q6DHWn+Yg3/3vqeK/pNqvYcFMKTRC3o8uWh
	 KgSWCXjJhP+JBxslKqGd0a2lz6i0DAbUIk83mJ6VEQvNIYUmrFpRTTuGrXGp53KWW
	 cqA7/eN/08snJD7Q9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIya8-1tsDzY10Di-00Lbns; Thu, 30
 Jan 2025 12:01:10 +0100
Message-ID: <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
Date: Thu, 30 Jan 2025 12:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ibm-acpi-devel@lists.sourceforge.net, imx@lists.linux.dev,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MEBO0GsSQ1SMY/zsPX1U6svBkJN6BjoZlGAGaEjdoAIc7rC0MTJ
 jMCDSnzW+JUiBx0jWaw4axa0ASi7RKu+znCfMa+5DA/GZz89brkDkAWXkPNY1Ii+WKoCg2M
 6p6JIXEbQugmQdBp3V5wVA0hm/aJde6kKUDnCeJpidqtVh0kGmNtl+sNaqnuL+ZhzFG6g5Z
 yt9wjcSDL8KRKPEOFFBUw==
UI-OutboundReport: notjunk:1;M01:P0:PCsLlrQ8lfw=;SoOTgoPi1u3ddphFfFnJ4K80Ey1
 LhQV5NN3S1upZ+kQWRf5X13xSqfZszqJAWQG1OpVuCmo6tpVtGTWgh7ad8U9WwKa6cxbghVrt
 NekQpjR/Dsev5s67AnEX8ThdDcbbfKvRw5T8fgaGslTYv3XceDxH2g+ZINh1g5Zl1a5Kb7tUy
 iHsXRJsmGMh72moAwMl2T0JX0Ldu9mm36L7zjNeIOX0Xh1EcbDwPTnBvWT5Jmf/TZjjTD915z
 wkMwvyKEhqv+ILIT2NmQNRENiOP1N2A5cNBwL7S6RvzS4B2b6TETCM6HSXEgzk4eBq/cjFYJ7
 Ta/beBAeX/x1vlhieJ7zCgVJ/DjpXSnLIakxsKLFsTqznw+ifPF4fJli2HnMVo9sGRnRMWTrl
 qkRACaZwBVl2ReKWA6Ylw6VqlTKMT2hF2oCiSA6SNHSwnqWCdtkKT3MwrASEpsgRd1t3m2qrg
 dzBxkwY3Iqvyla51ZhZ4KeRRsMYftkVOD06V/LWAUsGh3adVyfNfo1rFkiXbs8oaQXw9Ja6tZ
 RzPDki+nrGeKxCzQaenUyiA48SLrGJ61YEiLCyUiil3FCYQCPBx6oGNf2hTXlPwkPSrMnvfyk
 yvQjlFy7DS+9l6YMcPoT4oJhRV5HGFbKwznZ3oL4+T60BN/ekmSzbtefb+GOhIG+4+ywk54uP
 mTXT8J21gH5qaPIaPiannqZ/nmjWeakTcPkk/rVwdP3tmwDxSgnRKkzPj2UadACH+VKlM8JrQ
 lfxiv25g7Br2uvZqXG/3Mkq5j8BPnzef0ZEvV00FZ4lN2l35qROKiS4KNw+Oa2MExwmkZF8N0
 Me4UosI1FbMOonU2tpnvT5R9FbJv2h1tIMF/XYUdA7G6V3mY01f2O3g0W60Gd1Z/onfWiWTsC
 vsuTuJ7TZfE6AwrUs1WQ/Wi8E1So2MZdkmeUagRZY0DoLytG1bmL84SvJIdb8h4sdAVK3EONn
 3chVYtWWI+cM+cz3Whj1giWzBTzyQOpKjx+HZcaRA80KQWJ5iUExiJkz11n/ptAWXabZtwVr1
 IIfHoUKeT2WT8pACVlj4x3gvqIClbPKbcGWhs4epE3uD2mR9gqFM8fCUfkHNngYTCZq6z5Did
 d50IILddgQEvH7rjWs9K2n3wFTct4+ajCi45dnopg2wTz/Oma2Lt3tO8Qenl6l70EogpyLyCN
 iMoxPpi5Wclpw/Kc+5YCXrWUIzzUatEenh+mkeiB0/g==
Subject: Re: [cocci] [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2317
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb%40web.de>

> Teach the script to suggest conversions for timeout patterns where the
> arguments to msecs_to_jiffies() are expressions as well.

Does anything hinder to benefit any more from a source code analysis approach
(like the following by the extended means of the semantic patch language)?


// SPDX-License-Identifier: GPL-2.0
/// Simplify statements by using a known wrapper macro.
/// Replace selected msecs_to_jiffies() calls by secs_to_jiffies().
//
// Keywords: wrapper macro conversion secs seconds jiffies
// Confidence: High
// Options: --no-includes --include-headers

virtual context, patch, report, org

@depends on context@
expression e;
@@
*msecs_to_jiffies
 (
(e * 1000
|e * MSEC_PER_SEC
)
 )

@depends on patch@
expression e;
@@
-msecs_to_jiffies
+secs_to_jiffies
 (
(
-e * 1000
|
-e * MSEC_PER_SEC
)
+e
 )

@x depends on org || report@
expression e;
position p;
@@
 msecs_to_jiffies@p
 (
(e * 1000
|e * MSEC_PER_SEC
)
 )

@script:python depends on org@
p << x.p;
@@
coccilib.org.print_todo(p[0], "WARNING: opportunity for secs_to_jiffies()")

@script:python depends on report@
p << x.p;
@@
coccilib.report.print_report(p[0], "WARNING: opportunity for secs_to_jiffies()")


Regards,
Markus
