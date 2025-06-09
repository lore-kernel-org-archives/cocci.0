Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A131C71148
	for <cocci@archiver.kernel.org>; Thu, 12 Jun 2025 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OY3M9Ttv/bqT3V/rMDURFc7erzTk9vrnxrQJVMWX0JY=;
  b=KNYPaO2emzeneRGCWrptz3oqkkYXBJw0yGh88DstZXBTaK4j9Wxp90j1
   E6YQUmy6JjCpx40dI1PSfOBNFL98M+75tNhxlr+0ohvv9qG3dgkXiy50D
   5pOZSY/ffj8ktS6Ox//G1EwVuDEjgv1mVNV6Kbb6oyxiMeFt/r8UmVm6X
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; 
   d="scan'208";a="226895963"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2025 15:49:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFAF8E0CCE; Thu, 12 Jun 2025 15:49:25 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 64FEEE0131
	for <cocci@sympa.inria.fr>; Mon,  9 Jun 2025 21:22:03 +0200 (CEST)
IronPort-SDR: 6847345b_osNd1auKozOtTwmOmK/J7DQApIdZuzeZXyjRj7ZfJaGq9mq
 0LzZtGJ+mGUvmL1BvdDjU3QBCqQyg2uPmGzCvhQ==
X-IPAS-Result: =?us-ascii?q?A0ETAADqMkdojxGjxsBaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgVOCRIEAWTQEC0kEiCCFLIZVXQaBPgOYOoQHgxU9A?=
 =?us-ascii?q?g8BAwENNBoBAgQBAQMBA4Q6RgKLZAIeBwEENBMBAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DYJiATNxXgcJNwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQERAg1eAQEeAQEBAgEnEwYBATcBDws1EVYGARKDA?=
 =?us-ascii?q?gGCIQEGIiQDEQasQRqBL4EBM4EBggwBAQaBCFBB224DBoFJAYhPAYVsO4NCe?=
 =?us-ascii?q?icbfYEQgRQBgyo+gkoXAgIBiCGCKIEWhCSEK4URgl+QOlJ4HANZLAFVExcLB?=
 =?us-ascii?q?wWBIBAzAyAKNBQdAhQNDwESDwQWBS0dgg2CLU+CHR+Bc3BsAwMWEIIkgV4ch?=
 =?us-ascii?q?GKESStPgyKBA3xlQYNfHgZyDxtAAwttPTcGDhsGmQMagT6BZYEuGj8gECAwg?=
 =?us-ascii?q?T2TNpIenkiCRoQljB2VUDOqYS6HZZBxIotsgQ9qmzGBfyOBXHAVgyITPAMZD?=
 =?us-ascii?q?44hGSWDQoUTiioBqCY5MgIBOQIHCwEBAwmFRgEBiwOBSwEB?=
