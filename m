Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB7AC433FE
	for <cocci@archiver.kernel.org>; Wed, 18 May 2022 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:from:cc:to:date:message-id:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jWmD+uVdh2XryKF4PVV8vwve/TzV6+tHXQpDRZeDE6M=;
  b=kGuOKUf9aZFD2rkGJue28FKQwG9QurQD/EuZMlXLMeyWcQLN9wFK+kRE
   FOEMr7CrohMn4y76dfXF/Yy410J3+DpuRysD9AAjV9TEfq7pPlg9gZv8y
   5KW0Zo+xukAduS4xUgIxZ79pF642IQCgM7VRKALfn1TzIKIv10jA8jBp5
   k=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="36987770"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 May 2022 21:31:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C4920E4385; Wed, 18 May 2022 21:31:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BB7AAE001A
	for <cocci@sympa.inria.fr>; Wed, 18 May 2022 20:33:17 +0200 (CEST)
IronPort-SDR: pJmw8+u6KE86TykO3b5KPjOANQtBBg92CJqNyv1xon+3ZSo2SuUvp5ILhX0ApE1E4RqZVqhzjD
 aHXcaagwwF51i+Cw3vbAtAJvBqmyjGiQoPX3FEsei9K/Rkw1L51BklrfhiNihQAz9osoHPoEdN
 Crx0+X4u0ak1nE6npdIfrqubQMCS4zT24TGAdeqYAudEgs8v2iry9NX7JeSeCdtH7ThRrW2pQG
 vHzR6iovKSpkW8Mhv19IYb1ILgSDmnm0wO0aqNo2C6A0MpV0EyLrfQDyNA6y5j/bFS1IlEd5sD
 fJtMbWNVo5UBEqa88wO80+Gh
X-IPAS-Result: =?us-ascii?q?A0AzAQClOoVikNlUsotaHQEBAQEJARIBBQUBQIFPgiSBU?=
 =?us-ascii?q?y0EC0OETokAnyOHTAsBAwENQgQBAYUCAoU/Ah0HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEBAQEWCQ0REA4FPGRogU+BdAs0DYI1K?=
 =?us-ascii?q?QGDZAMDIxsCAQE3AQ8LGgIFIQICCwI6EAYBgw+DGAOtGoExgQGCCAEBBoYJg?=
 =?us-ascii?q?VwJgRAshz6CWS+EGyccgUlEgRU2gkQwPoEPg0qDQTeCLpU9HTsDHDQ7EoEhc?=
 =?us-ascii?q?QEIBgYHCgUyBgIMGBQEAhMRTQYdAhMFBwoGFg4UHBISGQwPAxIDEQEHAgsSC?=
 =?us-ascii?q?BUsCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLC?=
 =?us-ascii?q?gMRBAMTGAsWCBAEBgMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYND?=
 =?us-ascii?q?QQcBx0DAwUmAwICGwcCAgMCBhcGAgIZWAooDQgECAQYBB4lEwUCBzEFBC8CH?=
 =?us-ascii?q?gQFBhEJAhYCBgQFAgQEFgICEggCCCcbBxYZHRkBBV0GCwkjFgYsCwYFBhYDJ?=
 =?us-ascii?q?lIoKAEbApdFhAeWE4xTni2DV59xGjGDY5JtkgktkQyFLiCnCoF4I4FbMxoIK?=
 =?us-ascii?q?AiDI04BAgECDQECAgMBAgECCQEBAo4dGR6IT4VqITQ7AgYLAQEDCY8fAQE?=
IronPort-PHdr: A9a23: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
 jAqvKH+MjFP95TT58ROX6Dp
