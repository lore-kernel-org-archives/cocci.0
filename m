Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E2C282D6
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/nKPX6DIjshEMAUl1KOyqAjGkCUe+ICt9ye1bUSmbrI=;
  b=c7Wxp5ZTXOYe5LOet8PMwsViAoVNuRTZtWq0wBTcszL2s1PlhdL0hWHv
   NSq4sfe4BgtXWs3TLk3KbVEtJF2Fodg+lNOYR7vltb9RsJvtkefOWtdzV
   WhmH2V7L037kejRquWacrpwU2gCuN+FstKwsd6EierXk9lEGqkScZ8TSP
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070284"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2AA96E1745; Tue,  4 Mar 2025 10:58:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7B07DE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 07:16:36 +0100 (CET)
IronPort-SDR: 67c69ac3_dwLv1LJUFyweEKj7UGiBX2n/3D3TGB7mhNrRfn8ilYATeAC
 P1hY8LM4+qoz1AuBvDtfrL3UaIE0zVlPLv3Wgew==
X-IPAS-Result: =?us-ascii?q?A0FuAAB5mcZnfDHdVdE9HR0BAQEBCQESAQUFAUCBPwgBC?=
 =?us-ascii?q?wGCQ4FXMwRThFaIHYVAgXKBdC0DmDiFXIF+DwEDAQsBAUICBAEBAwSCDIJ0A?=
 =?us-ascii?q?osVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBI?=
 =?us-ascii?q?hkHDhIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAxIRDwENAQE3A?=
 =?us-ascii?q?Q8LDgYBAwICJgICMwEFARwGEyKBYX+CZQECB6IfgQVCikR6gTKBAYIMAQEG3?=
 =?us-ascii?q?CCBZQkJAQqBBi4BhWuCYwGKYicPgVVEgTwLgng+iB6CaYIzgWkBgz2aBY5WU?=
 =?us-ascii?q?nscA1ksAVUTFwsHBWFISAOBDyOBIwU0QTqCC2lJOgINAjWCHnyCK2oEBYEkg?=
 =?us-ascii?q?jeEPYRAhVSCEYFdAwMWDwGDH3kchHmEax1AAgELbT03CQsbojQ6g04BawhSK?=
 =?us-ascii?q?Cc4JoFsGJMMgzMBjnqBO58dNAeEHoFdBgyfXgYTL4QDjQiGOgyTBS6HZZBqq?=
 =?us-ascii?q?QcCCgcGESOBRDqBXE0wgypPAxkPjiGJDcNPQDU8AgcBCgEBAwmFQyYTiiCBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 BUxj1kmCdk=
IronPort-Data: A9a23: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
 b4biYdAD6B6F0H/YZcUhu8=
IronPort-HdrOrdr: A9a23:hBQBS6oytljNasgdmqkwCIUaV5rQeYIsimQD101hICG9vPbo8f
 xGuM5rqSMc7wxhJ03I+OrwRZVoJEm3yXcb2/h1AV7PZniDhILsFvAd0WKA+UybJ8SdzJ8k6U
 4IScEXY6yTMbE5t7eA3ODRKadC/DDtytHQuQ6x9QYLcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03KZ6jgvlV3BSQMrTPBc4tiv4yOEjVqiKXffLPX8aAcC17Q+V1A==
X-Talos-CUID: 9a23:wxVRBG9a+N5vjg1cYkuVv004K84fWGP29SaOHUGyNkpUC7LLEVDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AlvNQpQ4bU2DCC6VKR37uDG32xoxt+4byUW0NoK4?=
 =?us-ascii?q?UvoqnCHFNICu2lgqeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="110563663"
