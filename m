Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE4C77B7F
	for <cocci@archiver.kernel.org>; Tue, 16 May 2023 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ugGZ0+AcIOuo/HAtpRBpxao7uXTu538oDGUS9TwKnp4=;
  b=SCUTErh3ftQ1pZ2/gYSEvtP5NzSq+mE9OJ6wB4Hd3vhqteQDHkdFXDlV
   3sMH1828f7FKzMvHDw6LY1IIc4M5vsUudoTbmSFsOtEqOIMSgdRcn1kre
   1B6wUkHgEiCpI9/WxZjy+bVAzJs7SorlaJ0tMhqAafBMPRcVvWphwqBB/
   0=;
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
X-IronPort-AV: E=Sophos;i="5.99,278,1677538800"; 
   d="scan'208";a="108341807"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 May 2023 18:40:45 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 71CEDE033A; Tue, 16 May 2023 18:40:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 16905E00A8
	for <cocci@sympa.inria.fr>; Tue, 16 May 2023 18:40:43 +0200 (CEST)
IronPort-SDR: 6463b20c_mpV374yEdi8PsWZWYSz+WVb3lAyoAjVnV3LmdIgIZxfaOoG
 C+EA6BOomJDxeXPFf2QYEZwJHCK7F5T9YqFMvsA==
X-IPAS-Result: =?us-ascii?q?A0F7AwCSsWNkfQQP49RaHgEBCxIMQIFEC4IueFMvBAtGh?=
 =?us-ascii?q?FKRCS4DhDOHL4dEiGqBVoFAPg8BAwENQQECBAEBAwSEfwKFWQIdBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABATsHDjeFaA2CNykBE?=
 =?us-ascii?q?WSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPwECAgEjHQEBERgOAQQLC?=
 =?us-ascii?q?xoCHwcCAlcGAQwGAgEBgnqCKAEDDiMHrjWBMoEBgggBAQacDR8sIlSBXgmBF?=
 =?us-ascii?q?C2NKoM3eicPgVVEgRUngwQ+hESDW4JnjyeLQoEwcoEjgSmBAgIJAhFngQ4IY?=
 =?us-ascii?q?oFzQAINZAsLbIE8WkOBaQICETQODBUFVQKBBBIBEwMHBAKBExAxBwQ3CxkJB?=
 =?us-ascii?q?gkdHRgtBl0HLyQJExVTB4FTJQQOAxkrHUACAQs7Oj01BgMLHwZCAiuBWgQvW?=
 =?us-ascii?q?nYKBgEkJJxzc4EIGYIrknaxMDUHgiyBWYFcDJ8UBhMvlxAOBpIqLpdaIKgOg?=
 =?us-ascii?q?WM6gVwzGiSDNk8DGQ+OIDeDb48JAT4/NDsCBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hxiLvKwn4yDc7f28ZrvoKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:x7fdXWHUIIPT2gntqmJn61AtHe49Tkf9jy/BInScGTdyb5iKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ATr6gZg3BL64tOwgdW/Hn1+nOAjUj7rqRCGwMi7E?=
 =?us-ascii?q?8gvKAMTB2FjKAtT2Pa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,278,1677538800"; 
   d="scan'208";a="108341806"
X-MGA-submission: =?us-ascii?q?MDGpqFUxKAy7lpZh+iLd2vwoxgaWQwb61eIkRM?=
 =?us-ascii?q?xH/sYvSk5jgEH0+TLYbjodIcqsABmQ3gbxyul8kWFMhK4YNuI1Epq7RD?=
 =?us-ascii?q?F1YZgaI0zhLIcJcdscX/+bf3Qsr6EIxDoxYSq/v2CWFa0H4ypkWGX2rY?=
 =?us-ascii?q?QFcM56c6mz9M5ScknDMC2pkw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684255229; i=markus.elfring@web.de;
	bh=ugGZ0+AcIOuo/HAtpRBpxao7uXTu538oDGUS9TwKnp4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mzYFy4ygsqmQ1+L78eMdev+pH3UCStf+7Q4aTNzILqloE0HP2XCf30FsbQ7YokQrz
	 zUebobHTuGHM9SVr3E2kP3Gh3MDQ3mbedVpdgI+cpkA62ZpxH/XcwGkSFe1MtAkKth
	 dq6CFLimjwUmrGgMm3upxbLA5HyFlSt6WlZs25L/XU6Ne2zvzoSj5zi55O7eWC8Cqi
	 ZbqSmcXrC/EJplNbYq0QM4REhl+XKbab815LECfqDRNSc6rLHUADnqVevP6MSbtJK8
	 lU0mtpZQE2D8N4e9F8508qtQxOMq/03il3/qBep/kLL5DKA4WyTJzDvSQbwzw+ZI4P
	 9f0LZgWwy532Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLijs-1phQq43FGy-00Hzei; Tue, 16
 May 2023 18:40:28 +0200
