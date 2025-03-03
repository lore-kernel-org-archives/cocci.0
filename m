Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6094FC282DE
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
  b=FqdQvioSNEqIbwbgaYmSns7Op/wZoIWVdhB0IAC7PcPM4EkpDX+04wDK
   9cRz0SnAzbZPW4a6516TBZoQ4xHAZjZOMlAAjGbUFGat/88FKNydhOMWr
   11Th+M5BOpSeDqvcw+eSDExIJHj+RCvzajdsGxccBzh2brD1Y2toIYd9I
   E=;
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
   d="scan'208";a="211069766"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CB4BDE0F2C; Tue,  4 Mar 2025 10:58:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A5935E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 11:08:49 +0100 (CET)
IronPort-SDR: 67c57fa2_SEpplS8MXwzc7DwVA8ZIK+RrATjKzIcdPwx/RjGeEBGVlwJ
 0uKplPODth/lUxzK8mN45UXsSEkxNJI229E/N+g==
X-IPAS-Result: =?us-ascii?q?A0EqBwB5f8VnfDXQVdE9HR4BAQsSDECBSAuCRIFXMwRTh?=
 =?us-ascii?q?FaNXYFygXQtA5g4hAaBVoF+DwEDAQsBAUICBAEBAwSCDIJ0AosVAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAxIRDwENAQE3AQ8LFAEDAgIfB?=
 =?us-ascii?q?wICMwEFARwGEyKBYX+CZQECB6IagQVCikR6gTKBAYIMAQEG3CCBZQkJAQqBB?=
 =?us-ascii?q?i6FbIJJGgEFbYRgGYR3Jw+BVUSBFSeDAz6IHoJpgjOBaQGDPZoFhQGJUlJ7H?=
 =?us-ascii?q?ANZLAFVExcLBwVhSEgDgQ8jD4EUBTQKNzqCC2lJOgINAjWCHnyCK2oEBYEkg?=
 =?us-ascii?q?jeEPYRAhVKCEYFdAwMWDwGDH3cchHyEah1AAgELbT03CQsbojE6g09zUiFmg?=
 =?us-ascii?q?hMXkm+DUY56oFg0B4QegV0GDJ9eBhMvl0UMkwUumE+jWoUtAgoHBhEjgUQ6g?=
 =?us-ascii?q?VxNMIMqTwMZD44hOIhVw1hANTwCBwEKAQEDCYVDJhOKIIFLAQE?=
