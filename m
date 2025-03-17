Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BA6C35FF8
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=TgTal3Ikv1CmrmcdYVc08o/HDisYGkp9bIFPwUL8z8A=;
  b=PdxFDV0qU+y6OIyvh+Qxf0+4QQt9LvF6Jhf3IOyOVyMoAROkGP6dcySr
   7JZNO293LeYEjxBxkyjUOOQxuh9agArA98dZQ/zAKPL2wwndudLCATEfp
   1EsWu+BYFGn51S8sjbp2bkB0BSy+qBuJilhwk3SlLYJH4R7kZhhwMG59X
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213419804"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:12:37 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0CD23E0264; Tue, 18 Mar 2025 10:12:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 785ECE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 00:02:26 +0100 (CET)
IronPort-SDR: 67d8aa01_gZsZh12LZw8tqmIbjvazPDlrPTyaaRrFN5E88g2dCZmbVGL
 kE52JiCjbjWuKLyHVAfhYzVqDRlAQ/QD83Kq4NA==
X-IPAS-Result: =?us-ascii?q?A0EGAACeqNhnhVvBS5NaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgUIBAQEBAQELAYJDgVczBAtIjVKGVIIkkkyNRg8BA?=
 =?us-ascii?q?wENRAQBAQMEhQACix8CHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDO?=
 =?us-ascii?q?gYBATcBDwsYLlYGE4MCgmUDriKBNIEBggwBAQbcIIFlCYFIAYVsgmMBiWl6J?=
 =?us-ascii?q?xuCDYQ/PohYgi+CM4E7LoM+hjmDGIhWl25SexwDWSwBSwoTFwsHBTkoSEMDg?=
 =?us-ascii?q?Q8jgSIFNEE4ggtpSToCDQI1gggTXR+CKIIXgjeEPIMxgRCBZYNrghGBXQMDI?=
 =?us-ascii?q?gGCMG91HIMTgSs9hGQtUIFNHUADC209NxQbBqNKOoh1pRahBoQlgWOgMhOBO?=
 =?us-ascii?q?IIlAZNVkxEumFCpM4F9JIFcMxoIKAiDIk8DGQ+OIRmIdLVKIzU8AgcLAQEDC?=
 =?us-ascii?q?ZAcgUsBAQ?=
IronPort-PHdr: A9a23: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
 THZo5htrkugn+3JzSBoAkImlw==
IronPort-Data: A9a23:eO98VaL+nkcbCNpiFE+RL5ElxSXFcZb7ZxGr2PjKsXjdYENS02YDy
 GAaDW2FOfmCMDH0LdB/b4q2o0sEv5Hcx4NiQQEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb5s9JIGjhMsf/b80ow5KqaVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuLFHC5u9BVV8PDJw74u1VUT5h2
 eZAEWVYBvyDr7reLLOTTPhnwN8kMdPgMcUct2tmwDWfCuwpKXzBa/yWupkHgXFp15sITK+2i
 8kxMVKDaDzDbhBUElQaEpQzmKGvnHaXnzhw8QvM9fFrvTmCpOB3+LnMK8eEdvesf99Mrl6Dq
 2bC/ETEBx5PYbRzzhLeryry1rCW9c/hY6oWHaKx8vpCklyWzHYaThwQT1qy5/ej4ma1XNlUK
 mQP6y82pO4z8laqR5/zRXWFTGWsuA8XHcFXDvcx5UeOx7DS7gLfAXILJtJcVDA4nJAcaxkw+
 QaXpuL4JiRkku3KZl6Hro7B+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzojBLTvbdYjrdR2yY/
 tyakBXSkYn/miLi6klW1VbWiHS3oYXTRQNz5QjNWG+hqARja+ZJhrBEC3CFsZ6sz67DFjFtW
 UTofeDFvYji6rnRzESwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbZpeIGO4M
 RaN6VoJjHO2AJdMRfEuC25WI5p3pZUM6fy8B6+8gidmM8IoKlfvEN9GOR/AhwgBb3TAYYlkZ
 M/FIZn1ZZrrIal+0TuwRvdVyrIx2CE1yHibRJbwiXyaPUm2OhaopUM+GALWNIgRtfrUyC2Lq
 Iw3H5XRlH1ivBjWOXK/HXg7dgtSdSBT6FGfg5A/S9Nv1SI9QDF9VKCJnOx7E2Gn9owM/tr1E
 riGchcw4DLCabfvcG1ms1gyOO29boU1tn8hIy0nMHCh3nVpM87l774Se9FzNfMr/fBqh6w8B
 fQUWdSyMtIWQBT++hMZccbcqq5mf0+Vng6gBXeuTwU+WJ9CfDb33OHYUDHhzhRTMRrvh/AC+
 +Wh8ij5Xas8Qx9TCZeKSfC3kHK0k3svuMNzeErqOOtjWljez5d3IXfTiN42PMA+BhHRzRSK1
 wutIEk5pMuch6QX4dX2laS/gIPxKNRHH21eBDP9/5utECvnolqY3o5LVdiXcQDnVG/b/LuoY
 cNXxareNMIrsUlrsY0mNZpW1oM7usXSooFFwjReHHnka0qhDpViKCKk2ehNrqh8+a9LizCpW
 06g+shoBpvRAZnLSGUuHQsCaviP8do2mTOItPQ8Hxjc1R9NpbGCVR1fAgmIhCljN4BKCYICw
 9o6mcso+ge62wsLMNGHs3huzF6yDEc8CocpipJLJ7XQqFsP6kpDapniGCPJ8MmxS9FTAHILf
 B6QpoT/3op5+GSTUkAOBUDs3PVcj6sgoBpl7kEPDHXXl8vnhs0Y5gxw8zM2RAJRzDFB9fx/C
 kppBXYoP5e+3Spau9deVTuOHSBAGxyr1UjjwHQZlGDibheJV06cCEYfKOqy7EQi3GYERQdi/
 Zac0zzDQxvxWcPMghsJRk9ursL8QexL9gHtnN6tG+KHFcIYZQXJr7CPZ21SjTfaGuI02VP6o
 Nd18NZKaaHUMTAap4s5AdK40ZUSUBW1G3xQc8p+/a8mHXDuRx/q4GKgc3uOQ8JqI+DG1WSaC
 MY0f8JGaEmY5Ra09zseAfYBHq9wkPsX/+E9Q7LMJ1Mdkr6hvzFs4YPx9C//uTcReO9Qs/0Bc
 6HfSzHTNVarpypwu3TMp8x6KGaHcYE6RAnj7tuUrsQNNbw+6d9JT29j84GanXuvNClfwym1p
 yLGPq/f8Pxjw99jnqzqCaRyOD+3ItLSCsWN7AS4tolKZ/iSL8zLvAIxgXvkNjRwIrE+dYlWl
 7OMkdivx2LDnu88fF74kqm7NZtixJuNTtsMF/noPV9mnSemc+390SspomyXB8RAr4JA25OBW
 QC9VvqVSfcUfNVsnFtudClUFkcmOZTdN6vPi3u0kKWRN0I7zwfCEdKA8E3pZ0F9cgsjGcX3K
 i3wisaUyuFolqZ+Lz5aOKg+GL59GkHpZoU+fd6otTW4MHihsmnfhpTczygf+RP5IVjaNv3l4
 KD1ZAn0LzWzn6Dq8Ot3kaJPuj8vMXIsptVoI2w8/Yd6hQnvWSRCZa4YPI4dA55Zrj3q2duqL
 HvRZW8lEmPmUS4CbRz458/5UxyCAvAVfO30PSEt41jefhLe6Fls21e93nwID7ZKljrfICWPL
 8AVvGb3IwK6z9dqSPwV6/j9hv1orh8fKrTk5mil+/EewT5HaVnJ6JClNAlATyrKF4fKjkqjy
 a0dWzVfWE/iIaLuOZ8IRpOWcS31eBvswi8uYCPJx8zQ02leICus19WnU9zOPnY/gAjm6VLAq
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:W/L5wazwtSi6LNAAPEAAKrPwI71zdoMgy1knxilNoNJuE/Bws/
 re+8jztCWE7Ar5PUtMpTnuAsW9qB/nmqKdpLNhW4tKPzOW3VdATrsSjrcKqgeIc0aVygce79
 YDT0EUMr3N5DZB4/rH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3AP8Vu0WizJoiKpGsmD1KN3sx+pDJuLVfz6W3/elG?=
 =?us-ascii?q?BOHdKULa3GQC/1Lk8qp87?=
