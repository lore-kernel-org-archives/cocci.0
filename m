Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFECC02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c2Rc5bkhhc/tqqFLF5uHC8SOV1M8qRjFpSNRYz/wojU=;
  b=kX0x3YxkYQyO3fD2p6dCjyVyTSjfFwt7PjQIb4h33DOG3rrfsBfQYbGf
   xksM7csNYdPU1WgtMBvWpfzFCH2+J9o5B+xeLk8OSoXwQCvruIHWF5ac8
   mly7F4K42pOtrPZdtB1MB+rGo1rR5NE+H1eoKp7K9jmUD0H/8ac+jRiwk
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325102"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6EF63E0D47; Tue, 28 Jan 2025 10:13:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 325A4E007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 16:46:05 +0100 (CET)
IronPort-SDR: 6793b5bc_igomn7K5ew5uJ+oWBX269fPxIouzlQXc2CaJPrydte+njRC
 RhFu6FNPT/mvwtA6hv1YZ55OyZ6W6RREDC6qloQ==
X-IPAS-Result: =?us-ascii?q?A0GHAwDxtJNnhcNp+5RagQmBUwKBcFJ9WjMEC0gEhFKPT?=
 =?us-ascii?q?oIhA5xCgVaBfg8BAwENOQgBAgQBAQMBA4IMgnQCinUCHgcBBDEIDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNSQEQAYIHATNxg?=
 =?us-ascii?q?SUBAQEBAQEBAQEBAQEBAQEBAQEBFwIIBV4BHgEBAQECASMPAQ0BATcBDwsYA?=
 =?us-ascii?q?gImAgJWBgESFIJtAYJBIwMBBAy4LHqBMoEBggwBAQaCaNk3gWQJgRouhWuCY?=
 =?us-ascii?q?wGBbIN/O4NCeicPgVVEgz1PMz6IHoJpgjOBdII0gQyLEYE9gj4WgW2EZ4Fji?=
 =?us-ascii?q?GAJSXscA1ksAVUTFwsHBYEpSAOBEiOBJgU1Cjc6gg1pSTcCDQI1gh58giuCH?=
 =?us-ascii?q?4I7hEWEU4VbghSBZQMDFhABgjVyex+BKB1AAwttPTcUGwadVj2FHwgQcSAHg?=
 =?us-ascii?q?R9AkkAIg0eOfqBPNAeEHoFdBgyKKZIkg1eEBIFXiy+ZSZh8IosQWYF5mngxg?=
 =?us-ascii?q?WkBN4FcTSODNwkKPAMZD446H4NChRTAdiU1AgE5AgcBCgEBAwmFRQEBAYd8g?=
 =?us-ascii?q?l+BSwEB?=
