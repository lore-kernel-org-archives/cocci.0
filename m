Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71049C282CD
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MP3CYzbV4SLNXkeRjkm2gxZvCS4zGhZS71CY4NKnxwI=;
  b=JPH6/1O3z0rjVSjrCOT8eW8uPZEt5OulnqYNykTovbHLm/RFptrNXApr
   zv9tCuUt7GOnx3tHqPI3CE7k++JlsSb3es2PzWc5DUIbIDQCTESDYmTV7
   +sU2A04cocJ7Ztnw5KpSnj7DOsA39CDA9c/KffJ3Ceapq4qFFT5FPdLw0
   A=;
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
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210749923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 19:03:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 966C1E0264; Sun,  2 Mar 2025 19:03:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41805E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 19:03:06 +0100 (CET)
IronPort-SDR: 67c49d59_kKj2ifYSHzreAwnJmruEnQ5cJLVElmAN3QXEJ4W8D1YRRPv
 gFOGpeVHaUrXO39jXrGL/ayiI9xaavBvqCdh/Rw==
X-IPAS-Result: =?us-ascii?q?A0EtAABxnMRnfg4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDYnUzBAtIhFaIHYcygXQtA4Q7hzuHU4RvhAaBVoF+D?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDBDiBVIJ0AosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBOwcOCQExhXsNgmIBgSSBJgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CR0QCAQMjBBkBAREmAQ8fAQUCHwcCAlYGARICAQGCfoIwAQMxB689fzOBA?=
 =?us-ascii?q?YIMAQEG2lwfLCJXgWUJgRouAYVrgmMBhVIZO4Q8Jw+BVUSBPAuBCYE+b4QKh?=
 =?us-ascii?q?BSCaYIzgWqDPYZNhwGSA4kHgU0cA1ksAVUTFwsHBYE5OAMgCjQUBBkCFBwBD?=
 =?us-ascii?q?wYQBGpDN4JFaUk6Ag0CNYIeJFiCK2oEBYNbhD2EQII/UYJCghFxgReIAoEth?=
 =?us-ascii?q?GodQAIBC209NwYDCxsGPaFuOoNPcgFSO0yCKpJvnk2UVjQHgjiBZoFjDJ9eB?=
 =?us-ascii?q?hMvhAOTQg4GknwBLphPIoI2plmBZzqBXDMaJIM2TwMZD44hOIN1jwoBuSVCN?=
 =?us-ascii?q?TwCBwEKAQEDCYVGAQGKIDSBSwEB?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23:Q6quUK2y4XIdzyTbZfbD5RZ1kn2cJEfYwER7XKvMYLTBsI5bp2YPy
 zcWCmiFO/mIYDOgKIwjbNu+8EwG78LXzIJgTAY93Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gFaYDkpOs/je8Eg35qyp0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW3/2/ctUAB4UAYdGxeVcPDBx9
 6ETIQlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAV7B8G8+FGviMvIMwMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKWQA9w7E9PNqi4TV5DFc6ojSbMf7RtutZ8cKo2+bl
 mDZ+3usV3n2M/TElWrdqSLz7gPVpgvwX4kZFZWj5/tyiRuSwHYSAVsYTzOGTeKRj0mjR5RAJ
 kZS9idGQbUOGFKDSsPDYSe0/1y4tEAjWPFtQtI4tQqE8/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+8F4xQw6NV5rlrCrN+pQSOOBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmhm
 1hmTwBn2d3/aPLnMY3lpDgrZBry/fD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxJTGvL1VXM3XzHfcKAnoIF1Pz6nbWNE7qQE/d6TNCxzzpy/+FWytyGovfRYybK7ohxeyM
 BKI6Gu9G6O/zFPxMf8vONLuYyjb5annE9P+HuvZBueikbAhHDJrCBpGPBbKt0i0yBZEufhmZ
 f+zL5zwZV5EU/kP5GTsGY81j+Rxrghgnjy7eHwO5075uVZoTCTKEe9dWLZPB8hlhJ65TPL9r
 okPZ5HQmkQCOAA8CwGOmbMuwZkxBSBTLfjLRwZ/L4Zv+yI3SDtzOOyb2r47ZY1ukoJck+qCr
 Dn3WVZVxBC7zTfLIBmDICIrIr7+f4dNnVRiNwwVPHGsxycCZ6Sr5/whbJcZR+Qs29Fi6v9Wd
 MM7Xfu8LM5BcRn53ggMTILcqdVifSu7hAjVMCuCZiM+TqFaRAfI24HFe1Lx+Bk3Eybti8oap
 oek9wLEQKgsQxZpI9bWZcmOkXKwnyk5s8BjU3TYJuJ8fB3Xz7FrDCjqnNobEtoqKx7T4he/y
 CCtHgY+menBh6QX4ev5r/mIgKnxGtQvA3cAOXfQ6IiHEBXz/02h8Ndma/mJdzWMb1HE0vyuS
 ssNxs6tLcBdukhBtrd9NLNZzagewd/LjJ0CxyRGGET7VXiaOolCEFKng/YW7rZsw4VHszSYQ
 kiMo9lWGYuYMfPfTWI+GlAXUfSh59o1xB/p8vUHEGfr7nRW/Z2Gc3loETuitSh/FIZxYaQZm
 boPmchO8AGuqAsYAvDfhABuymm8BHghUaImi5IkPLHWmjcbkm9lX5iNJRL1sbeuaspNOHYEO
 jW7prTPrJUCy1vgc0gcL2ns3+1cic4wuTRP9lsjJkuIqPXBlPQYzB1cyhVpbwV3nzFs8fN/B
 XhvDGJxfZ6xxjZPgNMZeXKBACRTLUS91m2o7HVRj0zfbU2jdlKVHV0HIezXoXwoqTNNTAZU7
 JSz6TjDUw+zWOrTwyFre0pui8K7fOxL7geYxfyWRZWULaIbPwjgrLSlP1cTih3dBsg0uk3Li
 M9q8Mt0aoz5LSQgmLI6OabLyYUvTA24G0IaTcFD5K8pGUTuSAO20xWKKGGzfZppDN7O+kmaF
 cdvB5xuUzKT6SWwlQ0YVJU8e+JMoP0U5dQ5auzKI0wCuOChtTZHis/b2RX/o24JeO9Qt/gBB
 LnfTB+4KVzIt0BowzfMiOJmJluHZcI1YVyg/eKtr8QMOZExkMBtVkAQiYmLnminHzZm2zm2v
 wrzQbDc4MI/6IZrnqrqSr5iASftI/zNde24yiKBmPUQUsH+auL1qBEwhmT8GgZrYYsqRNV8k
 IqSvO7N3E/quKg8V0bbkcKjE5ZlyNqTXu0NFO7KN1hfwDW/XfHz7ys5+2yXLYJDlPVf7JKFQ
 yq6cM6BSs4HaexCxXF6azlsLDhFMv7ZNpzfnCKaq+iALjM/0gadddOuyiLPXFFhLyQNP8XzN
 x/wt/OQ/etnlYVrBiIfJvRYEpR9cU7CW6wnSoXLjgOmLFKU23GMhrizsiAby2D7OiHRWoKyq
 5fIXQP3exmOqbnFhoMR+ZB7uhoMSm1xm68sd0Ya4MR7kC2+EHVAF+kGLJEaEdtBp0QeDn0ji
 O3lNwPOyBkRXAiotT3558n/GBiSDKoCN78V49DvE1y8M0+L6EGoWdONNRuMJ19pdzGlwOzPx
 RQ25CjrJhboqn12bb972xF46NuLAtvFy3hO9U2VfwkexfoBKe1i6UGN1zahmcAK/w8hWakLy
 aUIqbh4fXyG
