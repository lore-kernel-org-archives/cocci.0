Return-Path: <SRS0=9MZy=OL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C31C433EF
	for <cocci@archiver.kernel.org>; Tue, 21 Sep 2021 04:11:20 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E879B611C7
	for <cocci@archiver.kernel.org>; Tue, 21 Sep 2021 04:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E879B611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="529484333"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Sep 2021 06:11:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B106E0019; Tue, 21 Sep 2021 06:11:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 91232E0015
	for <cocci@sympa.inria.fr>; Tue, 21 Sep 2021 06:11:17 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=keescook@chromium.org; spf=Pass smtp.mailfrom=keescook@chromium.org; spf=None smtp.helo=postmaster@mail-pl1-f177.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AZpoOFxNLXo99fZFnzcEl6nbfDRdPi9zP1u491JM?=
 =?us-ascii?q?rhvp0f7i5+Ny6ZQqDv60r3QaCANqTwskHotKei7rnV20E7MTJm1E5W7sIaSU4j?=
 =?us-ascii?q?94LlRcrGs+PBB6zBvfraysnAJYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd?=
 =?us-ascii?q?+KvjoFoLIgMm7yfy+94fXbglVizawYbF/JwiqoAvMscUbnZFsIbsrxBvTpXtId?=
 =?us-ascii?q?eVWxWd2Kl+Wgh3x+MS+8oN9/ipJo/4u+NJOXqv8f6QjULxXFy8mPHwv5M3qrhb?=
 =?us-ascii?q?MUw2C7WYBX2oMkxpIBw/F7AzmXpr0ryD3uPZx1DWcMMbrVr0/Ryis4Ll3Rx/pk?=
 =?us-ascii?q?CcHNiA28GfLisxrkalXpAutqwFjz4LIZY2YMud1cKHActMAXWdPUMZfWTJcDI2?=
 =?us-ascii?q?/YYsAAPYOMvtaoITmu1sCsQGzCRWwCO/z1DNFgGL9060g0+QmFAHLxAkuEMwQv?=
 =?us-ascii?q?3TPsd74KqASUee2zKLVyjjDbO1Z1inm6IfUdRAhpvKMUKlsfsrR00kvEAbFjlS?=
 =?us-ascii?q?NqYzgJT+V0f4Ns2eC4udmSOmghHIppRtrrTiz2scjlJPJhoQNx17E9St0xIQ4K?=
 =?us-ascii?q?NKkRUJlb9OpEYZdui+UOoZ5Qs0vXX9ltTs4x7AIuJO2YjYHxZopyhLCZPGKbYa?=
 =?us-ascii?q?F7g7sWeiRJTp1gm9udrGnhxuq70Ss1unxWtO33VtKtCZJjMTAu38X2xDO6MWKS?=
 =?us-ascii?q?ONx8lql1DuMzQzf9+5JLEAumafaJJMt2KM8m5sdvEnFAyT4gl/5jLWMeUUh4uW?=
 =?us-ascii?q?o6/roYrHhppKEMo97kAD+MqA3lsynBeQ0LxECX2aG9em+1rDv50L5QLJNjv05l?=
 =?us-ascii?q?qnWrorWKtgcpq68GwNV04Aj5AijDzq+ztgUgX0KIEhGdR+HlYTlJUzCLf/iAfu?=
 =?us-ascii?q?igVmhki9nx/XcMb3gBpXNIGLDkLDkfbtl6E5T1hQ8zctD6JJTDbEBI+n+VVPxt?=
 =?us-ascii?q?NzCCR85Ng20w/viCNln0YMeQ22PDreDMKzOqV+I+v4vI+6UaYAJvzbyN+Qq5//?=
 =?us-ascii?q?1gH8imV4deLGp0oENZHC5GPRmOUSZbmD2jtcPC2dZ9jY5Gc73jFyLGRpaeH+2W?=
 =?us-ascii?q?+po5Cw/CYvgCY7cT4SpqL2HxiayWJNMMDNoEFeJRFTlep7McPALa2rGIcJsiTc?=
 =?us-ascii?q?DUruJQI870hSvqQq8zKBoeLmHshYEvI7ugYAmr9bYkgs/oHktV5z1O46lRGFum?=
 =?us-ascii?q?WYJWjpw27pw8xUVIrar1KF5h7lAEYUW6aoWDUE1MpnTy+E8ANf3CFqpljKhQ1a?=
 =?us-ascii?q?8RdCnHDR3Scg+kYdmXg=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfJzYRq3VBf1hKjWHS2XaewqjBJ8kLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSL39qymLpoVg6faUskdrZJhEo7q90ca7MBDhHPJOkOss1PKZLXTbUQ?=
 =?us-ascii?q?iTXflfBOnZslvd8kTFn4Y3tZuIMZIOceEYZWIasS+Q2njeLz9P+qjjzElqv4vj?=
 =?us-ascii?q?JrVWID2Cp5sO0+6xMGimLnE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ANAAASaxphf7HWVdFaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUUHAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJ?=
 =?us-ascii?q?rAh0HAQQwCQ4BAgQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBA?=
 =?us-ascii?q?xIoBgEBNwEPCxguNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSg?=
 =?us-ascii?q?BjHh6JxyBSUSEOj6IEYIuhEVhgyOUOYtenRuDMoE3C507EJU5kSy7LQIKBwYQI?=
 =?us-ascii?q?4E9ghQzGggoCIMkUBkOjiCJBoVqITI4AgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0ANAAASaxphf7HWVdFaHAEBAQEBAQcBARIBAQQEAQFAgUU?=
 =?us-ascii?q?HAQELAYN4a4xrYIZFgieQZ4sBgXwLAQMBCwEBQQQBAYRhAoJrAh0HAQQwCQ4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBDQsQCDgmhWgNgjUpAYNkAQEBAxIoBgEBNwEPCxg?=
 =?us-ascii?q?uNAEFARwGNYVXmwiBBD2LMIEzgQGCBwEBBoYogVoJCQEIgSgBjHh6JxyBSUSEO?=
 =?us-ascii?q?j6IEYIuhEVhgyOUOYtenRuDMoE3C507EJU5kSy7LQIKBwYQI4E9ghQzGggoCIM?=
 =?us-ascii?q?kUBkOjiCJBoVqITI4AgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="393526769"
