Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26127C48BF2
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0hDV144BFjsd9eBmeIR68UbZ9/AgjyHKPCmhViDvmjs=;
  b=OLlSv3py7VZ48jhYkQn7R6utOKiSNLCTK29lfM2KLX6hld3ulFgiSO26
   flu23hUnuuw3lW7l2d1hmIvW9frrXf5Pm1ZSbenXB8n5IX5atodYM7yE2
   jEaGAdfLF5PQd6NKZBJneI4ubwrRM+P+J6wIjz09VCkmJSZOpBiCS6DfE
   o=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152260665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 09:56:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A10A1E0CFB; Fri, 16 Feb 2024 09:56:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 89661E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 20:44:56 +0100 (CET)
IronPort-SDR: 65ce69b7_yfJHFajsoG1HYIc5DGf5OjmaBUk/zZlcRvzLMMvivUgVB4p
 6mYiNdb+KpwLOUtl9INZkP+weVexbX8oNsE1lWA==
X-IPAS-Result: =?us-ascii?q?A0GSAwDPaM5lf7DSVdFagQmBT4I5gVIyBFOUF4IlkkSNQ?=
 =?us-ascii?q?A8BAwEMAUQEAQEDBIR/AodbAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBIhkHDg4phWwNglwBgR6BJgEBAQEBAQEBAQEBAR0CD?=
 =?us-ascii?q?XwBAQEDEigGAQE3AQ8LDgocEjMBBQEcBjWFPgOmP4EFQos5gTSBAYIKAQEGs?=
 =?us-ascii?q?R6BYQkJAQqBNIgmAYkxeicbgUlEhD8+iFeCL4IWgzuZYlR/HQOBBQRcDRsQH?=
 =?us-ascii?q?jcREBMNAwhuHQIRIjoDBQMEMgoSDAsfBRJCA0MGSQsDAhoFAwMEgTAFDRoCE?=
 =?us-ascii?q?BoGDCgDAxJJAhAUAxsdAwMGAwoxMFVBDFADTRcfMgk8DwwaAhsbDSQjAixAA?=
 =?us-ascii?q?wkKEAIWAx0WBDIRCQsHHwMqBjkCEgwGBgZdIxYJBCUDCAQDVAMhdBEDBAoDE?=
 =?us-ascii?q?wcLBzo+gVE4gT0EE0QDEIE0hTiEbwyBKwNEHUADC209NRQbBqISgQ+CXaUFo?=
 =?us-ascii?q?GSEG4FhDKAAE4Nfkz6Scy6YKqhOAgoHBhAjgVckgVwzGggoCIMiTwMZD5cui?=
 =?us-ascii?q?wYiNTsCBwsBAQMJiSKBRgEB?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
 b0biodND62rNqQvhJYU
IronPort-HdrOrdr: A9a23:awH23aBj5P5NGzTlHelk55DYdb4zR+YMi2TDGXoBLiC9Vvbo6v
 xG/c5rryMc7Qx6ZJhOo6HjBEDtewK4yXcx2/hsAV7AZnichILLFvAa0WKK+VSJcFycygce79
 YZT0EXMr3N5DNB/KDHCWeDYrId6ejC36aym+/EwnthCS1sYbpx9hp0B2+gfnGehzMoOXP6Lv
 ehDwZ8yQZIsE53UviG
X-Talos-CUID: =?us-ascii?q?9a23=3Aymz1cGgZvHZp0yqnpQKgwjh8tTJuIm3v92fIHle?=
 =?us-ascii?q?CSmNiSIGsdAK0459eup87?=
X-Talos-MUID: 9a23:OE8+CQa5FeBVLuBTkmTChG9JGNVU/KWnFh0TnoQd4fa4Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,162,1705359600"; 
   d="scan'208";a="79768904"
X-MGA-submission: =?us-ascii?q?MDEvQFhAQq8dO0P3IG9NcgOwDlF7cst/rSf5o9?=
 =?us-ascii?q?Copkw5Jgl/l58+q5K/9DsObUx7RPMQ3JW91K5jURzdEpi88j9q8zlJgd?=
 =?us-ascii?q?xQqvRpKsafXL09NcQu0FZjstDEXhew1rsmzNB94vb0lwD1rWX71g7ulN?=
 =?us-ascii?q?jaUSfGSFuLn85yj4TnJ59eyg=3D=3D?=
