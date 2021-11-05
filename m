Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D3C433F5
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:55:05 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8EE611CE
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D8EE611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2254506"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:55:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0E52E006B; Fri,  5 Nov 2021 22:55:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 88810E004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:54:57 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=mcgrof@infradead.org; spf=None smtp.mailfrom=mcgrof@infradead.org; spf=None smtp.helo=postmaster@bombadil.infradead.org
IronPort-PHdr: =?us-ascii?q?A9a23=3AhWchHROC7qxFdfxcNTol6nZxChdPi9zP1u491JM?=
 =?us-ascii?q?rhvp0f7i5+Ny6ZQqDv6wr1AGCBN+Bo7Ic0qyK6fimATRBqb+681k6OKRWUBEEj?=
 =?us-ascii?q?chE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhR?=
 =?us-ascii?q?oLerpBIHSk9631+ev8JHPfglEnjWwba1vIBmssQnct8YajZZ8Jqov1xDFpmdEd?=
 =?us-ascii?q?/lMyW5nO16fgwzw6tus8JJm7i9dp+8v+8lcXKvgYq82V6ZYDDMoM2A04M3kqxz?=
 =?us-ascii?q?ORhaR63UfT2sbjANGDxDK4x/mUJjxtDD6tvdm1ymBIcL2V7E0Vi+84KptVRTll?=
 =?us-ascii?q?T0INz898GHQl8xwkKdWqw+vqhBj34LZZpyeOeFgda3BY9wVWWtBXt5QVyNfBIO?=
 =?us-ascii?q?8c5APBPcFMepBsoXxu0cCoR64CAKxBu3g1yVIi2f406M6zeovDALI3AIvEN0Sr?=
 =?us-ascii?q?Xvbrs71ObwOUeyp0KXE0SnPY+9I1Tr79YPGcgohofaJXb9od8TR1EgvFxjYhVi?=
 =?us-ascii?q?OqYzqJTaV2f8TvGiB6+pvT+Ovi2g6oAx2pzig2sgsipPOhoIb0V3E9jt2wJwzJ?=
 =?us-ascii?q?dKmTE53e9mkEIFftyyDMYZ9X8wtTX1ytikg1r0GpYC0fDIMyJk/2xPTdv2KfYa?=
 =?us-ascii?q?V7h7/VuucLzZ1iW9hdb+hmxu88Uutx+ziWsSo01tEoSVLnNbDuH0D2BLe6MyKR?=
 =?us-ascii?q?+Vg80qu2zuC1gbe4fxHL0AsjafXNposz70qmpYOv0nOHDX6lFvqgKOIbEko5+a?=
 =?us-ascii?q?l5urhb777vJGTLZV0hRv7Mqk2msywH+A4Mg8WUmeA/uS80abs8lfkT7VLiv06i?=
 =?us-ascii?q?KjZsJbUJcQBvKG2HhFa3Zw+5BqlCDemytsYkWEGLFJDZh2Hk5DkN0zKLf37F/u?=
 =?us-ascii?q?znlqhnTVxy/zYIrHtHI/BImXNnbrvZbp97lRTyAs3zdBR/ZJUDbQBLer2WkDtu?=
 =?us-ascii?q?9zYFBg5MwKvzubmDtV92JkeVniSDaCHKqzdrEWE5uU1I+mDfIMVoiryK+A55/7?=
 =?us-ascii?q?yin80gUMdfayz0psNdHC4H/JmLFuCbHvtg9cBFHwFvhAkQ+DwiV2CVyRTZ3eoU?=
 =?us-ascii?q?K4m6DE7EpqsDZ3fSYC1nLyBwCC7E4VKaWBBFl+DDXboep6fW/YMbSKSOtVuniY?=
 =?us-ascii?q?FVbinUY8h1AuhuBX0y7p9faLo/XgktZPuzsJkr8jajw0z8zFmR5Ch02CAVXtl2?=
 =?us-ascii?q?EYBXSM32q1tiU170FaKl6Zi1a92D9tWstdUUxxyHp7VyuZ3EdT7WwSJKtKCR0y?=
 =?us-ascii?q?hTP2lDCs3Q9Z3xMUBNRUuU+6+hwzOinL5S4QekKaGUdltqvq0N53ZJsBz0X/K2?=
 =?us-ascii?q?aAtyV48TZkXXYVJrq95+RLaC4PAnwOejan4Lcz0PQbH82KJxGaPuAdZVgBqWKn?=
 =?us-ascii?q?IVHxZYVHZ/4yR2w=3D=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3Amdu7MK4iPm3Drp2iKwHQgwxRtEHGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1TQDzTcbWziGOKyMMTCmL4pwYNy1pExSsJKEmtE3TAYd+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cZ3gqLeNZYH5JZSxLy7ZRbrFA2oDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeEoPSLfePAzIi3xYQaGujxFO4Cso3c7XNtJFOBcR0m7W2YopkpMU7sfYp?=
 =?us-ascii?q?QQBZsUgnMwYWBZCFC9WPKtI4rbLLHGz98uJwCUqdlO2magyURlvVWEf0rwsWTk?=
 =?us-ascii?q?Rq6VwxCo2RgyGjviqwbS2Yvttg845JY/qOpkeszdu11nxBvEtSpHrWLTP/dYe3?=
 =?us-ascii?q?TEqh8kIE+y2WiazQS43OUmGOgkWbw9RUIZkyb/u3yimIikD/QrT+L5otkHN6id?=
 =?us-ascii?q?09JTtFvvcXOCQY9EMxhPA4jrSl4jiKhsdMdaWxTuBtHOqiPXGkS7yVMQVDrLQy?=
 =?us-ascii?q?xKju3XLrkR7NfHcfQLTTTiFZk+CtxZ3IUsR8CMirKx09UqlVNDxUhS05nmesXb?=
 =?us-ascii?q?wnvI4//ISsGmwJmj8um51xVToihZAbtI8vcM7TDBs0UWG9z8sLVSDr5XNIU9wN?=
 =?us-ascii?q?d6oQfeaOC4bN2YOaCYICwwf7LEPZalbYg3nFr5eLUJ+sjE59fwcDdxHQOjSSoj?=
 =?us-ascii?q?/VfI26pg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApmOKfawM/BH63085grqFKrPwnr1zdoMgy1kn?=
 =?us-ascii?q?xilNoEpuA7SlfqeV/MjztCWUtN9/YhodcLy7UpVoa0mskaKdg7N8AV7SZmfbUQ?=
 =?us-ascii?q?KTRelfBO3ZrgEIcBeQygd179YaT4FOTPPxEH1zhoLC4BC1FtYmzJ2m/cmT9IDj?=
 =?us-ascii?q?5kYoYwF2Tqlqqz54EwqfEkp7ADJLCvMCZfyhz/sCiTq8XHwdKv26H3UBX+/O4+?=
 =?us-ascii?q?fXnI/7e3c9dmcawTjLozO0zbbwVyGC2BQTWS4n+8ZAzUH11yL4+4CquLWD0Rne?=
 =?us-ascii?q?22XPq7Ra8eGRqOdrNYijitUxIj6psx2vZ4hqRvm6tC01ydvfjWoXrA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AFAAD7poVhl4XKicZaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN2OzGEAYhphklTCgaBJBsGiw+ET4xSggcBAwENQQQ?=
 =?us-ascii?q?BAYdXAh0GBjAJDgECBBUBAQUBAQECAQMDBAETAQEBAQEBAQEJCRIGOiSFaA2CN?=
 =?us-ascii?q?SkBg2QBBToGAQE3AQ8BChgcEhAsGwaDBIJiJqp7gTOBAYIIAQEGh18JgToBjhw?=
 =?us-ascii?q?nHH2BEIFLgnQ+ikKQIqQ2nT2DQp8wg1oBo02QcIUgoQ2FH4FhghR9CIMkURkPj?=
 =?us-ascii?q?iA3iE+FaiQwOAIGCwEBAwmPbgEB?=