X-MGA-submission: =?us-ascii?q?MDEvhgD4t9ncPHLZOMn+f899/8KYutmPdKW82Q?=
 =?us-ascii?q?HX3KpL+fwhLtgH26xITrlBHGOKNK8CIi81NOp2aNWI4W9qEW1WafbMy2?=
 =?us-ascii?q?pxXpuAmXxH+KQr9Mw5BOlKnmmbK8ejew5sGglo2VUY8yXesUafS8/nRE?=
 =?us-ascii?q?P+52fG4de5b/wwH0AegXWl/Q=3D=3D?=
Received: from mail-pl1-f177.google.com ([209.85.214.177])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2021 06:11:15 +0200
Received: by mail-pl1-f177.google.com with SMTP id w11so2958567plz.13
        for <cocci@inria.fr>; Mon, 20 Sep 2021 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RrsIUFsgdVEV9u8AfoCBidEjir1ElPvpFUt1V+NocGw=;
        b=RTIXXCor2HBuELFwts/ARsg+jToFD8Kk9Of21UxHtdQAHlE7iyQ/ICqque826Aut4x
         g3dJ4R2q/wOXntAMm7HYnAbEBftwBaYsm6uJoh0AlJ3iN6eYFBQrzaPn/zKuy3a2G9Ev
         P/mO9pSF2bXEU51aNJSksk/eQM6USDql47EZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RrsIUFsgdVEV9u8AfoCBidEjir1ElPvpFUt1V+NocGw=;
        b=PZq72cdDPFrOPZ+IYcud3fBUMrDCvM1ge6FAHc4MhxcF2VG0vljfO9hLD537FnsOGa
         AdmLoSTLBwB5kKOq97YLTjxDtJdUQdPNMOEFq/Yag1gabMbVxAch/ZLzfPq9qk9nyJDx
         N1ABPle6dsps2Sp3yYyfwRhmokUoLFw/OVZwlx8CBfJZ4uTl1viJXtBSZ/kbnfAot6pG
         k+HHdPjB8TBNcLrbKlTDE+0CVhd7qjVnvLezx69SFMfoBAIa4bkgG1xzNoo/Nn0rHaGk
         X98AdRTx03NSdrn90mC564mLd0OMuHPOwQAt6OqrRXR7ULKZOF+B2G3GFLGk4ZqG5Cmd
         u6jA==
X-Gm-Message-State: AOAM532PxnBPrPkritZIfaJ6FDHQu7pSZKrvvPpz6RM2yUu2DjOjfjcY
	MxZX0K06J0kZvqTz+rUqfNbkrq9J6Oo6RQ==
X-Google-Smtp-Source: ABdhPJxzxvKysuhSQMN8vO3KCuITzPYNF/9jwKODEBEoDSwulVbV5BMxeWZocY9+SrC6H7fU3a5qIg==
X-Received: by 2002:a17:90a:f2cd:: with SMTP id gt13mr2863465pjb.153.1632197474092;
        Mon, 20 Sep 2021 21:11:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w22sm12004079pgc.56.2021.09.20.21.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:11:13 -0700 (PDT)
Date: Mon, 20 Sep 2021 21:11:12 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Mansour Moufid <mansourmoufid@gmail.com>, cocci@inria.fr
Subject: Re: matching an arbitrary struct or union (but not scalars)
Message-ID: <202109202109.69B0020@keescook>
References: <202109161609.9AB60A934B@keescook>
 <CALogXGUA2-ztW4eDLQ9RNCda8=8k8cSS_A230vMMAG0zCMeEfA@mail.gmail.com>
 <202109180813.D8EC1ECE07@keescook>
 <202109180847.33FE2744@keescook>
 <alpine.DEB.2.22.394.2109181812421.2929@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2109181812421.2929@hadrien>
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 17
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-09/202109202109.69B0020%40keescook>

On Sat, Sep 18, 2021 at 06:13:32PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 18 Sep 2021, Kees Cook wrote:
> 
> > On Sat, Sep 18, 2021 at 08:40:19AM -0700, Kees Cook wrote:
> > > Yeah, this is for the kernel. Thanks for helping with this! I was able
> > > to continue the construction and get it working. :)
> >
> > I spoke too soon; it fails on the kernel with:
> > EXN: Coccinelle_modules.Common.Timeout
> 
> What is your command line?  If it times out on one file, it should just
> move on to the next one.

To work around potential intermixed output, I rewrite the normal
coccicheck arguments that uses --jobs to launch $nproc many spatch
instances with -max and -index. I will switch back to using --jobs and
see if I still get corrupted patches... (It's been a while since I
created this alternative workflow.)

-Kees

-- 
Kees Cook