X-Talos-MUID: 9a23:QEWazgvOgtSUJSLdZ82nhRB5KZZkyIKUElk9iY4Lv82HFRF1NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,255,1736809200"; 
   d="scan'208";a="111834699"
X-MGA-submission: =?us-ascii?q?MDEB9tT5GhX3Yn2DM+kpKXYp8cdSib+fS3CzHs?=
 =?us-ascii?q?kOX0Y2Ya8oBePDzFxjoA8eqqhcFJjHXP+3gNJSVFwfHJH60lPgCjpx8W?=
 =?us-ascii?q?d+jwDihxV1dPvG9kBQgGdn7eO1YkX5mzqk1Ul/CRnMj90wD7XWqpIqqW?=
 =?us-ascii?q?J4B3+mrvP4pikTfsgR1eZlZA=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:02:25 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 664A9A48DF5;
	Mon, 17 Mar 2025 22:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A472CC4CEE9;
	Mon, 17 Mar 2025 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742252543;
	bh=6pJMWI920LhqZlTd6JHoqj9CoQeSAoxfTtTUrLE9gQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atF/eTr/oYmaBhzBu5zqiGBi5sXULtYCE4/2xEQpQqjvuBQSBfdzQ+F48cewaZB1G
	 sTq+PegHh0m9enwc3P21n7UxGEqcW61rm/4FgbtUDCdTXfNuzDjhnuDpItplafNBwE
	 aR8Zmqq5AqlyKcE6ZGhugJkAmn/ecBBzSMKZGT2EV+FLaaiH43kHBaXrMo7NkMCMJm
	 xFryesEgJfGFf8hqj7eszUBBgQk6nOGJgHjiaUCkVlNHJaoHJB7PHIzPBqAuMIkkuW
	 gTNTl+hY3BCfqyyz2FcSDm3X816n/TN4OdseFPzNg1DzhyIzyfBkXWVVfLtduq3elq
	 uZLhDxZIqhIOg==
Date: Mon, 17 Mar 2025 16:02:20 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503171601.9B8ECEA00@keescook>
References: <202503171135.B1CCC51FA@keescook>
 <26B3A647-3A45-425C-B758-6CC6DCEF5A6C@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26B3A647-3A45-425C-B758-6CC6DCEF5A6C@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2604
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503171601.9B8ECEA00%40keescook>

On Mon, Mar 17, 2025 at 09:59:55PM +0100, Julia Lawall wrote:
> > On 17 Mar 2025, at 19:44, Kees Cook <kees@kernel.org> wrote:
> > seem sane, but also didn't work). I have tried adding this line to my
> > standard.h:
> > #define __free(x) MACROANNOTATION
> 
> Try the above with an empty definition.

As in just:

#define __free(x)

?

Ah! Yes, that worked! Thank you!

-- 
Kees Cook