IronPort-HdrOrdr: A9a23:TTYoC63Rl6/dffK3Ra+d8QqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:nRBbRGPogZBCAO5DXDNZynQYReIZeCPiz1ztcnC6VG1gcejA
X-Talos-MUID: 9a23:ijK67Asyb0X0YTNHI82nuRxYBPg0/oqSD2cvk8o7ksq0NzN0JGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,327,1732575600"; 
   d="scan'208";a="210749915"
X-MGA-submission: =?us-ascii?q?MDE+sf+6Y/B7NCMCsR1TLRKOVauMK2UmuKQu43?=
 =?us-ascii?q?5Ag7c+ZlIlK+553XV6QunDV2dWovuEpFSMYqpO/yhmlqIfaXebQPeHE9?=
 =?us-ascii?q?Cp5k20VZq6H24WOJqKE1Gpz9QxB2jbsFf+SFBgaD63ZcXgvDsl8V4V1/?=
 =?us-ascii?q?kM0u/bHO18k77sNUO2DlBZcQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:03:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740938533; x=1741543333; i=markus.elfring@web.de;
	bh=MP3CYzbV4SLNXkeRjkm2gxZvCS4zGhZS71CY4NKnxwI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h2up08QIJuNb1Kkw0qGRSRFBUPboD0Ub7SIZPSxUI2KWX2+iPnmaCE2XPGO89HtS
	 cNuf2uGnSN+bjQ4yNLYFFjnzWMdk2XOuFPHvkghRARAh89YHYqRkMMX6UmJDMlTAi
	 2ZTmR6jBvPYRAs1BmaByCeWOWrs8ug20ZpgsZBq25LwgjVlG4Up2tLkcJ1OPEzcbY
	 5U+cdisLvQpkif79YywhvTbI7g6eg03dWQRJ/44cjQrgsAqcbEMHuA3YeX7TIYEQ9
	 2dz/sLBQP+XZWbHAaVUF+VdHQ89pzq2xcocye2X3c6a9/VPVmBq+WqQqNK8SzxHFj
	 OzxskVb+FjK1sQBudw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1t4EN01Q23-013zow; Sun, 02
 Mar 2025 19:02:13 +0100