IronPort-PHdr: A9a23:IU1MtR+/fCGLAP9uWUm1ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 gqHvb493QSYFazgqNt6yMPu8JrcEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/9pPNbwlSmDaxfbx+I
 RayoAjfssQdnJdvJLs2xhbVrXREfPhby3lvKVyPgRj3+92+/IRk8yReuvIh89BPXKDndKkmT
 rJWESorPXkt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RCii4
 qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXGZNQ9pdWzBEDo66c
 oABDfcOPfxAoofzp1UAswWzCxSvCuPhxTBHmmL506I43Ok6DQHL3xYtE84SvHjIrtj4MroZX
 +CvzKnPyDXOd/1Y1i376IPVbB0uu+uMXapufsrX1UkgCRnFhUiXpIP4JTyV0P4BvHSB4Op6T
 eKglWgnqx1vrTi13cosjojJhoQPxVDe8iV12oE1Jce3SENiZ9OvDZRfuT2AOYRsXsMiX39nu
 Dw8yrAetpO2fTUGxIkmyhPDdvCJfYeG7gzhWeuTITp1h29pda6hixus/katxePyWMeo3FtUo
 CdIlsTAu3MD2hHS5MaKSP1w9Vqi1zaXzw3f9P1ILEQumafYK5Mt2KA8moYQvEjZHiL7ll36g
 LKSe0gl4OSk9fjrb7f8qpOBNoJ5hRvyPrksl8G9B+kzLxYDX2yG+eSnyL3s41f5TqhLjvw3j
 KbUqIzWKMIGraCjGQBVyJws6xOnAjemztsYmX4HIUpAeB2djojpP0jCL+7lAvuimlisnjdmy
 v7cMr3uBZXNKXfDkLP/crpn90Fczw8zwche55JSFL4BPOr+VlHtuNHcFBM0MAy5z/z5BNlh1
 Y4SQ2KCD6GBPKPXq1CI5+YvI+eWZI8SvTbwM+Uq6OTojXMjhVASZ7Op3YMJZ3C+AvRpPV+Zb
 GHogtcAF2cFpBA+TOvwhF2FSz5TaG6+X6Qn6T4jEoKpEZ/DRpyxgLyGxCq3A4VaZnpaBVCUD
 Xfoa4KEVu8QZyKVPsBujj0EWKO6S44h0BGurBX1x6BmLurS4C0YtIjs2MJ75+3JxlkO8mlJE
 MnV8GWATmd520CWQT45lPRi5095x1aF3O17hPFeFNN77fpYVgYwL5OaxOt/XYPcQAXEK/uAT
 h6NS8++DDctQ8h5l9MHZQB2Es+6gxbf0jCCB74TnqaMQpsu/fSPjDDKO89hxiOeh+EahF48T
 54KbDX+7kYe3w3aBoqT1l6ci77vb6MXmijE6GaEy2OK+kBeSg95F6vfDjgEfkWDi9P/6wvZS
 qO2T6w9O15NwMjEIaJQctDvkVhcbPPiPt3EZCS2gWjjTQ2QyOa0ZZHxM34YwD2bDUEFlw4J+
 nPTOQE4QCyouXrTCiBjD3rrYkXl6+44r2m0HQcv1w/fSUpn2vKu/wINw/yRT/RGxrUfpCIos
 Cl5Bn641tPSTteM/k9vIf4abtQ671NKk2nesmSRJ7SGKKZvzh4begVz5Qb10glvT59Hmo4sp
 W8rywx7LeSZ1klAfnWWx8K4PLqfMWT08B21DsyekljDzNab/LsO4/Ukuh3iug+uDE8r73Rg1
 ZFczXKd4pzACAdaX4j2Vw478B1zpreSZSdYhcuc2XRqd6K9qCfP3c4kHsMhyxCpZdAZN7mLV
 UfzH8AcG8myObkygVH6C3BMdOtW9aMyI4anb67cgP/tbLsmxmr2yzkcs+UfmgqW+iFxS/DFx
 cMAyvCchE6cUivkyU2muYbxkJxFYjcbGiy+zzLlDchffP4XH85DBGGwLsmw3tg7iYTqXisS+
 FelQVgPwtekfwafdXT53AtZz0NRpmao03jdrXQ8g3Qyo6yT0TabiejrclwMM3RTSW9+gE3EJ
 YmyhsodGk+yYEJ68XntrVa/zK9dqqNlKmDVSkodZCn6IVZpVa6ov6aDacpCgH8xmR1eS//0I
 VWTS7qn5gAfzzumBWxVgjYyazCtvJz92R18kmOUanhp/jLVfsR5xBGX49K5J7YZ0jMAAiJxk
 yHaAESxJfGt/NOdjZCFtfqxH26sTZxcdyD3wJjI7nPqoz03R0fnz7buwZXuCm1YmWfj2sNvV
 DnUoRq0eYTt26mgcKpmckRuGF7g+p9/E4B6nJE3gcJY0nwbi5OJuHsfxD2rYJMLhOSkNCpLG
 GVYprydqBLo00BiMH+TkofwV3HHh9Bke8H/eGQdnCQ088FNDq6Qqr1Chyp85FSi/mezKbBwm
 CkQzfw25TsUmeYM7UAhxyPbCbkIBUReISH2vxCJ6dmkq+NQfmnlIt3SnAJu2MusCr2PuFQWV
 H//PJwrBzd96NlyKnrI0Xv68Iaif8PfJ4F21FXcg1LLiO5bL4g0n/wBiH98OG7zinYizvYyk
 R1k2Zzp9JjCMWhm+7i1RwJJLjCgLd1G4Snj1OwN+6Tel5DqBJhqHS8HGYflXe79WixHruzpb
 k6PCGFu8SrdQOuHW1XDtwE+6CiTW5GzayPJeD9Dlo4kHUfFYhQY2VFxPn1yn4ZlRF70gpW5K
 gEhoGhWvAawqwMQmLw2cUOjAyGP/EHwLW1sAJmHcEgJtEcbuwGMYJbYtqUqT0Q6ttWgtFDfd
 TDdPl4VSzlPAgvdWRjiJuX8vIGQtbHHWazuaaOJO+zGqPQCBa7XntT2g9cgp3DUcZzRWxsqR
 /wjhhgZBSE/S5mfwm9fDXRQzn2FbtbH9k3lpGsq/obmoa6tAEW2tMOOE+cAa4wxvUrt0OHYb
 ajIw38oTFQQnoUFwXuCoFQG9HgVjSwmNzykELBa8DXIULqVgKhcSRgSdyJ0MsJMqaM6xAhEf
 8DB2Jvz0fZjg/g5Bk0gNxSpk9y1ZcEMP2C2NU/WTEeNOrOcIDTXwsbxKaqiQLxUhe9QulW+o
 zGeW0PkOz2CkXHuWXXNealUizqHORVFpIynWhNkCGymQd6/LxPma5l4ijo5xbByjXTPdCYdP
 TV6b0JRv+iQ4Cdf0ZAdUyRK6ntoK/XBmj7MtbGJbMZL96EzUmIpzLE/gjxy0bZe4SBaSeYgn
 SLTqoQruFS6iqyVzTEhVhNSqzFNjYbNvEN4OKyf+IMTPBSMtB8L82iUDAwH4tV/Ddi68axZz
 J7EnbjrJTFe/sj8+coaDtLTbsWdPzByVHihUC6RFwYDQTOxYCvHgFdBlfiJ6nCPhp0zq5ypl
 ZZXD7EGDxo6EfQVDkkjF9sHasQSPHtsgfuQi8gG4mC7pR/aSZBBv5zJYfmVBO3mNDeTibQsj
 /ogxLr5KcEeOtS+1RE5LFZ9m4vOFgzbWtUf+kWJgScwoUNE6n84SXc8iRuNguaF5H4VHOSz2
 BkshVkmCdk=