Message-ID: <591e4d84-ab96-a8db-09fb-968a630d606e@web.de>
Date: Tue, 16 May 2023 18:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
 <89048a5f-2dbb-012c-41f5-7c300e8415f5@web.de>
 <edf173d9-8b59-ecab-99d0-1063b51574a9@amd.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <edf173d9-8b59-ecab-99d0-1063b51574a9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EHvyR9sPQDdoSI8E24MjTjBHNE34IrFkXfakpw4cbttBrv/0NAc
 yMDhr+DbA/ZVFn0IZ7Lo4HeGvVILE+ExYeuzr25ctpzJQv1g+8EZVSsMvSF8kG7RQ/m8LgU
 fCYJwcbtQKSQUIr73PDMT/XE+kBc32CfSV0i+ig/doCjxTHUE8Tnux9ZNXdFLwhv6WcP9o9
 roETPDsP0WDGglxMRkqaQ==
UI-OutboundReport: notjunk:1;M01:P0:Zvzo7aMxB44=;7I9lorAPtcorqLfbaixEFqdnXOE
 alQy5LjJqBLLH6IPFEyZf7O6NjWoIkFTgALzBSWtSEb1SWXIsXvg257F26LV9QibgkCcWh+3f
 s+xYoOYTc0M4MCP9MzBur8wviENNM9IpGpORwQso/HMU3ZcdWtJbYosDmbGalsaunrp+19RoJ
 lKdrlwU920vOp7cb2A54kmj48rGr48fDbtOwyl1ijf8GwYylIWtk/iG7kzlYgvF+rbJBCN1Tf
 ZLParTtg+OaoU6gCiU1cWYCs0B5zP0ZyDH7SCWvVSw2KCApZtCkktPqALrsWqtkljGszM3jgg
 xl9BwDwX+enDYA4YDNGv1CA1ngWiDpJy9BouQcMf98VD84Q7bpwHsb28itOLcc4tAHZLtlEGc
 Vym54VSHHaZfs4q3/IhHrXyuy1pnoJMKeQduhF+ylStH5g8VoyX36Y4USzeud01TB9kI08mhz
 RCRrb+wlo5araoOSCd9El2NDrH6gSJYj6iw9b3GZZ54o3lVUru05N8xYVxHEUhOU9qK9NqXsq
 3sHgSGl1wq6/3ZnOro83wp7Ix2At49nMXRBuF3BT6yM1Snu7V6CWIRZlVDyXAAfXGIiiSRRsf
 4T+bwx55aN4Rfjo6LEhBL/9CK/KvrT5qm4qQpj39gIOtrtMDuj1n1To8tGxlFIjvh7pp5iaVw
 QIUyPv+lHrbxh0j412Qg5IEV3ebNttbOIMDfpt9PlUpp1LZAjucbB8T7/brZIxwioUV7bMOtd
 dxFi+CMM6stf6Z3Spg0LsPcfKyol3O2swCn5ephfuTDGHLE9mHdWVquRgR+HxSJJFuHL+9bUr
 Uj3pmotM+ZE3JG+pPx09fh/W9c1dc3/Xp36JLzmoWjzQui6pG2icwremJEpoCSG1rp74gmxk9
 4/a7ruL5i1lScPGZhIUkpEnbCLr9qA3gtZOFvjxa8UE55tEdgEsyRY7U/BDZmrIu5xvofPdXU
 bB7afA==
Subject: Re: [cocci] [PATCH 2/5] drm/amd/display: Move three variable
 assignments behind condition checks in trigger_hotplug()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1146
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/591e4d84-ab96-a8db-09fb-968a630d606e%40web.de>

>> The address of a data structure member was determined before
>> a corresponding null pointer check in the implementation of
>> the function =E2=80=9Ctrigger_hotplug=E2=80=9D.
>>
>> Thus avoid the risk for undefined behaviour by moving the assignment
>> for three local variables behind some condition checks.
>
> It might be that the NULL check doesn't make sense in the first place, b=
ut since I'm not an expert for this code I can't fully judge.

Will the source code and patch review evolve any more?


> On the other hand the patches clearly look like nice cleanups to me, so =
feel free to add an Acked-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om> to the series.

Will such a positive feedback trigger any further collateral evolution?

Regards,
Markus