IronPort-PHdr: A9a23:CkXHCB0fIzoy8Tw/smDOzgsyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeEo600xw6XDM2bs6sC17GM9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4owjdrNUajZZtJqs1yxbEpmZDd+BKyW91P16ekBjx6tmq8JJ/7yhcvu8q+tJdX6n9Y6k3Q
 rtUASg8PWwy+MPlqwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WTK57
 6d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWXZNU8BMXCFaHIiyc
 5UAAPYAPeZAronyuV0OrQelBQKxAO/j0yJEimPq0aE/1ekqDAPI0xE6H98WvnrarMv7ObkPX
 +62wqnHwinMYO5U1jrm9IjEbgosre2QUb5sb8bcz1QkGQPfjlWXrIzoJzCV2foXs2id8eVgU
 f+ki3I5pAFqvjik290sio7SiYIS1lDP6CJ0wII2Jd2gU0N7YNikEIdOuCGeLYd5XsQiQ2Rxt
 Ss817YJtoK1cjIQx5Q72x7QdeaHc46Q7x/jVOicIDl1inxmdb++iRu8/0mtx/HyWMWpzltEo
 SVIn8TQu30TyhHe6NaKR+d98EmvxTqC2R7f5v1ZLE40lKfWLYMqzLA3lpoWq0vDHyn2lV35j
 K+XakUo4/Oo5PjiYrn8upCcMIp0hhnxMqQvhsy/Afk4PRMUU2eH/uS80aXv/U7nT7VQiP05j
 K3ZvIrdJcQBqa61GxNZ3ps55xa4FTem39IVlmQEIlJdYB+LkozkN0/ULPzlCfqygE6gnCpqy
 v3IJLHtH5fAI37em7r/ebZ99lVcyBYtwtBF+pxUC7AAL+zrV0PtstHTEwU3PBauw+n9DdVwz
 oMeVnyLAq+eKK7StFCI6fgqI+aWZY8VvCzxK/kj5/7yk3A5nUURcrWu3ZsScHy4H/JmLFuFY
 Xf0n9sMFXkGshAjQOHui1COSyNfane8Uq4m+z02CpqqDYLZSYCshLyB0j27HppTZm1eDlCME
 m/oep6FW/cKdCKdPMthniYYWrimTo8tzReuuxTixLp9MuXU4jEYtY7k1NVt+uHfjQsy+iBsD
 8SBz2GNSHl5kX8PRzAqwK9/oFdwykyD0Kh9m/xXD8Zf5/JPUgcgNJ7T1fZ2C97oWlGJQtDcb
 V+8Qci9SRw1QMgwxdBGN2N0Ada/lVbu2ySwArkav6OGDto4//SYl3H0K4NyxWbu0Kg6k0JgT
 NFCOGGrna1j8BCVAJTG1w2VjafveakC0Srl8GaY0XHIsltVXQJ9SqbZWmhZYVHZ6ZzQ4k7SB
 5OjFL8nPxEJnceGJ7tDbNHklxNKSeroONnES2u0lyG7AhPegvulaIf6M0UA2iqVXEEAnhBV/
 WuAOiA3AyvnqGXbWngmPE/1aknt9+V54Eu6Sks9zkneZlB73rC0/BISw+SdT/ca35oNvStno
 DJxShL19NLMCsGcpgNnNIbCZ9IyqANM1XjYrBB8N5rmLKdvgF8RWw1yswXl0BAhTs1smM4ro
 Xdi8gduNa+CmAdNfjWZ0JTYNLPILm209xD5L+b600/f3J6/+70L6flw/1zipgWoG0YK/HBu0
 t0T2HyZsNGCIA0XUJTwUQ4U/gNoqq7BYSh1s4/T0HxqMKrysTbZyd82H+gk4h+lc5FUN6bSU
 EfcGssVFcivYN43nBD9TB8eJvEUxrMzF8qje72N36v9eK5AlTe0hCxi6YBz1UWev358Q+va1
 tAAyvGW2QyVfz75gBGqtcWh3chkbCsIDyKAxC74AIdXauUmfY8RE3boPMCx2tF3gZLFUntUs
 lWkAgVCkO+kYwGfaRTCwEUE1UkNunGhiTD+0CFcmjQl6KGY2XqKi8Dvc1IjOyYfX3RklVrqL
 s6wjvgTWUTuZA8swl/twE/gxq8TgKV6KG/YQEpMey++e2RrSKq38L6DZslJ45IltSFQeO25b
 RaRTbur51Mg1C/5HmRZjAs6biynu4/w10hAj26HLXl06kHYYNx9xA3WzNXZSbha2T9QAGFCj
 jzeABCYPpH959KRnpGFtuGWXmetEJZUdH+vhbiBsSy97CVUDAGjkur7zsbmFA882Af12cZuU
 WPDrEC4KrL3xqC9N6pYd09nTAvn99t+HYc4jYI2i7kZ3HRcjZKQqz5PrWD2ef5bxKTxJC4GR
 T8Cw8XI6Q6j001+KH2hzof1EH6ax50lL+azc2UbkgY86YgeN66F6rECuSpzilO9oUTaZv0r2
 n8tyP0u9X9Su+gP8F4dzyOdH7FUJUBeFSXpm1KD6NXo/4tNY2P6crWq0kd61cysF63KuAZWX
 2qxLpMhBQdx6NlyNBTH13iludKsQ8XZcd9G7k7cqBzHleUAbctpzpLi5AJiMGP55zg+zvIjy
 AZp1te8tZSGLGNk+OS4BARZP3v7fZBb4Snj2IBZmMvexIWzBtN5ADxeWJjwZfOuDD8W8//gM
 lXGCyUy/0+SAqGXBgqD8AFjpnPLHYqsMiSTJ2ExzNN+SR3bL0ta00gPRDtvuJk/G0ixwdD5N
 kd04jdE/lnjth5F0f5lLTH6XW7arQasLDYyVJWbahFR62mu/m/zNsqTpqJ2FiBcpNi6qRCVb
 3acbEJOBH0IXUqNAxbiOKOv7J/O6brQAO32NPbIbbiUzI4WH/6V2ZKi1Jdn9DeQJ42OOHdlF
 fgyxktEWzhwBc3YnzwFTyFfmTjKaoaXoxK1+ys/qc7akryjXAH3zYqJF7ZWd95o/lH+gKuOM
 fKRmDcsMSxRhdsHwX7FzqRa3UZH0nA0MWD8QfJZ63WLFf2D/80fRwQWYC5yKsZSuqc13w0Xf
 NXelsuwzLlzyPg8F1ZCU1Xl3MCvf80DZW+nZzalTA6GMqqLITrTzoT5e6S5HPdUj/18thust
 DLdGEjmdGfLh3zyWhajPPsZxiWYJDRfvp2wdlBmDm2pH7eEIlWrddRwizMx27g9gHjHYHUdP
 TZLeERItrSM7Clcj52TAkR552F+ZamBkiedtazDL4oO9OFsCWJynv5b53Izz/1U6jtFTbp7g
 nmaotlrqlCg2u6Br1gvGB5Nsh5Kgp6GuQNpPqCR+pRbWHnC9Q4A9i3JWk5M/oo1TISx4OYJl
 ZDGj+rrJS1H8s7I8MdUHMXSJM+dcR9DeVLoFDPSEAoZXGuuPGDbiVZalaLa/XmUo54m75n0z
 cNfEPkCBQxzT61BTB06T7lgaN9tUzgpkKCWlpsN7Hu69lzKQdlC+4rAXbSUCOnuLzCQif9FY
 QEJyPX2N9d2VMWz1kp8Z119hImPFVDXWIUHpi55Rg4yvEhJtnN5Sydgk1KgcQ6r7HIJQLSwn
 QYeiw1ibOBr/zDpqQRSRBKCtG47l08/ns/giDaafWvqLau+aopRDjL9q0k7Np6oCxYwdwC5m
 lZocSvVX78ExaU1bnhl0UWP3PkHUe4ZV6BPZwUcgO2ad+l9m0oJsT2pnAdG/beXUMo40lJ7I
 dj18SkGg0U5MpZwLKjUbsKl13B2gaSD9m+t3+E1mkoFIloVtXmVc2gOsVAJMb8vI2yp+PZt4
 EqMgWkLfm9ETPcsrv9wkyF1c+2d0yLt1aJCIUGtJqSeKa2eoW3Jic+PRBs5yEoJk0BP+bU+3
 90kdgKYUEUmzb3ZEBpsV4KKMQZOc89b72TeZw6LvuzIyJNxeYS7Cu3sC+SJsedcg06pGhooA
 5VZ7skFGcrJsgmQJsPmIbgZjBQ1sV26fhPcXaQPIUzQ1m5Y8KTdhNdt0IJQJy8QGzB4OCSzv
 PPMoxMyxeCEV5Ewa2sbWY0NMjQ3Xte7kmhXpSclbnH/3+QHxQyF9zK5qD7XCWy2a9l7TPaSe
 R5oTtqx/H9slsr+wU6S6ZjYK2zgYJ56vcTT7OoBu5udI/ZbRLx0skOamo9ESnjsWGnKW43QR
 dC4e8wnatr6DWy/W1q0hmcuTsv/C92qK7CBnQDiQYs8WGiz2T8qMMa8EncfHQt9o6cI46cuP
 WXrhrI6ZwLls0I1MKnteG9wPf2vRXqgLX1dSPwNlI2H
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:+lrIMaGtpzCXmjG6pLqEKseALOsnbusQ8zAXPo5KOGRom+ij5r
 6TdZUgpGDJYVMqM03I9urwX5VoLUmsk6KdpLNhTItKPzOWxFdATrsSl7cKqgeIc0OOk5846U
 4jSdkCNDSaNykAsS+V2njAL/8QhPO83OSDg+DYw31xTQdsRZ1Bwm5CYGemO3wzbjNrQb4iGr
 ShxucvnVfBRZ1RVLXZOpACZYSt1r/2qK4=
