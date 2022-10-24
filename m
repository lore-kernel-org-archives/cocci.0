Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188B5C38A2D
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=SGXhU5hLmGIhMgcFPdYsTmNljhc9wgrjI2VlDSskjnE=;
  b=NkXnjsjc9JqYBEHda2AjjbgQ4pCRWX7T0aZFSOwPFCUfQ9rHOjWPN5LK
   poJX/Fjq9Utr4RhXXMXDym3PTEO/qkaF9saljBtmEq9XpZqEicjwso1yr
   BWmUJ9Tx9WEr8QZatMzMQibn+SXTY1ujc50CcQ2lwaQdGbUp/kSC5gBqF
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,210,1661810400"; 
   d="scan'208";a="68172281"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 21:30:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EAB01E01D1; Mon, 24 Oct 2022 21:30:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E1B6BE004E
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 18:53:59 +0200 (CEST)
IronPort-SDR: 6356c327_dNJX/p3tUjtMsgH73f+Qe55I3164nMj71E9MEDPjmLGzFKZ
 Y5y4JMrr5EqNqFW+dmGJCQVvXH/VDoX4P0/+v5g==
X-IPAS-Result: =?us-ascii?q?A0DrAwB/wlZjfyvYVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U8CgiuBVy4EUI1MhXSCKJFvjSsPAQMBCwEBRAQBAYFTgzIChHECHQcBBDUFD?=
 =?us-ascii?q?QECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNg?=
 =?us-ascii?q?jUpAYNkAQEBAxIoBgEBNwEPCxguNAEFARwGExsHhXwDnySBBEKLMIE0gQGCC?=
 =?us-ascii?q?AEBBoYOgV0JCQEIgSsBj2B6JxyBSUSEPz6IU4IMIpVbOANEHUADCzsyDVEcW?=
 =?us-ascii?q?A4JHxwOFw0FBhIDIG4FQQ8oL2crHBsHgQwqKBUDBAQDAgYTAyICDSkxFAQpE?=
 =?us-ascii?q?w8tByNxCQIDImUFAwMEKCwDCSEfByUkPAdYOgEEAwIQIjwGAwkDAiRZgSUmB?=
 =?us-ascii?q?QMNFyUIBU4ECDoCBQZSEgIKEQMSDwYnRw5KPjkWBidEATQPDhYDY5lHZRMBg?=
 =?us-ascii?q?XBDb6MDnwmDbIFLDJ8iEZZZizKGdZchokmFAgIKBwYQI4FXIoFbMxoIKAiDI?=
 =?us-ascii?q?k4DGQ+OIIkGhWohNDsCBgsBAQMJilsBAQ?=
IronPort-PHdr: A9a23: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
 Kc=
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:idNU6KiOlANdaeISq6fAe6wRKnBQXvcji2hC6mlwRA09TyVXrb
 HLoB0+726PtN9xYgBapTnkAsO9qBznhP1ICOUqTNWftUzdyRaVxeJZnPPfKl/bakvDH4dmvM
 8KE5SWSueAdGSS5fya3ODSKadG/DDoytHMuQ4c9RtQpMNRBp2IIz0XNu9TKCNLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,209,1661810400"; 
   d="scan'208";a="68159396"
X-MGA-submission: =?us-ascii?q?MDEHtQqrqkzNwVOtCR9INw6iSIAgg8vi6Y6hJ4?=
 =?us-ascii?q?MH10gBAig/9+fXMfeaR/MALmcpCfJMFaHGxpKhdA1qgYL5yZqbb24n3V?=
 =?us-ascii?q?ovWwnHA055ZTJq9DrsWZITG1IWTOVzxsQ/guyNN0ONizfhxygu5/UX6n?=
 =?us-ascii?q?ZPOWdZGBS3N/tR7HsROtjm5g=3D=3D?=
