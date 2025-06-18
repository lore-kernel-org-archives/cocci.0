Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670B4C83027
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vep4PV2pZ+9tPEurvQr9lDJXe4H1SpULEo3WQUGiLXg=;
  b=Aa4kPBFQI/5Ep+W8IZE2jbdnBGQjs0p4hi/MmO5Bc7pCvPwg8/MtSlg4
   q/cxqsMQmITezpBwVCYAPAOoueZFu0M5wMFXOvUDb5wVGeuHgWx4YdMgj
   RJWgXnmkLNrtnP5QuJ6HBUgCtAMZ9OuJnNTlxCB77CJl0eO3yRjs+p/3e
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=permerror (signature expired) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229472127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 19:22:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4E15AE02E4; Sun, 29 Jun 2025 19:22:58 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 088B3E0131
	for <cocci@sympa.inria.fr>; Wed, 18 Jun 2025 20:19:06 +0200 (CEST)
IronPort-SDR: 68530319_17CqJ/PgB2EAaJajaHbuS/Xefe2OEwZfyQflj2lJ+q0L9w7
 Qnoz6KiXnnqJgbOTDX2i1/RY/8meFgAeMb3V4Lw==
X-IPAS-Result: =?us-ascii?q?A0EeAAA7AlNoeS7SVdFaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YFxUoEAWjMEVASEUYgchzSCIQOYOoVcgX0CDwEDAQsBAUQLAgQBAQMEggyCd?=
 =?us-ascii?q?AKLZwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SIgDjuFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQEDEhEPAQ0BATcBD?=
 =?us-ascii?q?wsOBgEDAgImAgIzAQUBHAYTIoJgAYIhAQZGAwEQogeBBUKKRHqBMoEBggwBA?=
 =?us-ascii?q?QbcI4FlAwYJAQqBBy4BhWyCZAGFbIR3Jw+BVUSBFSeDAz6EWINGgmmCKERSh?=
 =?us-ascii?q?WGTH1J4HANZLAFVExcLBwVbRUMDgQ8jDzwFLR2BLCZqgVAchD6ERStPgyKBf?=
 =?us-ascii?q?2VBg14RDQZwDwaBFUACAQttPTcJCxuTHoMnUmcgJlKBMpMOgzQBjwGBO50Qg?=
 =?us-ascii?q?hI0B4QegV4GDIotlTsGDwQvl0sMkwouh2WQcYwOgXmbCAIKBwcRJIFEOoFcT?=
 =?us-ascii?q?TCDKhM8AxkPjiE+iFWyR0A1AgE5AgcBCgEBAwmFQyYTii6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:Nb2H5KEHaez0K+B5pLqEE8eALOsnbusQ8zAXPo5KOHpom+ij5r
 yTdZMgpGDJYVcqKQwdcLW7UpVoLkmskKKdjbNhWYtKGTOWxldAT7sSl7cKoQeQYxEWn9Q1vc
 wQEZSWSueAdmSS5fyKgzVQeOxQueVvnprY4tv2/jNDSxp1Y7ps4wo8JgGQCV1uWQVKbKBUKL
 OsouRC4xSvEE54Ui15PBY4tir4yuEjWKiGXffOPX4a1DU=
X-Talos-CUID: =?us-ascii?q?9a23=3AEAa5zmjPrS7F6CxI0KmTelFMeTJuXXDkyFTQCUO?=
 =?us-ascii?q?DUmdDT76WQ1OLqP11jJ87?=
X-Talos-MUID: 9a23:JWVQPwreUlIZRZWIC+wezxtyJfhPurWQM1wEtIgbkfW9GghWJSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,246,1744063200"; 
   d="scan'208";a="227907704"
X-MGA-submission: =?us-ascii?q?MDEfir2HYZhLgTKRTxhCkfP695rnTRrCHyHtUq?=
 =?us-ascii?q?iEtGbdUbaTJ0EYoJseyxfKdYOIEPF92SUKE0JwmTs2dfk+GKQGPpij3z?=
 =?us-ascii?q?HDKEsl2hvD9aGcnPbH88mn6vKkxhAjNl7yqghILAiiGwTt5NhcW8xjt0?=
 =?us-ascii?q?C1gHoEmM/nc7UVVd8kDwl2Zg=3D=3D?=