X-MGA-submission: =?us-ascii?q?MDFfTJtdy0XFAHK31SOb+ChkvaENC0bB5970y3?=
 =?us-ascii?q?816fVxhE/yScUaqSNaiNiImSATRr7BWuA8hvMBcdiFj27IvKzEj6TT+M?=
 =?us-ascii?q?ngb8WEehmMnEMc8PxRgsuFKgB513qRpAjzZi8CLAyuQRwIrnNvwgK5ul?=
 =?us-ascii?q?wFtjsJp0HW0L3edkqQGlVsrQ=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:16:36 +0100
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso6215592f8f.3
        for <cocci@inria.fr>; Mon, 03 Mar 2025 22:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741068995; x=1741673795; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/nKPX6DIjshEMAUl1KOyqAjGkCUe+ICt9ye1bUSmbrI=;
        b=oM4NrwA7Rgx5A3614u4JPKa7jlI9zYjd29NdQm8UqIR3zounj8lcKggKftrLW7DAGB
         wPvk/ZxIEOgyMfXHfYnDWofo2BEVl19dwTdk/NcFzUpgrmb3XsdNVl1GXz1UgUOEInPd
         dsT9pLaK58bnRawhBi1NQbplQbC/qlbZrGDYps3Df4AJhR3rAjzHC3YKRvPfto4yTuw5
         /i+QJtnT70XqWVoJPiKM8gH6aJ4h/Tt+tgR55OGKIZI0dq2xn67ANuE0vUPN5TP2QXGV
         67ZUHFqIhvZGr8x6gnuEhs8qKyO7CeAQncvQ7Hei4OO5MQxYkRs0+7nhmWQ19ZS45ECW
         eWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068995; x=1741673795;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nKPX6DIjshEMAUl1KOyqAjGkCUe+ICt9ye1bUSmbrI=;
        b=XV2Z+GIML8XwFwiBInj8JOVK1prWCuvUSLZGBnaMT/g6yiFRd9ChutMRC3z+D4guLa
         gSOk0fNFovMQWma/JenrqmP37gG3TFFVmGpW/gOKXr4buOL7jhp39Gos2uXvdLPY6rIW
         m2UdUE3117C8D2EZlwze3ZvQuIEBYuaDENeCVojQIYdu4buSD3FQYY4jaxZ1vMKISc2S
         y62qtWka/iqHVCapZllf0Vw9ky592yj+uX2Z9E2aaGy1TimJn+FTvjSymusCWfwDYXaC
         cR86xWFVbF+sqq4WfpxIzR4neOLxIE2N299zrFpxdIWEzHSmRg96CL0NBKK4yNhXirnI
         Fi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJTx0Q02A/PtYSNEsO3teFByIKVyFhpk2P1uJ2kwgFzKQVi1Y7502TGjAjwq7Lt7RQ2WAMgQ==@inria.fr
X-Gm-Message-State: AOJu0YzxwUHIQQZARsx7TCXYAfWm51iJE0WvfA/vmt2mLbuZd+y0E0GD
	QPZunary1hdQzn7HpRsH/thm/eFKpPyggevyA4TOggimVdgwyXmsPJUMAE5UjrQ=
X-Gm-Gg: ASbGncvYW1ozeEqO1YNC2kZty382JZP843rbjJvCmdnEiaMLPHwz2RrTu4xPjRwxJUl
	74s+jAvYsjzkqXqgwJjclu+L6XsDd0zhGEhqjTaLuVNZ4rZ5GFdFCLien0LNOgnLUO7PHV9Z43E
	/+Py+4gJGxI0QfleWha08gLrGTI8laGcRKqSrox6WKM/vdtTpGbimPwS3V85wgDI7Kh2WlT3sbu
	IHUYrYgC20mAJTLoANLxmKAnEXrPSSwUPzsV1f95hVt0O+7HWm2jB0B7zGMHWRLz8EcOHC3WTu5
	TCitkmzchOuPUCofd3oJOROQ0YJSimvDbfRXcOAXatMl3YStXQ==
X-Google-Smtp-Source: AGHT+IHGIpUcpblova9lskxdumW2y8lPrejnCbvxgbQgqTl6SZZm6j7C3FFjt6dcr0CvmsmXKYeMQQ==
X-Received: by 2002:a05:6000:186d:b0:391:13ef:1b35 with SMTP id ffacd0b85a97d-39113ef1da9mr2356446f8f.29.1741068994861;
        Mon, 03 Mar 2025 22:16:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm16819421f8f.14.2025.03.03.22.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:16:34 -0800 (PST)
Date: Tue, 4 Mar 2025 09:16:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>, Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>, Simona Vetter <simona@ffwll.ch>,
	cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Message-ID: <bd5220d3-e2f5-4688-919c-bd65f4a41eb2@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8f785de5-ebe2-edd9-2155-f440acacc643@web.de>
 <809905c6-73c0-75a6-1226-048d8cb8dfda@web.de>
 <684bfc0d-7e1d-40f1-b1b7-d6ed64fcd8b7@web.de>
 <Z8YF0kkYLlh1m5ys@pollux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8YF0kkYLlh1m5ys@pollux>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] drm/nouveau: Add a jump label in
 nouveau_gem_ioctl_pushbuf()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2521
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/bd5220d3-e2f5-4688-919c-bd65f4a41eb2%40stanley.mountain>

On Mon, Mar 03, 2025 at 08:41:06PM +0100, Danilo Krummrich wrote:
> On Mon, Mar 03, 2025 at 06:49:07PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 5 Apr 2023 18:38:54 +0200
> > 
> > The label “out_prevalid” was used to jump to another pointer check
> > despite of the detail in the implementation of the function
> > “nouveau_gem_ioctl_pushbuf” that it was determined already in one case
> > that the corresponding variable contained an error pointer
> > because of a failed call of the function “u_memcpya”.
> > 
> > Thus use an additional label.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 2be65641642e ("drm/nouveau: fix relocations applying logic and a double-free")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> I'm not entirely sure, but I remember that we had this discussion already.
> 
> Can you please send patches from the same address as indicated by your SoB?

This is not a bug fix so it shouldn't have a Fixes tag.

regards,
dan carpenter