X-Talos-CUID: 9a23:CNlxZ2GVoDBNikEIqmJDyEMPApwhdEeC0Vj5DEGFU1ZMVv6sHAo=
X-Talos-MUID: 9a23:yHlQYgTj6zuzJcGMRXTygjRMbOBn/Z2FEU4BqbQhlMm9DwxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,223,1744063200"; 
   d="scan'208";a="225928953"
X-MGA-submission: =?us-ascii?q?MDH7Jm7A/rEYcqdNAs5X2TBjCKHyOTAbhZkiGU?=
 =?us-ascii?q?9RBG6M4f7mnZjJ4dg9elgrkCA51p8jR39iE3XVYhe8R8q68HU0HM0ngH?=
 =?us-ascii?q?Vs7hweuXu3nA/wqTFWe4U3T9SNr0AUE0FVoHDn4rKk+bcC1NxAQLMCHM?=
 =?us-ascii?q?6I13FyCcUCme2AZF7Y81lqwg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.17])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749496923; x=1781032923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avDs50SYN/fcBfGKJ/LZzkZDnFCgRrOy6PXJSnNT1Tk=;
  b=iM9/XuQo+Wh3WFVe3SveD2/3xQGD3U08eQ2cMh64lPQift2G/XcCC0R3
   AVqzoo6dqzZzyyp/6D2rAqwrQnepZ1bFLMrT4++PJhHn4mo+9E/2/j7Jd
   XN2DTph59zfYyOREFJB0sx8XcduXU4iaFk3KM694qH0ck5FGk6hDcq1/s
   2aIEAt3AW2M2EUo5sORJSlcJKyXBwfL5Bbah9mGeErzyKQ8JTf3+nzCcL
   7XTHhDrVh+aAwayL+hBFW10Bdzf0WQlBkksGdE4InCmAnal61A8ecaJko
   2MYjzut8+34kxO3HoKZacxt+HIB7Va2H6Ajmv0HXlovd+v/I73sobuLap
   A==;
