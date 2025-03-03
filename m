Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC59C28B2E
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-post:list-owner:
   list-archive;
  bh=Zxarp5KPdUcjmXXFco+QJqaQqSZa3wQzbV1VxQVuFf4=;
  b=i4EvenEXU4U+Nxf5rBrlVz89AMlIho5PhGXZPj+ZRQ58I4DCek0b6alz
   h0TpbfHAqIQ4KVSf12oCv3mNCeDoy73bDGknAMwozItnrQgqcXlIFQe5c
   aKBCP0rxdL8RlnFLeiwg+9G45ZqScMxIH3bxpMaFSqSt9Fb8PXlU/0sRo
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (body hash did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211490669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 66B08E0D8F; Thu,  6 Mar 2025 10:08:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 192A7E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 18:59:18 +0100 (CET)
IronPort-SDR: 67c73f75_9Iwr80TvBwM8sJdwz6nVEuWi/NenKAdj/MXDW9QM+XEwwJd
 za7NhJ/tFDgb/JGa7JklVo+gvMIafxatAXR9ogA==
X-IPAS-Result: =?us-ascii?q?A0FWCQBVPsdndnUZS6A9HYEJgVOCRAEYAYFwBFOEVoh8h?=
 =?us-ascii?q?GGDZjCYOIVcgXcWAQMBCwEBLhQCBAEBAwSFAIsYAh4GBjAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAT4DS4V7DYI9JQGBJIEmAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBHQINfQEBAQEDAQIPER0BAQQzAQUBAgYBCxQBAwICHwcCAgMoCAEFA?=
 =?us-ascii?q?RwGEwUdgWF/gmUBAgMEomuBBUKKRHqBMoEBggwBAQYEBdwXgWUJFIEGLoVsg?=
 =?us-ascii?q?kkaAQVthGAZhHc2gVVEekKDAz6EQ4NbgmmEHAGDPZ8HiVZSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFRB1ISAOBDyMPgRQFNAo3OoILaUk6Ag0CNYIefIIragQFgSSCN4Q9hECFV?=
 =?us-ascii?q?IIRgV0DAxYPAYMfeRyEeYRwHUACAQttPRYhCQsbojc6g09zhAOSb4NRjnqgW?=
 =?us-ascii?q?DQHhB6BXQYMiQeWVwYTL4Nwk1UMkwUumE+jWoUtAgoHBhEjgSEjOoFcTTCDK?=
 =?us-ascii?q?k8DGQ+OWYhVw2B1PAIHAQoBAQMJhUMmE4ofAYFLAQE?=
IronPort-PHdr: A9a23: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
 jfI/IYGS7SOluiJwyBgFh1UpWQT7L8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wx7k3al2swOJldJyOeb1kL10VbvpDfPAimdD5ihNYBxZY6Wkfp
 +V7Y4mPE7P+U0ssS8b6Ki90cm7LB29hPkFmPhtTMuftcfdySCVxaVZnM/fKlrbamvDH49mpO
 Jdms1FeaPN5DdB/LDHCWWDYp8dKZy8geeVbM3lvjZQpesDUdAh0+4BMHfZLqQUfngFOXNaLu
 vQ2iMdnUvuRZ1/VK3SbRVrLouzxayv5faWB294dmkaAUu1/H+VAdXBYlKlN3klIntyKehLyw
 KlryXJooqkqO+y0RLR2iv+6J5MiML9xtYrPr39tuElbhvpziinDb4RKYFqfwpF091HKmxa4e
 Ukby1QSvhb2jfwQ13whBvnwAGl/AwQwxbZuASlqEqmgfHEABc7ANFIwa5iTTOcxFEnuLhHof
 h29lPcl6dqSTbBlz/0o/TzaDkvtmfcmwt7rccjy1xjbc86aLRLpcgyxnx8VLcGEyTg7Ig7EO
 9oZfusvcp+QBe7Ukycm2ll29Tpck4NNlO5SlUPocicyDo+pgEl82IogOwjojMl/JI5cZNN4O
 PJKeBTjblLZM4bZ6AVPpZcfeKHTkjEQRfNN2zXBFT8Ccg8SjzwQlfMkcEI2N0=
X-Talos-CUID: =?us-ascii?q?9a23=3AefdvDGrJmjPhuQAzgjvjSn/mUcADflLx7SiBGUS?=
 =?us-ascii?q?1LX5ZFPqcVGS+oooxxg=3D=3D?=
X-Talos-MUID: 9a23:QPbOUwY7rYMWEOBTrB+vrRpDNcZSyueOFlpWgKs2hs6PKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="211192964"
X-MGA-submission: =?us-ascii?q?MDHKhts8fXWFPAzXZzi67+UtvyANl0E2DbosjK?=
 =?us-ascii?q?kjDn72MGmQ4kETjlEo4XbqctdVLlnIwsaDSZL3U3ONhxgWwpBn5Ou3Z3?=
 =?us-ascii?q?D5QNxDH0wErTDGSViHxgiDakgKx84xspCAbG4xBvt5FAybZSvWdlQyUw?=
 =?us-ascii?q?xofkksULUbgdxxvrUdzSv5DA=3D=3D?=
Received: from beeline3.cc.itu.edu.tr ([160.75.25.117])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:59:17 +0100
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id BE49840D1F4C
	for <cocci@inria.fr>; Tue,  4 Mar 2025 20:59:16 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dbQ0hVpzFxD5
	for <cocci@inria.fr>; Tue,  4 Mar 2025 17:38:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 642DD42754; Tue,  4 Mar 2025 17:38:28 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541341-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2513F4340B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:08:55 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id AFAA22DCE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:08:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64ED3A30DA
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A31F2B83;
	Mon,  3 Mar 2025 10:08:40 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D61E9907
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:08:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996517; cv=none; b=hRMEqsxlyeyGn4b7RcZ0tGA4k8TUVVdcZ2WMalKj/a64t8uo2eJJg0fRFBuUCZcvZWf1q49n1oDsb8aZbEylqmKzkECmZ+ML4znzUDydmM3LXdYnXwlbb/e6aTDoRSYE7YVNB+2mPtv1hekgbSEi4B1Xxa41cDPPQf2X/I5dRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996517; c=relaxed/simple;
	bh=Fg0PMUf71HrKqLcTdAMEOyWnPDpROLGy0gLEnbMjfIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE68A+dSrZFvdNon7RALCblYlPsmyzPt9UPWHo4XfwY+Zh1Z6bJYse0ZAUebvuaZBdPOZae0MmkLVomkcy3/LJ2hwC4ffoEXyKiQpOvKWplKqPEaIzFKxyN5oj1H11w/3LLtmOwrOT7m0TdwyQk/WSnWroWTDFlx56K4S/EjpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFB/Uj9f; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso6653693a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740996514; x=1741601314; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=KFB/Uj9fe1HQqhfh294N7SmosO9Bl0Uyrom98f3vxF/vx2yjJcd49hG6tdxfHMWVU5
         avqx5k1KEL+cioBmDPZDYBcY3fHa4pqfLHTqesF5N+tRzDEN5JX+DTE19/F0dIaWX1Bg
         1apLKX1lxhh4vsZJ0nPSIE7BeSuddlTJevQ76g6uIZJSyTMov+O6lVpC5TOQ75pNhhaa
         Q5BrDlFuC64Tq1NRm66fkV5+HdF26K0hz8dvDIT/caMUDpQy0afbpNHjndM8L3T7ttob
         BP1kSbL4dqIG2CddQ94zMRKZ4LMkHJEZhsTWBAkJtm4atZJbn2yU9iM3UwEiDXaGiUn9
         MwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996514; x=1741601314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjBFcA67rMS7ZHAwLBuRWTDfKIm2qOaBa66RMYQiiBE=;
        b=D1ADz/XifIHYXS+QLQvWOjrB2tPSHf2/svdZsjpHecdn2vCJcC1Yy8vB/OtH9qXEj2
         WvIFUXAHN8E8Io0IY5l06qfTDKXoqujulDKV5greRlMC+jy2NpuGrTVyJ5PdVQDvqJkY
         3kJEXXNqDB9yOEXVhkh+oXiSqydm7sm/uIF1/Okpe5SH9gwe8WRWYSW5wP36TCdqhA3H
         QNQ9Z9nPvLBPQrUOFTrUYxhiYlucaO9pBzX2r8rIz4TCkD7KKq2iJ+l87l4GCnvjzIPA
         uZoB91rAq3tUNVnsPsLMR5AT8p21cNxVKIj0Vf0C6989AGtidGtSlTVbmJFq/Kz/0gbx
         GQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVXboMVG7Slv71+FvTvkwwvV+/twRTn4oYhErqDvCS/16c+h/gKZzmayM0esDRuOKK+3M7pQK7U2QzwGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtd9i4FdWL6h4z4cp++FKvV1UbEekOdhxpIcIXPfbOGOBvPAA
	m9Mp0Mlu1/nhE4K7ooKfrY4or0el5YrkVpFKnrtiuGFX1wKX0zAB5fQ5tCqX9h0=
X-Gm-Gg: ASbGncvAdOccs27mx67eZ7DO3UVvSmIJDw5b67YLwpRgbNfUWd2qlw6kCZe1yNz6xlE
	MSvW/VgsRmyLC96mZvcl6QKo3dAp5sYaSWm47qdBXNb6+HjKVZwgr1wuA7JFJrFWyp+lQ4D04xN
	e9D+6pqubexWIqYAwbzNIzYtNhDArmTdoeHYnTUCliO6Fd1stUio90lBqViqCxWVn0xrSnbvp1s
	Uu9Up4y70I6+YdxOaWXigcUR8+IufmgciiGoeq2Hiu/BkbH5150CZtmrx6rlMzWGtzg5nROexFp
	bQU+PGhcZijs1ZrVl2QIDtSQ+XWnisGwkX9BmugOcjJySxKmCg==
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
X-Mailing-List: linux-kernel@vger.kernel.org
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dbQ0hVpzFxD5
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715817.10164@H0xNmoaAp4A2YqRjDYFD4Q
X-ITU-MailScanner-SpamCheck: not spam
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] video: au1100fb: Move a variable
 assignment behind a null pointer check in au1100fb_setmode()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2552
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
Message-ID: <20250303100829.BHfVF4xIskPrMalIXcTsMPRlN8yUjcfutYpYFslJapM@z>

On Mon, Mar 03, 2025 at 10:19:06AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 13 Apr 2023 21:35:36 +0200
> >=20
> > The address of a data structure member was determined before
> > a corresponding null pointer check in the implementation of
> > the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
> >=20
> > Thus avoid the risk for undefined behaviour by moving the assignment
> > for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check=
