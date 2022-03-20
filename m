Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1606C433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L5ugBzfkrS22BleE6EhJPUW2x/e74mgdBCCsO6kTfM8=;
  b=iixHIz0RNFIheI+AXFXflZM2L+6EH/wxUrJiH19yi8pHx/j1TuUSo7tm
   bbbJTEiUK0BmM6L2AeZvbMWr/vUbviIzd5gSjLznMtFA3jJfhJrMGHOcd
   L17Z0yqdOE2yWwd6hcE7COj3HtSNtDDLhdCMPXBl2O2qIVL2vdiDMnPM1
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27065875"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 10:07:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D85E5E020F; Sun, 20 Mar 2022 10:07:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 726ACE0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 10:07:55 +0100 (CET)
IronPort-SDR: ofPAyabU3b+x3z1c8dXz+S9c4df2Qr/wRHnQsb42f+ihmUwn6ylvKIpA0qI0HvcdbbqpnRRg6f
 ZQ2yWBwKkGTN/bl8hc1xwxRk+yQdZTI4+5eARUVtqUBBqitbjbBg7RWvdtJ1FK8y4x0OD3yOSp
 fWezSM2828jp0nrctCvturgk0WlAkACuahGrcKq610Gf5+yhnezL90sI3y92XqD76iDYRRqegT
 MyH8dk03y9Wnm/SB9ukirYUQeffjk4inSA0f0xe4O1uvsVkITL3Obzc3yQPc/JWWinTIERyYm2
 tEg1D/zzl4msk9TJnlrNQiSw
X-IPAS-Result: =?us-ascii?q?A0ALCACu7TZihk7ASNlagQmBXIImgVUrBAtEhFSIKIZLg?=
 =?us-ascii?q?iiEH4cFhxiKKIF7CwEDAQ0SASsBAgQBAYISgmsKAoQ0Ah0HAQQ4Ag0BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDAsJBwgKBw4QBTYGXgZkB?=
 =?us-ascii?q?IFLBIF0CwcIJQ2CNSkBg2QBAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgwCCZ?=
 =?us-ascii?q?QEDDSWtZIExgQGCCAEBBoRIHywiUoFbCYEQLY1OeicQgVVEgTyCUzA+h1+CZ?=
 =?us-ascii?q?ZkOpGqMC5I5NAeCEoE6gUEMnhEGFC6DYgERkkkOBi+RPh2WPqcCgg+BZzMaJ?=
 =?us-ascii?q?IM4TgECAQINAQICAwECAQIJAQEChUuIa4QMiixANDgCBgsBAQMJhUcBAYwpA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qzg==
IronPort-Data: A9a23:c91Nq6/1MB+JsjfxAtvgDrUD6HiTJUtcMsCJ2f8bNWPcYEJGY0x3y
 2YWXG3VPayMMDD2e49yatm3oxwOucPTnNQ1GgdlrnpEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV4
 omq+5S31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zw
 utGh62IbxkVFYKXhPQceCVSIT9EMvgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8oRz4Us
 6VJcnZSPnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2QuocGgWdv2qiiG97Ae
 sEJZCFGYS/JRAEUanc1I7YarciR0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc9hhI
 H4lwgwwkYMdr1C7T/LBVS+mmnHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWFzj
 A7YxLsFERQ+7OzMERpx45/O9WvaBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmgn
 FhmTwBk393/aPLnMY3lpzgrZBry//D0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxZTBs7lSU8nVz3bWKAnoIF1Pz6nVWNE7qQE+d6TNCxz2pRZPgKgNvGAgfx0B3jgsI2KzP
 BO7VfxtCG97ZSb2M/YuPepd+uxzg/GoFNL5W+rSY8YGa5cZSeN01HEGWKJk5Ei0yBJEufhnZ
 /+zKJ/wZV5HV/gP5GfpH481jO5zrghjlDi7bc2qn3yPj+HFDFbLEuhtDbd7RrtlhE9yiF6Iq
 4o32grj40k3bdASlQGMqN9Ndw9WdSZnbX00wuQOHtO+zsNdMDlJI5fsLXkJIuSJRoxZybXF+
 G+TQEhdxAatjHHLM1vYdX1pLr/iBM4toXU+NC0qHFCpx3l6PdfxtvhCLcNvcOl17vFnwN51U
 +IBJZeKDMNPfTKbqT4TWp/w8d55fxOxiAPSZCeoOWBtf5NpSwHT1MXjew/jqHsHAiat65khr
 rfm2g6CGcgPQAFrDcD3bvOzzgrt7CZHx78oBxPFe4ABdl/t/Y5mLz3KosU2e8xcew/ewja61
 hqNBUlKr+f6o7gzrIvDi5eCotr7COB5BEdbQzLW4LvqZynX+m2vnd1JXOqSJGmPUWTp5OO9a
 O8Tw/ylaK8Lm1NDsoxdFbd3zPtitoW1+OIAllxpTCfRclCmKrJ8OX3Yj8NBga16wOMLswWBX
 E/SqMJRPq+EOZ++HVNNdhApaP+PiaMdljXItK1nJULn+Glo8bDBXUgLZ0uAjylULb1UNoI5w
 L596ZBMtFHl0kInYoSckyRZ12WQNXheAa8pgZEtBtO5gAQczFwfM4fXDTX74c3UZthBWqXwz
 uR4WEYfa3VgKkv+n74bEH/QwaxCiJ5ItB0iIJru4biWsoKtuxP19EQ5HfcLosB90RhNle5+U
 oSuH1MgPr2Apl+Em+AaN11B2Gh96Nmx5UH7jVcE/IEco49ESUSVRFAA1S2xEIz1Po6SkvW3P
 F1V9Yo9bQvXQQ==
