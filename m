Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54344C3DA6E
	for <cocci@archiver.kernel.org>; Sat, 23 Dec 2023 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:cc:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=weJfrsBroETkxzTe6L9LzNAwb/EewFngdyGs7fw/wN8=;
  b=ktEwHbdyT9j6O2vL3mp3R4KQ0YX7czgbG0MnFOojzRyHuDm1ZJMNSUD0
   8hwo4rjGyT7YM+YsQecO3nZUGl2RAbfzU4x0eYDkTU0iHgj/RUL6bFkf3
   A8/wgqCQC27PbuUrnmiaiBk8YDqRxsgyj+QOQP80cKQt42jrFe1FCaM0h
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143887644"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Dec 2023 20:16:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2DFB5E0CCC; Sat, 23 Dec 2023 20:16:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4A59FE0AF1
	for <cocci@sympa.inria.fr>; Sat, 23 Dec 2023 20:16:48 +0100 (CET)
IronPort-SDR: 65873220_d8Wjxk2C95rtSVxrpyaoLp0FvYBKUYPTGDPjJlwG/AoTnPf
 0mEPndjWkyaj9MC7XuZhNRjrg2XjTdS7PkDilHg==
X-IPAS-Result: =?us-ascii?q?A0FiAADZMYdl/wMP49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YI4B3hTMgQLSIRTj0GBdS2EPoc1h0yIb4FWFIEsPg8BAwENQQECBAEBAwQ3A?=
 =?us-ascii?q?YRHhzgCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQKBB?=
 =?us-ascii?q?hOFbA0IglQBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdrHQEBESYBLgEFA?=
 =?us-ascii?q?hEVAl4BEgIBAYJ8gisBAzEHr1mBMoEBggoBAQavWB8sIlaBYAmBGi4BiBoBh?=
 =?us-ascii?q?WeEYg+BVUSBPINBg3yBBoMcgmiJGwcyghyDUIoihzd9BUFwGwMHA38PKwcEM?=
 =?us-ascii?q?CIGCRQtIwZQBCghCRMSQIMvCoEBPw8OEYI+IgI9NhlIglgVDDQERnUQKgQUF?=
 =?us-ascii?q?4EObhsSHjcREBcNAwh0HQIyPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNpHzIJPAsEDBoCGx4NJyMCL?=
 =?us-ascii?q?EIDEQUQAhYDJBYENBEJCygDLAY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDB?=
 =?us-ascii?q?AoDFAcLB1APAxkrHUACAQttPTUGAwsbBj4Cpk97E4J2K5JHkx2ecjQHgjSBY?=
 =?us-ascii?q?IFhDJ8rBhMvg24TkyUOBpJUmE0ggjGmFYFlATqBWTMaJIM2TwMZD44ghCuPC?=
 =?us-ascii?q?QE9QDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 aSFHDLDWq4XkLZqM2xm2le0hA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:dWMdOqqzRurLunMP4y8G6QIaV5rzeYIsimQD101hICG9vPbo8/
 xG78566faSskd2ZJhAo6HmBEDkexjhHPFOjrX5UY3SPjUO21HHEGgB1+ffKlTbckWSygc379
 YET0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvgxQpE1RCp2J9G1Ce3+m+6BNNXF77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:AB1Iwm9htF7MtRtZlpWVvwlJBd11QEzk8C6KHEWRJ2lNeZy0TWbFrQ==
X-Talos-MUID: 9a23:DY8YlgmtDdTNu9unguapdnp4Fe5mvbSyGXw3nNJFuMa5PjZ7FBik2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,299,1695679200"; 
   d="scan'208";a="143887639"