Received: from mail-ot1-f46.google.com ([209.85.210.46])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 20:19:05 +0200
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c09f8369cso2308177a34.3
        for <cocci@inria.fr>; Wed, 18 Jun 2025 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750270743; x=1750875543; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vep4PV2pZ+9tPEurvQr9lDJXe4H1SpULEo3WQUGiLXg=;
        b=abie1s3GgoDG90QzPW8jI8mC89+2WVOCgKZfW1d2hKvooZFbyR/Ow4nbNZmMLGiVsN
         w7+sp+q8JTVsI4Rj81TOOFCibtRzufWmrFoubi4xh8Dy4TWhJfLlhY04P/ck9ID3MJ0i
         r2F/RNXQBmMs1o4kylRX4LOkAfy31GkALJxqXpBERqx36qgpp2a6J70s1gdOY4JFoHpn
         IQeXXcpG94l7C3JRkI5jGpEh9odIgUSLYjtewE9ZCWN+lm4hEnEVz0puAld6cMBxwSDM
         3PNwVr0qF3IDXwrG6x9IAedqsYtJvDElrcxuED8sqIbDd/kU1Qzft35/nJGTXfx15EwI
         W7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270743; x=1750875543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vep4PV2pZ+9tPEurvQr9lDJXe4H1SpULEo3WQUGiLXg=;
        b=JJtI/8BLV8iKj4rvqe/sIE5qKRBfiF/q29iMHdCPhIuvyxylsGXNS+6uezmEhi5JIz
         97k7LpuP9HElbKtlc3vZxCYOar7EmWuzvjxsRYLLAJL8weKl7Etv4q0+krrFrSiVzsBZ
         v9pHKZ7B1k8h9zWL8FUKK4uhf6+W00D99ied8hs4UMLeBwaG+9CQGbKcqBtx3q2DhfPC
         UB/ZLd3FhGXRsZyOXEH7OTxCr1Qvu2lD7qq4tCGPRImsPsde118a1a01jUTyB/EN9/oL
         QjxRk6Zzp3KspeKJGBqe6whU9ORIMZawRoEZ9d1AcEuZ3qS3a977Qu7AayWvQGxK1fmK
         Jvpg==
X-Forwarded-Encrypted: i=1; AJvYcCWPi0bo8L0UsJUoNq2AXfK8Y8mipXFdUveZ00wfvvrQ4INxAWaLKaTcW7jPHJsWnyuJoAHXcg==@inria.fr
X-Gm-Message-State: AOJu0Yxy9Qx4zLTD6jAPOvIM6NvlUheosNRU0XyOhkeNaHzRKvqY85dI
	OMdofvjKm6IJQS9Pk2proNdQy+nYTD+CYc2/DeAcuOsiz3sjDssG3GyWrdY27hnoJMk=
X-Gm-Gg: ASbGncvjcl0/PQzwgPMFoTp2FJIirqUczAOcwSiJnez2esVSXLVs5F/ler3WEi6gRJG
	MORigNkfnnusa4/oV2GxgpDdtGuAj22nIxP5utmYd89LYiO3Cm/rt4svUapMqQXvDg3BOLGiV7t
	sUQTLkV3Y9dVSGpdx/okD8bvjvHBBPj0hdgeAVX1bp1QWTeKKdCCp5WZX5ih8ESW+8M0SBJggam
	vkLeM5g4mZZjKsEbxBLnJC08P5FxRVT7oAua1osS+xE2aTCIDhwSMeH42cWivTleK38NGHiF/Y9
	H7iRFfKTCtxMEWqGkUW+foQ5ZEbKraToueoO6og6A8oUbvpDn54DX7ZkvOM26D5r+a1tCQ==
X-Google-Smtp-Source: AGHT+IFKnX0nztNeiuWkt0W77J0j5V4cIVncVTmr2DaNrpLni49egH0ASp6YufKpwNA2PVb7YBrY6Q==
X-Received: by 2002:a05:6830:6f42:b0:72c:320b:f827 with SMTP id 46e09a7af769-73a3626800cmr11319258a34.6.1750270743621;
        Wed, 18 Jun 2025 11:19:03 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1b3b:c162:aefa:da1b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a28403dc8sm2055669a34.27.2025.06.18.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:19:02 -0700 (PDT)
Date: Wed, 18 Jun 2025 21:19:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Melissa Wen <mwen@igalia.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
	Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev, cocci@inria.fr
Message-ID: <7ae66816-f682-45f1-b848-eeb5a57a68d9@suswa.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
 <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ebybqjohsoz7qhsenufkpkkw52w6tgikkbrzpegwotmefhnpn@m2cnzvsfai7v>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2815
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/7ae66816-f682-45f1-b848-eeb5a57a68d9%40suswa.mountain>

On Thu, Jun 12, 2025 at 11:08:10AM -0300, Melissa Wen wrote:
> On 06/10, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 10 Jun 2025 07:42:40 +0200
> > 
> > The label “cleanup” was used to jump to another pointer check despite of
> > the detail in the implementation of the function “dm_validate_stream_and_context”
> > that it was determined already that corresponding variables contained
> > still null pointers.
> > 
> > 1. Thus return directly if
> >    * a null pointer was passed for the function parameter “stream”
> >      or
> >    * a call of the function “dc_create_plane_state” failed.
> > 
> > 2. Use a more appropriate label instead.
> > 
> > 3. Delete two questionable checks.
> > 
> > 4. Omit extra initialisations (for the variables “dc_state” and “dc_plane_state”)
> >    which became unnecessary with this refactoring.
> > 
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> 
> Hi Markus,
> 
> Thanks for working on this improvement.
> Overall, LGTM. Some nits below.
> 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506100312.Ms4XgAzW-lkp@intel.com/
> 
> As the patch wasn't merged yet, don't add these two kernel-bot-related lines.
> 
> You only need to add these lines "If you fix the issue in a separate
> patch/commit (i.e. not just a new version of the same patch/commit)"
> 

If you're going to fold the fix into the original commit then it
doesn't matter what the commit message says since it will be gone
in the end either way.

regards,
dan carpenter