IronPort-PHdr: A9a23:PRFzKhdFucuxtUYsDHjGtgHhlGM+GtfLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASQG9yEt7kY27uempujcFJDyK7CikxKSIZLWR4BhJdetC0bK+nBN3fGKuX3ZTcxB
 sVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd+KPjrFY7OlcS30P2594HObwlSizewb65+I
 A+roQjTucQajoRvJ6U1xxDUvnZGZuNayH9nKl6Ugxvy/MC88oJ9/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6XQAXGoYlBpIGBXF4wrhXpjtqCv6t/Fy1zecMMbrUL07QzWi7
 6NsSB/1lCcKMiMy/W/LhsBsiq9QvQmsrAJjzYHKfI6VNeJ+fqLDctMcWWpBRdtaWyhYDo+hc
 4cDE+8NMOBFpIf/ulQOtwOzCwqxCu3v1DFFmHH40q800+QmDQ7J0gMvEd0VvXTIr9j4LrseX
 fyvwaTKyzjIcvNY2S366IjNah0vufCMUq53ccrV00YvDB7OgFuNqYzrJTOayP8Ns26F4OF9U
 u+vjW8npB12ojir3MgskZPFiZ8IylDK7yV23p01JdumR0NgfdGkF59QtyWAOIRtRcMiWXtnt
 Dwmxb0BvJ62ZS4Hw4koyBDDcfKIaZSI4g79W+aLJzd1nG5odbO+ihqs70WtzvHwWMe03ltFr
 iRLksTAu3MT2hHN9sSJRP9w81mh1zuM2A7d5OJJLEE0m6bGJZMszaI8mJoVvE/eECH2n0D2g
 7WXdkUi4uWo6ProYq/gppCCM494kAb+Mr4hmsG5HO82MRAOUnCG9emz17Dv51P1TbVXgvEsj
 6XVrJDXKd4GqqO9AwJZypgv5hejAzqn1dkVnGQIIE5ZdB+CkoTlJlTDL+78APq9glmhlTJmy
 vLcMbDlBJjGM2bOkLP8fbZm905T1hAzw81e55NVFL4MOO7/V0nsv9LCFBA5KRa7w+P/BdV9y
 IweXWWPD7eCP6zItV+I5/gjLPWLZI8RvDbyMeMq5/n0jXAjhFAdeKip3Z0MaHyiAvtmJECZb
 WLtgtcHD2gKohIzQPHlhVCBSzJfeXa/U78m6j0mFI6rDZ3PSp2pjbGBxCu7G4dZZmFCClCCC
 3focICEVu8KaCKTPsBhlTgEWqK6S4M7yB6uqQH6y6B5IerP/C0Xq4nu28Ry5+3XkRE97yd7D
 8OH026XVW17gmQIRzou0KB5ukNy0k2D3rRgg/xECdxT4OtEXhkiOZ7G0+N6E8zyWh7GftqRT
 FapWNunDis1TtI12NIPYkd9G9C5gRDZxSWmGb4Vl7qRBJw16K3QxXbxJ9xlx3bcyKYhl0UmQ
 tdINWC+mqF/8BTcCJLIk0iCjKardaEc3DbX+2uZzGqOultYUA9qXqnfU3AffBiekdOswkrfV
 bKoFfwfMw1KyceYNuMebtT0l1hAWLH7OdLVY2urh0+xCRuB3bSKZo3jYWlb1yLYXgxMtgkO5
 3HOHgEkGC6lo2WWJzxjFVvlKxfp+ulzqHqxDU8pxh6HbmVi2qCz9xpTguaTHaA9xLUB7QEgo
 DJwFU3188/YEdeboQcpKKNdatQ56UwB2X/XrQFmOJGIJKdmglcUdB5++Ujp0kMkWc17jcE2o
 SZyn0JJIqWC3QYELmvAtXiRErjeK22ouQuqd7aTwFbVltCf5qYI7v087VTlpgCgUEQ4oD18y
 9cA9Xya693RCRYKF4rrWxMx9hN9o7jBJCUg6ZnZznthGaKztjvL0dUzDa0uzRPzN8xHPva8H
 RTpW9YfG9DoLeUrn1azaRdROuFZ86o9JIWqavWc1bWtMc5rmzaihG5A+ok72UWJpGJnUuCd+
 ZEDzrmD2xefETfxiFD0qsfshYVNfi0fBEK1wCzlQoVWYql7d4ERAGurIsusgN55gvYBQlZ+8
 1iuTxMD0c6tI1+JakDlmBdX3gIRqGCmni2xy3p1lSsop+yRxn6GxeOqbxcBNmNRIQsqxV7xP
 Yi5icwbV0m0fkAokhWi/0Pz26lcoux2MWDSRU5CeyW+IXtlV+O8sb+LYsgH751N020fVuW3Z
 lSTUfjxvhUA3jjlEkNVwzQ/fjutoJy/lBt/ySqcIHt1sHvFaJRo3x6Mgb6UDfVV3zcAWGx5k
 WyOWgj6ZYTwu4zMytGa473tMgDpHodeeiTq046a4S6y5GkwRAa6g+j2gNrsVw4zzS780dBuE
 yTOthf1JIfxhMHYeapqeFdlAFjk5o90AIZ7x8E2hZoX3XEBwJmI82AKimH+Gd5c3ab3Zn0XT
 HgAxNufs22HkAVza2mEwY70TCDXxMpqYN2zeSUaxywn4ttMBY+f67hAlCFyuFP+pgXUK6sY/
 H9V2b4l73gUhPsMsQwmw3CGA7wcKkJfODTlixWC693WQLx/XG+0avDw0UN/mYrkF7SeukRGX
 32/fJ4+HCh258E5MVTW0XS15Ju2MNXXaNsSsFWTnXKix6BTKZk2kvMRwyZ6N3jwpnso4+U8i
 Rhn15agtc6MLGAl8K+iAxFePyH4fItKpmGr1/sH2J/Ogsb2T8gpEy5uPtOgVf+yFTMOqfnrf
 x2DFjExsDbTGLbSGxOe9FYzqnvOF56xMHTEQRtRhd5mRRSbOAlemFVNAGV8xMNgUFnymYq4I
 Roqg1JZrkT1oRZN1O9yYhz2U2OF4Rytdi9xUp+Uahxf8gBF4U7Rd82Y9ON6WS9CrfjD5ESAL
 HKWYwNQACQHQEuBUhrlP7Kp4dDbteSFCPCzNP3DSb6JrehXXfCSzNSk1Y4srFPufo2fe2JvC
 fE2wB8JW3FyHMDQgHMDViINmjnLYuaQoxO48ydwtMn5+/PuElGKh8PHG/5ZNtNh/AqziKGIO
 ruLhSp3Hj1f04sF2X7CzLVMlE5XkSxlcCOhVKgRrSOYBryFgbdZVlRIDkE7fNsN9a832RNBf
 NLWms+gnKAtleY7Uh9EU1flh82kN94NI2a4PVLDQk2MMdHkbXXKxcrzfK+xG6FKheNPshSxv
 XCdHlOrPzKIkyTlWkKmNOheiyeAMQcYs4a5dh9nDnLqCtnhb3jZeJd2lWNkm7Rs3yGWOz5Oa
 2AlIRIU8OfCv3kQg+0jSTUdvjw/cLDCwn7EqbCJd95ep/JvBm4ce/tyxnM8xvMV6ShFQKYwg
 y7Otpt0pFrglOCTyz1hWR4IqzBRhYvNs18wcaPevoJNX3rJ5ndvpS2ZFggKqt15C9bup7EYy
 97Bk7j2IStD9NSc9NUVBszdIsaKeHQ7Nh+hFDnRBQoDBTmlUAOXz1Rai+2X/2aJo4ISoJHom
 dwFTbtfXVYyDPoWD0VjB5oJJ5I2FjIonLiHjdIZsHqzqB6CIacS9pvDV/+UHbDuMGPA0ekCP
 UZRh+qgcMJKZ9Covi4qIkN3l4nLBUfKCNVEoyk7KxQxvF0I6n91CGs6x0PibAqppn4VD/+92
 BAs2W4cKawg8inh51AvKx/Eviw1xQM3mN7ihTmKNjLsIr29RodbIyHzs0w4OJThSkB+agj4z
 ikGfH/UAqlcibdtbzUhkAjHpZ5GAuJRV4VOaRsRg/qQY/Eh21NGoymixElco+DCDNEx8WliO
 Y7ppHVG1QV5adczLqGFP6tFwG9bgaeWtzOp3OQ8qOf/D0wE9GLUcykMvEUCMaMvKy+p+Pcq4
 guHyWMrkIckXP0upvtg8Vk0fe+HynC5u1amAku2M+iWJaSDsi7LksvaGjsN
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:CPR9wK35g8t8XGWCmhTNoAqjBIskLtp133Aq2lEZdPWaSK2lfq
 eV7Y0mPH7P+VIssRQb8uxoV5PhfZqxz/FICMwqTNSftWrdyQ2VxeNZgLcKEweQfhEWn9Q1vc
 1dmupFeb/N5DNB4foSjjPXLz9t+qjhzJyV