X-CSE-ConnectionGUID: CcU02kLtR/mgQJC2JXAwZw==
X-CSE-MsgGUID: QDqO33jiQk2JeMnwLoHp2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51498034"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51498034"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:21:59 -0700
X-CSE-ConnectionGUID: IdAq2zzKTtu+KujlTCwsIg==
X-CSE-MsgGUID: EN0HJMZxTW+bGxfUiXYFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="183784726"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jun 2025 12:21:53 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uOi46-0007LR-28;
	Mon, 09 Jun 2025 19:21:50 +0000
Date: Tue, 10 Jun 2025 03:21:00 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
	Stylon Wang <stylon.wang@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, cocci@inria.fr,
	Melissa Wen <mwen@igalia.com>
Message-ID: <202506100312.Ms4XgAzW-lkp@intel.com>
References: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: kernel test robot <lkp@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2768
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/202506100312.Ms4XgAzW-lkp%40intel.com>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250606]
[also build test ERROR on v6.16-rc1]
[cannot apply to drm-exynos/exynos-drm-next linus/master drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm/drm-next drm-misc/drm-misc-next v6.16-rc1 v6.15 v6.15-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/drm-amd-display-Fix-exception-handling-in-dm_validate_stream_and_context/20250609-151039
base:   next-20250606
patch link:    https://lore.kernel.org/r/da489521-7786-4716-8fb8-d79b3c08d93c%40web.de
patch subject: [PATCH v2] drm/amd/display: Fix exception handling in dm_validate_stream_and_context()
config: x86_64-buildonly-randconfig-005-20250609 (https://download.01.org/0day-ci/archive/20250610/202506100312.Ms4XgAzW-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250610/202506100312.Ms4XgAzW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7525:2: error: call to undeclared function 'dc_release_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    7525 |         dc_release_state(dc_state);
         |         ^
   1 error generated.


vim +/dc_release_state +7525 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

  7471	
  7472	static enum dc_status dm_validate_stream_and_context(struct dc *dc,
  7473							struct dc_stream_state *stream)
  7474	{
  7475		enum dc_status dc_result = DC_ERROR_UNEXPECTED;
  7476		struct dc_plane_state *dc_plane_state;
  7477		struct dc_state *dc_state;
  7478	
  7479		if (!stream)
  7480			return dc_result;
  7481	
  7482		dc_plane_state = dc_create_plane_state(dc);
  7483		if (!dc_plane_state)
  7484			return dc_result;
  7485	
  7486		dc_state = dc_state_create(dc, NULL);
  7487		if (!dc_state)
  7488			goto release_plane_state;
  7489	
  7490		/* populate stream to plane */
  7491		dc_plane_state->src_rect.height  = stream->src.height;
  7492		dc_plane_state->src_rect.width   = stream->src.width;
  7493		dc_plane_state->dst_rect.height  = stream->src.height;
  7494		dc_plane_state->dst_rect.width   = stream->src.width;
  7495		dc_plane_state->clip_rect.height = stream->src.height;
  7496		dc_plane_state->clip_rect.width  = stream->src.width;
  7497		dc_plane_state->plane_size.surface_pitch = ((stream->src.width + 255) / 256) * 256;
  7498		dc_plane_state->plane_size.surface_size.height = stream->src.height;
  7499		dc_plane_state->plane_size.surface_size.width  = stream->src.width;
  7500		dc_plane_state->plane_size.chroma_size.height  = stream->src.height;
  7501		dc_plane_state->plane_size.chroma_size.width   = stream->src.width;
  7502		dc_plane_state->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
  7503		dc_plane_state->tiling_info.gfx9.swizzle = DC_SW_UNKNOWN;
  7504		dc_plane_state->rotation = ROTATION_ANGLE_0;
  7505		dc_plane_state->is_tiling_rotated = false;
  7506		dc_plane_state->tiling_info.gfx8.array_mode = DC_ARRAY_LINEAR_GENERAL;
  7507	
  7508		dc_result = dc_validate_stream(dc, stream);
  7509		if (dc_result == DC_OK)
  7510			dc_result = dc_validate_plane(dc, dc_plane_state);
  7511	
  7512		if (dc_result == DC_OK)
  7513			dc_result = dc_state_add_stream(dc, dc_state, stream);
  7514	
  7515		if (dc_result == DC_OK && !dc_state_add_plane(
  7516							dc,
  7517							stream,
  7518							dc_plane_state,
  7519							dc_state))
  7520			dc_result = DC_FAIL_ATTACH_SURFACES;
  7521	
  7522		if (dc_result == DC_OK)
  7523			dc_result = dc_validate_global_state(dc, dc_state, DC_VALIDATE_MODE_ONLY);
  7524	
> 7525		dc_release_state(dc_state);
  7526	release_plane_state:
  7527		dc_plane_state_release(dc_plane_state);
  7528		return dc_result;
  7529	}
  7530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