Message-ID: <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
Date: Sun, 2 Mar 2025 19:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>,
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Yihao Han <hanyihao@vivo.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
Content-Language: en-GB
In-Reply-To: <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TA4NVn2grx0TTOq+nzTZct2Bwfp8ZWwFKVUFcX47RfI2TKfL2rK
 /lq1ef8WZ7BXECt83hHAzIbRJxKqvX5etXT8NFjr+BzmG/sxrpz4YLDxfiGW8MYfepISiwY
 4M5F+UHew6eP9V0utctkTURC9D5iH86InNPUrfABaTSVVi8pQtZ/7UDkI/1VmSPRGflRPQU
 rpm7Y05RQfml7v0//HEZw==
UI-OutboundReport: notjunk:1;M01:P0:y5CMX5amRq4=;e0gSeyKW42FBSDp3F0Aw8wCZz4N
 55ufKUCo6pZS2keF9nDhZ+jUZ+pqAp40YFIZErcE0e+atIPcI0Te6s30bBbEI91vyNx4F4Bj3
 VPAIw/jHkoay0ILKWb4dLBknnTKTpXfqiOZF2YMx0jKwQwDqSKzfAwitck02QqY8T6vMKO+VJ
 7yYr7YAvjo2OSbBA+J9aeVPQn3nUvJf3YVG09HNZNlxZNolpXhIf5BE+Vak2/SBByLcG/mOb6
 6CILsxh6aabiQgkoOe12nPl4rhVXI1Rul69L6QmN3JPpiWFrajplnWj+vS12sxW4nvWXYZzce
 523/EskMWbDW4AeLXtAzzwgUQgEbx+hFhUFzp8SmWIcCyr5Tonx19TMfE4EiEIY1YrCxRVRS6
 fQq+ODh2blFdmLWb00CyBTDKSqQMd61KK7ofE4wPL4DBD/jybpz+xl9qzX2WL0AOnW53PgCwk
 VQ1XDYyQZyWUKBM3d9ya5spuC4ELmiBIi1R/4qb4Nmxga4McMUzjpFUSrFXFUaUf96WKI3ygQ
 W9iG954K4FJ3k1OK0h5Lwx0Gk+kXV4hQIf9MeSRVnZhDfosQHWB+j7YKs0qPrVW+Ir0rhRRtK
 Vxhe9UJYww6r9fCX+LFi003/vl0w8PExDQYQEZphr5WZvYGXZsjf+nMSvsx9btuFdiSX+6yV8
 FQ7dzunwy58CYH04Mlu8iurU8Tz+1BHA3Xrk21vTGrktMpU14VjvXfJFMb76tWoNlro+6WjQ/
 quRP7zLMVU3aYr1kuU3qpwYY6WszJfkTBu0/K5M0Lf62tDknOfZSRheJD+gHgLvgtm88ZoAiF
 nYYZmf9ri99DUoJkAw8Rhls2YbP6PyE0dbWBgLIPHjVdpS5+/Rb8gmNI6PWpfkK7p8+jp+UOk
 imu2w+q/HIKAabBP2zsQYtXpWgeXtETovhmvt8uMbKES4bl/2NDWQSehMOHcZiq9wvguy+G+9
 D37LxYoQvg4X2nyz1VaiPsTbRuZuuL0CIAc0cO03bAMn4wkoPuJxQJOEdyf/7uJSorfoAUljw
 VE3g2/i4oCDAriLG24lr8nxunrFM5oXLoHk6ZVV16uIt1uKv7rq2x/E/zGvRv8VPOzreh6lkl
 tNWaZFuoWj9tjdxdgXO1FPHSTCGzX329w0ld5I9tehjWAVyxmfpoJLncoxL8kCLPYUSi8S38y
 rw4DdFHBMr+Q3ZgDfz6DP5ai30q+Fm0yuHsG08McZbRhiWaN9LEOC83SxcqKpsTpBoLPIHR/G
 hoCqDmhuRcD4055QzEzE3Tmcr8jR9DlUBUGJkDjW4Xx8F0LrlxxiOSdT3fD7gLhuGE2JVOh8l
 OQA/eWXC36Ycyjt83NR4zJ1uAPC09scM4j3nR7nx85WzKLi5jHv+GpdFN656SNHc03DBWNxZz
 6eXM0S8PA7R4UCbVB+kOTW4bEfQYQYH6EQh7d8xfMalhYu99GFiZ6W3SJFcq3h/t9sGOBk7N7
 ncJpTUg==
Subject: [cocci] [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2470
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/3f1e7aaa-501a-44f1-8122-28e9efa0a33c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 13 Apr 2023 21:35:36 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cau1100fb_setmode=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/au1100fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb=
.c
index cb317398e71a..fcb47b350bc9 100644
=2D-- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -137,13 +137,15 @@ static int au1100fb_fb_blank(int blank_mode, struct =
fb_info *fbi)
 	 */
 int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-	struct fb_info *info =3D &fbdev->info;
+	struct fb_info *info;
 	u32 words;
 	int index;

 	if (!fbdev)
 		return -EINVAL;

+	info =3D &fbdev->info;
+
 	/* Update var-dependent FB info */
 	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
 		if (info->var.bits_per_pixel <=3D 8) {
=2D-
2.40.0