X-Talos-CUID: =?us-ascii?q?9a23=3A5f+yOmgBZKFYmQq6wK2U9RJBdDJuT3CMzCb7eUG?=
 =?us-ascii?q?ENW9gd5iwdnu9x5hnqp87?=
X-Talos-MUID: 9a23:9BjIuQpD8irQM5JMSTcezyFvEZkw04a1MlsQqqginPCldhdbACjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="204898467"
X-MGA-submission: =?us-ascii?q?MDHkz8O56N6Vbwk199neq76lIydp9Bb3tPTEp9?=
 =?us-ascii?q?AOGKiBxFoSYgKaCtH9FVLhgKlZWNyVJ1KI5rbSogdPkcosnalpLzvZZy?=
 =?us-ascii?q?QpHrLxFInxnNLKDXJngXAVneJ2S2DfmUlmBwlWsthKF+2M8dNsXKoX9y?=
 =?us-ascii?q?ititUHl5n7T/NQGbwfB8dVpw=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 16:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737733563;
	bh=cLZOIgnfgjGvNUIYx04zBqZGna/RfQWRwRglzMbRjPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IMRZRySe/CPCOi90T2I+F73BaBf5gi8JCS9AU4jiUx/4oKydpEeGcGUquzkgkZ8ku
	 s16m5Dy33q+SVtJtezCnGsQXyZbeouaJnwtmxrqpk+0B0v1RpQ3yw7+/4OY56EPnhU
	 ZY5+jHI2jtvJRNOkyARBF62bN7SU5lO81jitCgbRyDclT7GT4Sh8K4SWDfhepSlm8Y
	 K0XUUCWY9kDa3Nq2CPI04YIxYkU3TFDBpeJrgRTFmi8ApWPiWX/8bHfjlqpShdT7CC
	 STyrLmfiuSs2oBCbh1sqkPf9XJBqqmR/pJYmQ7/jmGfTn1n9gvwCZdS4grHLOrvaFg
	 rgDZogfAn08Uw==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4998417E0E6E;
	Fri, 24 Jan 2025 16:45:59 +0100 (CET)
