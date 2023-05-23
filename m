Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29564C7EE30
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4XGbCXrtb1/W9uhWGLpnD4dK5SJXSA0rbFsuXNIop+Y=;
  b=eM5/XZXJCS13Cf/+vmWln3sltfREqJyJmGQyFCpmQzjfva2EZstyh96e
   wrqbMma1KtUMDluM2gaASapY8V9VWk0h/RXJvrXPKcz6+wGcWTGKtcHZm
   P20qJ86ouZLUHyJsvFV9kEn4laQYhXTAKdv7+Ns6Q2ZKGUKk/GPH22dcE
   k=;
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
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304175"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 19:35:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 208A0E033B; Tue, 23 May 2023 19:35:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 58723E00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 19:34:58 +0200 (CEST)
IronPort-SDR: 646cf941_atp5a+KSasw/rCC2G9GE53+xhoBcwk1+9xvhV5thVFOAF/D
 hr1UZsPscH0+B+oXlv7IUrGjRWht/VsJ/5WY9FA==
X-IPAS-Result: =?us-ascii?q?A0EtAAAr+GxkgAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtGhFKIHYZ2gieEM4cwh0SIaoFWFIEsPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChVsCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEkFwcODimFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPwMDIx0BAREmAQ8fAQUCERUCAlcGAQwGAgEBgnqCKAEDMQetPYEyg?=
 =?us-ascii?q?QGCCAEBBpwNHywiVYFeCYEVLQGNLIM3eicPgVVEgTyDQoN9gQaDHIJnjy2NB?=
 =?us-ascii?q?YEwcoEjgSiBAgIJAhFngQ4IZoFzQAINZAsLbIE7WkOBaQICEUIMFQVYAoEEE?=
 =?us-ascii?q?AETAwcEAoEOEDEHBDcLIQYJHTUtBl0HLyQJExVTB4QrAwoKEyUEDgMZKx1AA?=
 =?us-ascii?q?gELOzo9NQYDCx8GJh8CggMEgQl7BgEkJKAiexOCdpJugxKtcjUHgi6BWoFdD?=
 =?us-ascii?q?J8WBhMvg2wTkxIOBpIqmAkggi+lYYFjOoFcMxokgzZPAxkPjiCEJo8JAT4/N?=
 =?us-ascii?q?DsCBwsBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:3U3NUqs3o8hN8nIaLwXR+IMB7skDotV00zEX/kB9WHVpmwKj5q
 OTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BkWyF+rgboOWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:kocnEmEDw4EEa3K9qmJd2l4ZK54Eb0Tv9y7VMha/K3drVr68HAo=
X-Talos-MUID: 9a23:+9J5egsWa12tLTcq0M2n1DJoGMlXwqCSKRoOvJAUtuyYEDJbJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="56789886"
X-MGA-submission: =?us-ascii?q?MDEG0ENb3dVBSWoKXwNKaO124Ls94tpns+knlu?=
 =?us-ascii?q?p5nHPY/lwK7ebqJ4XsM8moqkkVRSEUnp8fQrfi76YN7J+MSZqqj4rz2v?=
 =?us-ascii?q?vTHNKrn/rZb9bHXpzbYFo4mw1ucSqPwKQ99rcfx1sDY3NNtXR1mSehGc?=
 =?us-ascii?q?f/Aojwn5C4TepApblUk6bK9g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684863289; i=markus.elfring@web.de;
	bh=wJpJJu08NC9W/k/YAUF8KLFobfpz5YG6WTqizHg1J5k=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
	b=otDHEHHapj7uwwJg+dVI6/hJz+BuuTPOmGd0qB0Un0FKVIQW39UmntkQ/bJuTytmn
	 4s8hPsF4iVDQYmr5n87IPbj5cCbamKs4FAB/pwsAx/ZozjU2kE0YTyRJwHNFXpdpRF
	 srO1ktfJCcHEsUjOFmmwQ7Kzv4jIMNghof53PT37WJ7WAI1LiWKD1s6+38iOdgErPm
	 7uZTQsc3FCOQD6/vui9Rbj7bAZMYBJZCiucj/J+NoNCxiGJLVHgkjKP+w5hnMazt0C
	 IF1+pXUvvKF1IoQOw/oS5rKedLAv0cmxWx80PzfUIRjSjOLUFVZP2mHLJcgjCJQJbi
	 vS+ZijaSxZgxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS17v-1pZd7C0XzX-00TVIV; Tue, 23
 May 2023 19:34:49 +0200