IronPort-Data: A9a23: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
 J88e4dBD616FJDeVWvFdu/FWZNJNM8=
IronPort-HdrOrdr: A9a23:rlrw16iYPiUCT27p5xkiz09Xd3BQXiEji2hC6mlwRA09TyVXrb
 HJoB0+726JtN93YgBepTngAtj8fZq4z/RICOYqTNKftWXdyQ+VxcRZnPXfKl7balfDH4xmpN
 9dmsFFYbWafDpHZITBkXKF+r4bsbq6GcuT9J7jJhlWPGZXQpAlwAFjFA6BH0F6ACVAD4EoDY
 eR66N8ywaISDA4aoCUCBA+MdQrZOelqHslW3M77tIciTVmRAnJ1ILH
X-Talos-CUID: =?us-ascii?q?9a23=3AF4c8B2gNGi6yTc5xJkM+hp6IpzJuTlbNx1DceUO?=
 =?us-ascii?q?ECWtnV5iQTlWb9ZpbjJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AsyLNTg1sm7PRPzV72MA0qh61CzUj8YmtJmkGlqc?=
 =?us-ascii?q?8loqeFhxWNyuRtASXe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="210832068"
X-MGA-submission: =?us-ascii?q?MDEbC/0PCwTShUQk4pQ/5UvN1lP7crKouizCZQ?=
 =?us-ascii?q?IZM7u7sLj9q6UwpI8Qm5e1yWKMWbvfX1OdwgyZ8gEQhajKs7r4jjpK56?=
 =?us-ascii?q?klGMU1Tr6ZztokoXNn6bLqf1c8kqF87JY6bRmeJGcD1oBpUviQQ5xF13?=
 =?us-ascii?q?/P+0fq09GyDi90bhROeGmANA=3D=3D?=