Message-ID: <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
Cc: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>, Vignesh Raman	
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, 	dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, kernel@collabora.com, 
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, 	shreeya.patel@collabora.com, denys.f@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Fri, 24 Jan 2025 10:45:57 -0500
In-Reply-To: <20250124130021.GA6853@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <20250124135203.040d0852@foz.lan>
	 <20250124130021.GA6853@pendragon.ideasonboard.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2253
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel%40collabora.com>

Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > 
> > > > It's been a few years since I first thought on finding a good way of helping
> > > > kernel developers testing their patches, while making use of the free runner
> > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > new to kernel development, or students trying to understand it better.
> > > > 
> > > > And this patchset allows that to happen :)
> > > > 
> > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > 
> > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > 
> > Sounds interesting!
> > 
> > > Gitlab as an open-source software project (the community edition) is one
> > > thing, but can we please avoid advertising specific proprietary services
> > > in the kernel documentation ?
> > 
> > Every time Gitlab is mentioned, the brand of the company that
> > developed it and has been providing proprietary services is also
> > advertised. If you're not happy with that, you should move to use
> > a git forge developed by some open source community.
> 
> I'm fine mentioning the gitlab community edition, I'm not fine
> advertising gitlab.com SaaS in the kernel source tree.

I've just looked attentively, the intention is just to explain you may need to
set gitlab variable in your project fork in order to select correctly sized
sized runners in your own instance. Its is not strictly about commercial
gitlab.com instance. The default only works with the original project used
instance (which is not gitlab.com as far as I know), but the comment refer to
companies that will choose gitlab.com internally to reduce their IT cost.

Its quite a stretch to call this "advertisement", that makes it looks very
dramatic. I personally believe its quite ahead of most other gitlab CI to take
into consideration running these pipelines on foreign (to the project)
instances.

Nicolas

> 
> > The way I see, the best would be if the CI integration could work
> > with more than one type of forge and being able to use any
> > free Git??b-CI runners that would be available for developers to
> > use, as this would allow testing more subsystems with CI, thus
> > increasing code quality.
> 