IronPort-Data: A9a23:VzZl2a2i+lvgshx4dvbD5cV3kn2cJEfYwER7XKvMYLTBsI5bpzRWn
 zcfUWiBMvqJZDOgf4glbd7g9BsDsJPWxoRrSFBv3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOHNIQMcacUsxLbVYMpBwJ1FQywobVvqYy2YLjW17U6
 YuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+tek
 NR8m4OwcBcKBpbmoss7DAtEHT4raMWq+JefSZS+mcCd0AvddGb2yPgoD0wsO4AcvOFtDgmi9
 9RBc2FLN0/TwbLqhujiFYGAhex7RCXvFJgVvWBs5TLUF/ArRdbEWaqiCdpwhWts2JESQqu2i
 8wxRht2fS3kUwR2HngmEI49nvmB2l31SmgNwL6SjfFuuDCOlFQZPKLWGN7cZdWOQe1Hn0OSv
 GuA/mLjAxhcOsb34TGC+XmtrvTemDvyHoMUDryxsPBw6GB/3UQfBgJQTlymu/K0zE2zQdRSL
 woT4CVGQbUOGFKDdfalXiyWv369rj0kYPBqPMtl+h2D1f+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+/U6SxTXK69EijCqenKxd+mEW1Ecz9aOHdsoR4tuYGLnW0lsv7Yoj+P+oaZh9nxECqYL
 9ui83Vk2O17YSLmK8yGEb3vjzyz4IPOUxQ+60PUU3ij4wc/Y5SqD2BJ1bQ5xakbRGp6ZgDQ1
 JThpyR4xL1UZX1qvHHUKNjh5Jnzu5643MT02DaD5aUJ+TW34GKEdotN+jx4L0oBGp9aJGW5O
 RWJ5V8BucM70J6WgUlfPtzZ5yMCkPWIKDgZfq28gidmPMEtKFfvEN9GPhfMt4wSrKTcufpmY
 s/GKZ7E4YcyEa1szzeqD+cayqND+8zN7T67eHwP9Dz+ieD2TCfMGd8tbQXSBshksvLsiFiEq
 L53aZDQoz0BC7KWX8Ui2dJPRbz8BSNjXcieRg0+XrLrHzeK70l6VaOAme57KtU890mX/8+Rl
 kyAtoZj4AKXrRX6xc+iMxiPsZvjAsRyq2wVJyspMQr60nQve9/3vqQSbZ06ef8g7uM6lax4S
 PwMesOhBPVTS2SapGtENcml9IEyJg62gQ+uPja+ZGRtdZBXQQGUqMTveRHi9XVTAyfu7Zk+r
 rSs2xn1W50GQwg+Xs/aZOj2lwGysGIbleY0WFHHe4EBdELp+YlsCirwkv5nfp5TcE2TnmOXj
 l/EDw0ZqO/Bp54O3OPI3a3U/Z20F+ZeH1ZBGzWJ57iBMySHrHGoxpVNUbrVcD3QCDH09aGla
 bkHxv3wKqdezlpErMxnFKtxxq945Nb1obJeiAN+EyyTPVisD7phJFiA3NVO5vASmeYB6VPuV
 xLd4MReNJWIJNjhTAwbKj0jY7nRzvoTgDTTsak4LRmo/iNx57bbA0xeMwPW0X5RIqQzK4Q42
 +ws/s0b8QqyjlwtKNnf1nJY8GGFL3ohVaQ7t8FHX9Cy0lpzklwSM4bBDiLW4Y2Ub4keOEcdJ
 DLJ1rHJgK5Rxxaffnc+fZQXMTGxWXjTVNF2IF4+y5ChltTawOQwwQda/HI0Qx5TwxEB1Ph8U
 oSu24uZOo3WlwqERuAaN4xvJ+2FLB6U4Er8zx0OjmKxo4yASDnWNGNkUQqS1Blxzo+fFwS3O
 JmbxXzjXDKse9v+tsf3tYiJtNS7JeFMGsb+dAxL0ihL81TWodYov0N2WVc1lg==
IronPort-HdrOrdr: A9a23:8zyCkq0JPeu1LIFuF2mi+AqjBLckLtp133Aq2lEZdPWaSL38qy
 nIppomPH7P5Ar5PUtMpTnuAtjmfZqxz+8W3WBVB9aftWrd11dAUrsSlLcKqgeIc0aVygce78
 ddmsNFeb7N5DZB/KLHCUWDYrAd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,235,1647298800"; 
   d="scan'208";a="14469475"
X-MGA-submission: =?us-ascii?q?MDE/6jEZlevQquBTO0QL2bRq0/Dt4um27Cxv4j?=
 =?us-ascii?q?gj4h5VWvz4UcPQIBgk/SjP9wRkAVM5vgvaqqxGt/9wvGA+G6zRCaYnHH?=
 =?us-ascii?q?1RgVXO6Jcq3hA4oWlpxLH83GL8zXtpAmkO7pKCKtv4eup5psD+kF6yng?=
 =?us-ascii?q?mACr95rqQtPaO2UFhbVynMGA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 20:33:16 +0200
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A60B7617BD;
	Wed, 18 May 2022 18:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112E7C385A9;
	Wed, 18 May 2022 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652898794;
	bh=jWmD+uVdh2XryKF4PVV8vwve/TzV6+tHXQpDRZeDE6M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ToKtzZ+AHv6BCT/RTlLtJOiRY2fTEKk3Yin0I4iIHZLSoARj2Z315NrCE3oPaAlMz
	 g1E6VYisjLvro3W2EmbOZqp0XByRvy8t1JAhv1z9ISR7If78Bp9Q4gjWyRFVWQw8qj
	 4wHZk+JKxrADyr2ohAte9TsKA/3EOBw4hqHUEX42PxC0EGpNZI6dzGh4o1EtcFgXaL
	 zvzNuuYtju4DSzYi43Ri318o/exA1uVUe0l8ZSBa0Yy3E8rirmKNkv08A1aRvUZPEa
	 j+df70NssRhUdIN3P39Y6MrN5FNkmQuHaUHfjoAw9Lj3prgQywokCPeyablVMGMpTT
	 Hsxx/Ggoxo5Dw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220517133556.6934-1-phil.edworthy@renesas.com>
References: <20220517133556.6934-1-phil.edworthy@renesas.com>
From: Stephen Boyd <sboyd@kernel.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, cocci@inria.fr
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 18 May 2022 11:33:12 -0700
User-Agent: alot/0.10
Message-Id: <20220518183314.112E7C385A9@smtp.kernel.org>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [RFC] coccinelle: Add test for unnecessary check before
 calling clk_disable_unprepare()
Reply-To: Stephen Boyd <sboyd@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 395
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/20220518183314.112E7C385A9%40smtp.kernel.org>

Quoting Phil Edworthy (2022-05-17 06:35:56)
> The clk_disable_unprepare() function only calls clk_disable() and
> clk_unprepare(). Both of these functions already check the clk ptr
> passed in using the IS_ERR_OR_NULL macro. Many drivers already omit
> any checks on the clk ptr, so it is safe to assume this is true for
> all call sites.

Skipping the check for NULL makes sense to me because a NULL clk pointer
is still a valid clk. I'm not so sure about IS_ERR() though. Do the
various implementations of clk_disable() and clk_unprepare() check for
IS_ERR() there?