X-IPAS-Result: =?us-ascii?q?A0AFAAD7poVhl4XKicZaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN2OzGEAYhphklTCgaBJBsGiw+ET4xSggcBAwENQQQBAYdXAh0GBjAJD?=
 =?us-ascii?q?gECBBUBAQUBAQECAQMDBAETAQEBAQEBAQEJCRIGOiSFaA2CNSkBg2QBBToGAQE?=
 =?us-ascii?q?3AQ8BChgcEhAsGwaDBIJiJqp7gTOBAYIIAQEGh18JgToBjhwnHH2BEIFLgnQ+i?=
 =?us-ascii?q?kKQIqQ2nT2DQp8wg1oBo02QcIUgoQ2FH4FhghR9CIMkURkPjiA3iE+FaiQwOAI?=
 =?us-ascii?q?GCwEBAwmPbgEB?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2254501"
X-MGA-submission: =?us-ascii?q?MDHtMqrV8XDfie046RP9TQLG9p9549zovPPFNb?=
 =?us-ascii?q?TbFtPjrWYlvNQheqk9NeRsNlp/3rkf8in8AyfwX4d1XhwIEsmU7gbp4C?=
 =?us-ascii?q?YuYWuuFWd75pRRxS0D1Pt6nPL8JZwoQL7e1aF8GvxAGSiaSthq9C2so/?=
 =?us-ascii?q?3yPOJf1MWn+er68MGyY3hXbw=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:54:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FMPHLFSKT70nVIo21k5CHnEGHenayeVHtShhTMiPUaM=; b=nI0k45hgq1CuNxd4f7VYEbMUvt
	ayqT6pKyx8WY5HLjxQzmmyllmWI++jNw1wQVHnc8f1bG+H2W6Mn0kcrCTSs4i4GAKWlt9oFmg4+k5
	pyUdXpwxE4o71bl7zJUQQ8Af4P/027JO0DotCuNj4Zf58T/UdARQE0cw1mJAC7nN64+YiJhNxJK6x
	O7NJ/Tis4CMS31y719WP9isc+W1OUAl0R/GLjWrGy68aIunKi4vDdU/yFJ3+uwkV49f1as7cE1AsP
	8QBMSAUEx0GIxP9FZij6qL0jua/zGXtro0X/9ciKPU9PVpyY5i5wBIsBdCjNQIokIae9TYSTp5wYK
	53v+083g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mj7Ai-00CNLc-U9; Fri, 05 Nov 2021 21:54:52 +0000
Date: Fri, 5 Nov 2021 14:54:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thierry Martinez <Thierry.Martinez@inria.fr>
Cc: cocci@inria.fr
Message-ID: <YYWoLNfrBe2Gz6ls@bombadil.infradead.org>
References: <YXxGHEuS0zi+sbft@bombadil.infradead.org>
 <ow4bl2ys91a.fsf@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ow4bl2ys91a.fsf@inria.fr>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] Cannot infer Python version: when no /usr/bin/python
 symlink is found (resend)
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 83
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/YYWoLNfrBe2Gz6ls%40bombadil.infradead.org>

On Fri, Nov 05, 2021 at 08:21:37PM +0100, Thierry Martinez wrote:
> Luis Chamberlain:
> > Cannot infer Python version
> 
> I was not able to reproduce this error: are you sure that it is due to a
> missing /usr/bin/python symlink?

Odd, I can't reproduce now, but I was before.

  Luis