X-MGA-submission: =?us-ascii?q?MDFdaTXNig/MhiryWw6MFe/whRpRwe96uXr8W+?=
 =?us-ascii?q?huRw/aTflj8ZCAm6e3UyK/HXeBUvc6zJalICaEji3LmYDdYZyXF/jp3i?=
 =?us-ascii?q?15bFPMo+36RqqllRBKAzpmLYGRL4vnOYI8eEqmDXMb7O3Hk2U5ahg7Zz?=
 =?us-ascii?q?JxIfb+IhF7pTbR9L5bVn7DsA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 20:16:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703358994; x=1703963794; i=markus.elfring@web.de;
	bh=wZCbHnDCjJnEvDzsimFepIu5Oz2VW9fSNRNdT/39XCg=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=P1amz+2qHaMJlKq3fWNGX+30JNQyuwtPp04XEaigBsc5pqEBKW8UNGJgZ+XeduDY
	 +Gvv5mnPqf620FjIKmVYx8I/tKjPbbNE4C9gdSywBOfyfjjRcLvzWsfMr+bA5gXYY
	 BLRVJ9szsmhzhObWQTq2ob1PcvOdArYM7ckkhuItd5NN6eo4MZ87lvt1HVZ2mO0fo
	 He2eDpQTv/uOtHe3MiDeO0Kh+RUuOhkDCPxlU4j0h8rc3sJhbc5bsJT4tvB0Q+Pm4
	 8T96nKTe9ZcYSJJXDSpkb+C+OID1eYHVgSabMHGD3U8WUGX/PsIzg6nVZwpRm3rOv
	 D+OcjXmxgQy7DrpuNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPZd-1rctcp2beT-00MD18; Sat, 23
 Dec 2023 20:16:34 +0100
Message-ID: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
Date: Sat, 23 Dec 2023 20:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SSNGOMyB9De3VAUo1rhXHF89mRJ2KEVJ3ChkKr892h5SNGxCeeg
 6J+BiPBDqKSqZOQJSI7/6dasGH93mG6rOKPO3ScMqM8AviJ+KPiZc5PmobjTqW69T/kXuCD
 ZniowXIJDCCGOU5569t6BzLCctJHry+HWycsWnfBuTKzd2+LjL2Khh75fYznYTx94/LLCTy
 tmJl2Eeq6ym/8IPcW4dcw==
UI-OutboundReport: notjunk:1;M01:P0:dIsGslChmVo=;KIl2DQJ0SaaZilMKU2uek53scDv
 SLQAJykWPeahwM0XyCndzpqtiQk2TVJp12xeYPl8r1rvzn+7ZWsmWtAoWqrOKvcGW5To1537V
 4zP/4iTxfr8GyAsBFKYhS6FmckbvlX3JNO/fGj3COvL3hoqFzU8m1KBZIcNp9lhpT0l9NpXzi
 u3u+O1Cc+uN4CjIKQgZ3Fdtd5n8DqOylrREkgAXnpB4xoXdlXhmBMYZsC5oFGwvURvRcg0IbR
 xgbDKv3Iu32RJPlY1YKIeldc2Ur8NbjqJVMODnyWaAjLz9M2tttS4s4SylDu69os3GBrCIWNK
 /TEa8o4bbppkZF1Iy/QsKMWzeHwenT4FQEd6Q3X3BKDQi5QGaL70jwFhh4tp2xTihbV3btMLb
 Ekrmf+S/a0Cj6kjFrjvKb0T5PCQiovrBiNFKFiNZgB+PnOt2goTgoHw5IblToHx5lNcVghXGh
 t6glnBYvRIgssCVbSGS45MmpYkdjuxVVwljyfZY4Kybd8Nr3Crc2K14dyvVOC+Iq2JSJHIebJ
 ShR67nqcO3MTbhikdL/q/VwHn6i8vim34hm+ngfuHzH1mQ6tn+kBqpq7VahOsYdlfl8JkWDaJ
 WfW/tDV6N/HWh/E/hbzi5K9KcQigBdKO+Ytsuf5QRj2UBOPnaa5TViM0d3aObYQQyjB3CFNPv
 u56kKApX1vkrymOK99vIHfNo7vOcgn83j0SZ6XykbOftSDifCpPMrQFhEi93io7qSN1jlvB//
 +WAkhlYlnggZKPyel3wZCWTMLRrAesOmZpYGfBInzLKe+4s4irqVc33JvfdXWWJKSzwOHgByd
 9dYOngzIFrHLrhFtWL3nt+PF5FYskIDqIX06aOztsIWBiS1r0Et1W/tQ6hKLtuwCZA+SVd7Ni
 9AgUYlfL405+kC/IED6lpse0IFlz1SVHw6mK6JJjylfENGDwxtt5gJBjG4IanOqVMz2vFpVNf
 nJbyUg==
Subject: [cocci] [PATCH 0/2] powerpc/powernv/vas: Adjustments for two
 function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1363
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/7be66990-de9e-488b-ad6d-fafd1c7bb34c%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 23 Dec 2023 20:02:02 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  One function call less in vas_window_alloc() after error detection
  Return directly after a failed kasprintf() in map_paste_region()

 arch/powerpc/platforms/powernv/vas-window.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-
2.43.0