Received: from mail-ed1-f53.google.com ([209.85.208.53])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:08:35 +0100
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso4380567a12.0
        for <cocci@inria.fr>; Mon, 03 Mar 2025 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996514; x=1741601314; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=SjdNP/wAcD76kPnv2ouCJfvPfhDncfNIySN6H+wlxk1NbAUNIgTP4roV0jTDf46sfq
         a+SSgwLnod+pPH+OGa+o6Gv6IGeYRmtmuvY/NUz67DmcaCnkoPCPqCuJ1dtvChglZ9JK
         AJfzd4D6b1L1p0oM7GtKZE3DHUmCEhEvsyuA10IrCRBEwJOxQmLub9spceWAyzG2O6aP
         67fvEhi1F9FD7VHlwcmOnL4gMxh3mTgN/g55Wccbg5KeuKVnOExkmcWWGV06q88tKuKC
         YgKGCGoBvblomTwDWK022FJxUepc20xQCpfBhnwHAcCol3xPNhsOb/Lgs9y4uOfMYHL+
         7kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996514; x=1741601314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=S9oTeVAPsHxycJJ4DvA3jFX7IU9j96UYyBDDYK2kWLyQazCdxmEl4glueBjahdEeqG
         CnguwFbUV6J3MIyx8DTdpFu4FEhE+Bed0iaDtIONRQo39K6KX7mm1TEgpODbY5IVLAvZ
         75TaxLwaucMO5ZOQ77zRXKE4Yju6MkyVF9ciKN5NKMPKhg+bVYM7u9SiDYz0y4HFpt4/
         8gYMwM7Rf3tvfREV0zmvz7Uxo2zC8l9E0AH5agkunT4dCQ+ynpdtPEIvsXBFdt/kRwIo
         VRlh9+3PgRg6WnJIM8633lcpmC6k5YBwKchiEoLKkGrHVNJFyO9hGefHsV/Em72bMcpd
         HRUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBB+PYPw9g3MVY6UTua0XiWhBdu0M2l7xFUB8P2IiXq+Gr3wb4JW7aLW7GFoT1q7wlWPZVug==@inria.fr
X-Gm-Message-State: AOJu0YyDqUCNz9CXVN1E819hTN+BOtvFMrL/FZ9STDPGIUOgmkALSxF/
	cJfgwaBF4S07lgFByLWsQDBXs16NWzsvrszPCMyeUuVnmBy3EiGEctNFaMMjJ7w=
X-Gm-Gg: ASbGncsj4LoIayxB1hGu6ggKfoOvl+t+mGTqemxyxDZioy6xt22hDcYr0SNgn2/4k0g
	jsQ9BEf8WNEltTeBVLpSQ5nPwRkMpZCEFjmnDIJAtFAYbmQQxGdEus1Me3pztOc9lmRcaiWzs7A
	NVJqXYcE55veQ9V3eYh9ZOUptRRdP6snfpmgtsmJoRftpXZ8OKthlbfjIGojCMGjUW7kjgF0LQH
	JfxJxfD9USOqfeUw0wGREY/wLjwCx4eu+9W8nv1dfbp8qhEy33p8nwqQn0SgIF/agHR58JG1Pc7
	Gvg4bxd1PBm8LQDfiJOlHdCuDRO2CXSeGi7p5xODOZH9222rYA==
X-Google-Smtp-Source: AGHT+IEPxlHoiKz/rey+mSNj9p6SHZuD3oFGIyaUPKEFRRWxafVAlE/vcmhJEnz4DfJOlevycDZ6wA==
X-Received: by 2002:a05:6402:274a:b0:5e4:c235:de10 with SMTP id 4fb4d7f45d1cf-5e4d6b7b21fmr11376850a12.32.1740996514382;
        Mon, 03 Mar 2025 02:08:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b6cfd0sm6648394a12.28.2025.03.03.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:08:34 -0800 (PST)
Date: Mon, 3 Mar 2025 13:08:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2508
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f%40stanley.mountain>

On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 13 Apr 2023 21:35:36 +0200
> > 
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the function “au1100fb_setmode”.
> > 
> > Thus avoid the risk for undefined behaviour by moving the assignment
> > for the variable “info” behind the null pointer check.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Should also get
> 
> Cc: stable@vger.kernel.org
> 
> to ensure this is backported to stable.

It's not a bugfix, it's a cleanup.  That's not a dereference, it's
just pointer math.  It shouldn't have a Fixes tag.

Real bugs where we dereference a pointer and then check for NULL don't
last long in the kernel.  Most of the stuff Markus is sending is false
positives like this.

regards,
dan carpenter