Received: from mail-pf1-f176.google.com ([209.85.210.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:44:55 +0100
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so1018162b3a.2
        for <cocci@inria.fr>; Thu, 15 Feb 2024 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708026293; x=1708631093; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hDV144BFjsd9eBmeIR68UbZ9/AgjyHKPCmhViDvmjs=;
        b=A7plzctOiBgGzO+WBR8xR4K1aLTFobQnHVr+7Z5+PU0EkFFJkolAS1ZG3AlMBpOqK6
         mz/jBVhc3D/flTO72P3yhV9JB28d18iuXhFxH0iiWJjUoiFBMV5p/nYirKZFrqMZBndQ
         FnDcpgUelmq+5Mj3ip//dpXBi/VdpfrsaoEIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026293; x=1708631093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hDV144BFjsd9eBmeIR68UbZ9/AgjyHKPCmhViDvmjs=;
        b=shuulYnhRgQPJYenY4/DrHZSk2mh0fFMQ6XOUJK83mSnt38yJiD5kU7xk/w0KWIiAi
         +mt3v/FqDTNhyzCe8AG0JHc5f0YLL09YdKT1ixGd8Ge9oPRQdvZo9Q+rM78cypjqMSeA
         ZfeqM8w1ouL5C9LFcqqAQqF1s6dis2Zi/jFYjunBjQQhgsGCJB63MpOwKB4Fd9GMEXP1
         i7zdaWe7EkAt3ZYhOqRW+/RsV5fsr5n6V1OYxuEhQGgWv1UfJD4OWvC9VGATgk6VDF7K
         SW/aI5NRO4lnpHuC3bANmmkigNZY7piDcKv3nx9l4LjHLgMl6TgscvmWvMKb4JtFMyUC
         veow==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4xW8u4oJn6EuxnIH1YAr9Qdg217TOA2OR24sPOd9hmDSTTSVZkQnY9gEEfTZvw7VoFFrvzCyt+opjoDWJg==
X-Gm-Message-State: AOJu0YxRmhiLmhq6QwXOMYjHg7c41L2MsrqV1zGZvWcqp4GlmRl919X4
	S8LUj+7rh84z0bP+GmweXNPWzk0tIq083RVnRjmpJHfCN56LldxCRGeuRzFWsw==
X-Google-Smtp-Source: AGHT+IHAlFu09JKJgWNU7G7gtL6cufvqGGvWZ8o5JKMDXq3LqEJ77Og35l7+WVrzQRVTXVY8pxpJ3Q==
X-Received: by 2002:a62:f20c:0:b0:6e0:47b9:b727 with SMTP id m12-20020a62f20c000000b006e047b9b727mr2675158pfh.30.1708026293017;
        Thu, 15 Feb 2024 11:44:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k19-20020aa788d3000000b006e07f1829b0sm1695902pff.219.2024.02.15.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:44:52 -0800 (PST)
Date: Thu, 15 Feb 2024 11:44:52 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-ID: <202402151144.70E863483C@keescook>
References: <20240215180156.work.548-kees@kernel.org>
 <Zc5nCsE74E33PdD2@smile.fi.intel.com>
 <Zc5nKZezYhg3Khtr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5nKZezYhg3Khtr@smile.fi.intel.com>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] cocci: Add rules to find str_plural()
 replacements
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1562
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/202402151144.70E863483C%40keescook>

On Thu, Feb 15, 2024 at 09:34:01PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 09:33:31PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> > > Add rules for finding places where str_plural() can be used. This
> > > currently finds:
> > >  54 files changed, 62 insertions(+), 61 deletions(-)
> > 
> > Can we extend this to cover string_choices and call the script probably
> > str_choices.cocci ?
> 
> (And add it to MAINTAINERS?)

Sure! I'll send a v2.

-- 
Kees Cook