Received: from mail-pj1-f43.google.com ([209.85.216.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 18:53:59 +0200
Received: by mail-pj1-f43.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so1959833pjk.2
        for <cocci@inria.fr>; Mon, 24 Oct 2022 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGXhU5hLmGIhMgcFPdYsTmNljhc9wgrjI2VlDSskjnE=;
        b=OUQXmshwm+mvF6yqP2TfNMYqvR9qkNxPZUBU1HPQ4gFstz7dhPf6m7g8F1fM+E1I6w
         7cZkALBPbzfhloR/UZATYeOZj81SCJznce7H+u0hVZ/wUsZvBybT1/4GvQ7YFL0/PYuw
         tj0upBfOHLWTSNsZyZTrEpBHp7rZ06DpMrd6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGXhU5hLmGIhMgcFPdYsTmNljhc9wgrjI2VlDSskjnE=;
        b=d3YDLdgGpHjErbeounCBRQUtRXyv060LIxOzi45LRoAhd6N2Wc8LpxQuf6zglNF5pY
         pr+sN/FXJb+13WW7NvANg9eqOfk3ZvIvWHZdIiB3bWavKMtk/Grp/E8kCU0bt0dKZlnm
         +8aNnI7iEvlv8H7aNhpwIh4lopqlTPeb4A8zKWopJ21VThykIW7D/OyPl+9S+GFkiDhf
         Ar5zOqyTjUugSsxwxB0qSeBobQuQU6hhUObzTE4CHRta8L4uSXKIR3rsviQ3FWwl4ow0
         NY2LgcJAl4dD+oSsk0X+qYtyPGohc8ipeUct2cAmorHL9kwH+A/DMaTIUmTRsVd6r/+P
         K4uA==
X-Gm-Message-State: ACrzQf2Hoh+gvXhrZP39UX4XtaxagHCLZkGAeBRR5m0cXvNCK3iUi1Qd
	yh1lA284iPvKESXbuI9Zanb6TPO+TA+w1w==
X-Google-Smtp-Source: AMsMyM4Q3g2/5hAvtFKte8fAbE324BE4bDgIRbY2HdwlRBxEflXKGL2/uPYMAx0YPBKMIqUtPgTs1g==
X-Received: by 2002:a17:902:cf12:b0:179:fafd:8a1c with SMTP id i18-20020a170902cf1200b00179fafd8a1cmr35203956plg.102.1666630436587;
        Mon, 24 Oct 2022 09:53:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00186afd756edsm1185411plc.283.2022.10.24.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:53:55 -0700 (PDT)
Date: Mon, 24 Oct 2022 09:53:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>, cocci@inria.fr,
	"Darrick J. Wong" <djwong@kernel.org>
Message-ID: <202210240952.CD9E9D376@keescook>
References: <202210191620.171E11C@keescook>
 <alpine.DEB.2.22.394.2210200639050.2988@hadrien>
 <BCF9DF09-DF10-48AC-B689-B97C03900CC5@kernel.org>
 <alpine.DEB.2.22.394.2210200723020.2988@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210200723020.2988@hadrien>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] coccinelle is skipping include files?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 686
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/202210240952.CD9E9D376%40keescook>

On Thu, Oct 20, 2022 at 07:23:34AM +0200, Julia Lawall wrote:
> On Wed, 19 Oct 2022, Kees Cook wrote:
> 
> > On October 19, 2022 9:43:35 PM PDT, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >> The example I'm looking at is fs/xfs/xfs_bmap_item.c, which starts with:
> > >> #include "xfs.h"
> > >> #include "xfs_fs.h"
> > >> #include "xfs_format.h"
> > >> #include "xfs_log_format.h"
> > >> ...
> > >You may want to start with the option --verbose-includes for such
> > >problems.
> >
> > Ah-ha, thanks!
> >
> > >The problem is that Coccinelle can't find the file.  Your .c file is in
> > >fs/xfs, and despite the lack of a complete path, the header file is in
> > >a subdirectory: fs/xfs/libxfs.  So you could add -I fs/xfs/libxfs to your
> > >command line.
> >
> > Ugh, yes, I see this now. It looks like we need to parse the Makefiles? :(
> >
> > >Another solution is the option --relax-include-path.  This should cause
> > >Coccinelle to look over the entire kernel to see if it can find exactly
> > >one file named xfs_log_format.h.  If only one exists, that has to be the
> > >one you want.
> >
> > Interesting solution, and would work here. I wonder if there needs to be a "fail I Coccinelle fails to find a header" option? Hmmm
> 
> What do you mean by fail?  Do you want spatch to stop completely, or the
> file to just be ignored?

I mean have a mode where cocci will error out if it can't find a header.
It already ignores missing headers, but if it can't resolve a header,
and I'm depending on struct declarations to be found, silently ignoring
missing headers is going to mean I miss matches.

-- 
Kees Cook