IronPort-HdrOrdr: A9a23:AZTwzqq/ybjJ6h5FYgpQHtIaV5oPeYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27065874"
X-MGA-submission: =?us-ascii?q?MDHs+nL2FTnKmaR6Wsfir5D4+t5+7YYqi1uS83?=
 =?us-ascii?q?wWmdhtTjd2CI09pAERK1zlDX64V6ggbxwFnXX1QgPz6aZDam179jc5pk?=
 =?us-ascii?q?3GrWSi+H5DyfjWzSbXMGgAO/S9qnz75bIp2YMNdRmHOFFh2SBUuZwspi?=
 =?us-ascii?q?2jX/cWun3jzkpRr5KXqT224g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 10:07:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647767274;
	bh=L5ugBzfkrS22BleE6EhJPUW2x/e74mgdBCCsO6kTfM8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=of0faSVoqyYzIlKaxJpJDFEt7szBTmbiNT6rse+a+zK1gU0/6lUh02zisIk3Ml/ld
	 PcaXCVuxmGNfyYO2UFVzKaGDZ01H7ixoKBBnIrNIT/mMdny1zA0RmpcDH9FlUtMNIz
	 VXa17gGeIKinq4emDYzzWal6vXFF5Ifg1nJsGuKk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.118.49]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1oB9Pu3FzH-017Hbt; Sun, 20
 Mar 2022 10:07:53 +0100
Message-ID: <a5d59d71-911d-832f-2af2-0754b83129c4@web.de>
Date: Sun, 20 Mar 2022 10:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
 <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
 <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
 <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
 <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
 <ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28@web.de>
 <alpine.DEB.2.22.394.2203200949540.2917@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203200949540.2917@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:g+mvq+bUZ4nGGrVU7BYgQ4b/d82JoA/IWEC+rm2POnalqCKV9T6
 uPk63PP8xBC7Hgr/sfKO5X6l0VezcFMQrpSHXM9A3UQK1+lW3XcFcBWJsP9qrMv6SvzN1f5
 bynQSs/XY+MvUO7bZEVWG0ieBNeN/np0UKu1wRGaRGM7Dy9u0aLH5PEwTVHSOak+cVMY6/H
 OYBVH6p+fyNhl6T2ZcRLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hyub3X0hLTE=:zkGevvw989HAvyBx2f+SnE
 Tlae31SlyV0wtyONqf8tnweUrpcpuaSCbaTPekybwpKgLjRI8ujm0+oiHozbvWuKTrxvK30ti
 YPtcObZN42HYs6hLDpphTXU2y8aXxN1469/AsUPOaR1xSyq47cc5Z2jANI2vbq6dXDz4yugOE
 0DTUKRRdXI96Pl3xH0dK8jLK30G0gYjWkqjWdtoc+4uXZxcnFqOcq3kgT1TIZRQDsVDqlDW1s
 2kCYyUFoCyu5W64GgaUIpcg3L7sPXrC1iAwG73cr553WrE4gTrVQ6MZbnieJRVxzdxt1KAHhG
 VmpgI9TUEOVzcKT0O33UdC0bd1nRF/wWxAWayZl2zT7iCTaSDMiq4z2VO6I7/h9MQin3mDJ0y
 FcTRCYOspKiroUfsuLalVBEm1f6zZyZ8dr4EPh+HMfqBCue05G21uXqfayjGWc3g4WMb0scJA
 tMsLpwLBK9GnYhz8S/4ZvfIvuc8Ou1mDyTLQey6QOPzNlytRPMJ5jttq2dRfunwIg5AbfAFNu
 dWjUDv5ulEutif0mck6mslS8gaej7dXwh6Zep+UuYprqU/ysrLg3I5qmAgQcsUT+MX5AO9Cz9
 ToOIjHrxG+0m57qY1LTKZXNqebKEESD69hOY2kIw5CApbMqccbm4Acx1tMxiUA5aeln19MNUx
 rRg+bk0T/4/LS9lx+QrDYsnsKS9oD7rCTJoHEr/0w6VoR5PLm9O0RocdTSuk8lGQqy/h5IDym
 fMqBqrv76PWwvW/qKRLMNwfqsnJUL8+2pK82XY7iHV451d5+lMXQBEhNatjpebo4ra+6uKPQ9
 K6p05EvGAIErHJMCt4KmON5+fAGVMGSvOlwbOSSY6TPd7HAmbtFfg/BSw1RsKlcRV4NMpc/YS
 Qj5J+rjYZn7OxiK23BFrtRAPonb5HabEoML6Cogw/eF6BieyB3TvCcVDEvcWqWOMPbaqz4qkp
 OUHu/5lm3Gp5Yxe5xymaFQUlxfZn/Z3aLhh75jRsJ9j6qzlX2i50rOgI+fC4j17o+taFtQ1rW
 QAQRLiaCvErazJ0gn4ZYxJFSLsYhtam4JupiegB2/r8eMJ0qQHk7al/ep41QAJHuONBT8UH5G
 yv/Smciow7pnRY=
Subject: Re: [cocci] Improved error handling for mixed SmPL data processing
 indicators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 262
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/a5d59d71-911d-832f-2af2-0754b83129c4%40web.de>

>> Would you like to achieve any improvements for the software documentation?
> Th documentation already says that * cannot be mixed with - and +.


This information is available.



> What more do you want?


I imagine that tweaks for text formatting and layout adjustments can help
to read corresponding data better.

Regards,
Markus