Message-ID: <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
Date: Tue, 23 May 2023 19:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yfbik6BQpZ+MONAWALyDRbDEMSz810xElohRN9hj6/dJvWKt0ek
 myy0bwDc2Br9jy9e+jhvtZh+dCx8ZLtlWK+Po0sAZwqopg7oSXxjGG1ppRmSkfnae4MIRfq
 NX9VIwjZxuS02MPks3//BvrHIJ4veC8Hllm+gUmTozkI4ULYW9Pi5vzPDybfEjME6+4hp9U
 foFYhfPZCafuP1+JVxhUw==
UI-OutboundReport: notjunk:1;M01:P0:DBa4qva029E=;BWu4v7/2mzJkPrsye4yzrar5f2J
 b7ZVEd7+zBkliYkYQCCu7fyi6O8zlfkqP1Qpag3bJ9AhrwJIQoWuE1oxNDr/PmB0TYg3EYI0g
 xZJ3JJbpM8vorGqRehgARul4Nj0900oVc5VSUS+ZdIlPCf1RwBS7MeP9AjKNfTkaDwTLGZ/MG
 ybsLWVMZ6IiVagxnDk0yF/si+yXdXZQxyym7H1+AZzaV79NzXP+ArHsmTNbxI8xeFcjQYoKOa
 PlfeDq7yW0P8sxxU4CU7UNWKmXBfPRoZqRopfqWbcf3FvG7r3tU/KehGR2mqbDEVRXwQhoDJd
 Nq8wuDv7HWMvsd7Zzlttq1mW2QyV6PDqgNQdM+/2R+kmtCJ9Bcr/iIpT/h3qKpJl2R4W6ORo5
 96bmcFeImWifdY3GKYdP9hLBAs0iJL84zg43pDjw74X3qEvRbjwL2l7+80YwqAZQuJXicIED4
 XoP4MQYX+uU7ogDIjKmN5DfdY2tv5SP1zGptXYTSofopqchH3YolhfQavoRKPBFQIhyeJLHHt
 /HktOx63U5RAho04kiOasHd7MGsPgFUc7LHc+anqTuhaYwSdYLCifWPMgKCoe8IWFM2udPOo7
 3E0u0L/D9zEbHO+a34oABQfThL6CmZ5HHeQX+pr0GWiT7nQgqHjZGkOeSHbHlbkbUD2hEr3T6
 LITLOnIVvoW7faInlWMLu3QeNgD39IjJnKoRb1xLQ9f6ECeEpvpR0CsnI+C6JCnzwmWefzL56
 SBjwn0vdbn2XDsN4xATPZcK5koorfE7GsNkP1fre7F4lm2poSQUKJi8LtBYg0cu8aT6IOsJcH
 tmtVBlwTMns2fP6UouF+L2eX8uIZhw4FUfh+mqZ1BvPuxlUreYyQeY38YQ0JksJsEoyJrxA5u
 IVGE6yV/vYxY0u65GY4gorWUS9PSmiCeg86SABFiZUaCbelC9pdLWcH9cBJo2slDvHL8wv10t
 V3IzWg==
Subject: [cocci] [PATCH 0/4] fbdev: imsttfb: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1147
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/97807a2d-ccf2-1fbf-06f7-085bb1bdf451%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 19:07:19 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Fix error handling in init_imstt()
  Fix exception handling in imsttfb_probe()
  Move a variable assignment for an error code in imsttfb_probe()
  Improve a size determination in imsttfb_probe()

 drivers/video/fbdev/imsttfb.c | 56 ++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 20 deletions(-)

=2D-
2.40.1

