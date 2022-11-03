Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A275FC4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MAVUEZ8K9x0A23ANkp3i7Q8fQlH3UtM/epSm9Fk2bg0=;
  b=W1Gm9opsnEArReX+FCmDohCf+ruDPQMNeBTl21Ir9hJXY3BucOfGRNoz
   HBxuzyGWhW6SJnWsJH+J95IbkyBGLdWqNolbTNeY25xpxn7/yJx1ZPT1W
   hWGpc0nlDM9YGzNueiVoQCzGwvtP4g7EoBCcSmxfXyUhtsf2/FBWuioPu
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72798854"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 11:51:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A381FE7387; Thu,  3 Nov 2022 11:51:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 6221AE7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 11:51:23 +0100 (CET)
IronPort-SDR: 63639d2a_R5rialBS7afPwgE1GQfoGjUJRq1A4m23Rbi/2Dbsfzn7wdL
 WeYNot77X0OeDjdrxRmyDB7qyug11oRZxhcMZYw==
X-IPAS-Result: =?us-ascii?q?A0CqBABUm2NjfyqAVdFaHQEBPAEFBQECAQkBFYFPAoIrM?=
 =?us-ascii?q?wGBIi8EC0WETpEdi0SBB4YmijWBfQ8BAwENFAEvBAEBhQUChHkCHQcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNg?=
 =?us-ascii?q?jUpAYNkAQEBAxIRHQEbHQEDDAYFCw0CAiYCAiIBEQEFARwGEwgTB4VIAQMwA?=
 =?us-ascii?q?55ggQRCizKBFQUCFoEBggkGmBMKGSgNFVaBWgIHEn8sAYUOg2KDRiCDLXonH?=
 =?us-ascii?q?IINgUuCdD6ERBWDQoJmBJY/AQMHAwQGBQ8DAwIhAQIBQx0CCQMjDwMLCQgTF?=
 =?us-ascii?q?ygGAQIBAQwHQQQGFR8DAQEPJAEBAgICAwQHAgEDBgMMAgIBAQEFBg0DAgMIA?=
 =?us-ascii?q?RIDAgEDBQICBAECBAoIAQICAQIEBQcCAQgGBQ0FCQsBAQIDBwQDEQIFAwUFA?=
 =?us-ascii?q?wMCAQoFAgMBAgEBAwYEBAEBAgMCAgEGAgIBAQMDBAMBAgYCAgcCAwIBBAIDA?=
 =?us-ascii?q?wEBAQICAgICAgMDCQIIBwUBBgECAQQDAgIBAgcBBAEIAwMFBQkPAwUDAQMDA?=
 =?us-ascii?q?hQKBQEDCAYIAgQFAgUDAgQCAwICCAMCBAMLAwUEAgcEDwcCAwICBQICAgICB?=
 =?us-ascii?q?QQDAQICAgICAgUCAwIBBQECAgECAgIEAQICBwQCAwEDBA4EAwICBwECAgEGA?=
 =?us-ascii?q?gcDAQIBBAMBAQQCBAECBQIEAQMGAgQDCgIDAgICBgUDAwoIAgMFAgQBAQIHB?=
 =?us-ascii?q?AICCwEGAgcCAgMQAQMBBAUFAwMDCQICAwIEAgIKAQEBAQIBBwIEBw0CAgIEA?=
 =?us-ascii?q?gICAQMCAgEBAgIKEgEBAgMGBAYFAwIIGAEGAgEBAgIDAwIGAgECCAIEAQQFA?=
 =?us-ascii?q?gECAgICBAEDBgIDAQECAQICAwMCAQQCBAMDAQIBAgICAwICAgMCAgEPAgYGA?=
 =?us-ascii?q?QICAgICAgICAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCB?=
 =?us-ascii?q?wUCAwEEAwQDAwsFDAgBBQEDARIOAwICCAIHAgEGBQEPAwICAwICAQQKAgMFA?=
 =?us-ascii?q?gQCAQQIBwIEAQIJAwIGAgcFGAECAgcEDAoCAgIFBgIEAQEBAQMBAgEBAgMEA?=
 =?us-ascii?q?gMCBAUBBQIBAgUEAgIBAQIFAgwBAQcGAgcCAgICAwEEAgECAQMDAgMBAQEDB?=
 =?us-ascii?q?gYFBAQCAwMGAgICBgICAwIRAwcCBgMCBAENDgUEBQgBAgEBBwIEAgcJDgIBB?=
 =?us-ascii?q?gEFAgIDAgIBBQIBBgMBAgICAgUIBQMEBQMGDwMBAQQDAgECAQQDAgMHAwIEB?=
 =?us-ascii?q?AMBAgMEBgYBCQMCAgYDAgICDQMEAgIBAgEBAwQEBgICAgECAgICAwQCAgEBA?=
 =?us-ascii?q?wMDAgICAwQCAwMLBgoIAgICAwIBBQsEAgMCAQMGCQIEAgIGAQIEAgICAgICA?=
 =?us-ascii?q?gMBAQMKBAIBAgMCAgYDBgIBAgECAQkFAgEJAwECAQIBBAEDCQECAgQJAgMHB?=
 =?us-ascii?q?QQGBAICAgIIAgIOAwMCAQEEAgIEBQICCwIBAgcCBQEBAwUHAgIBAgIBBAMBC?=
 =?us-ascii?q?QQBAgIDAgEBAwMRAwMDAQQCAgUDAw0JBgICAQMCAwENAwMBAgECAwEFBRcDA?=
 =?us-ascii?q?gEIBwMTAwIBAQMCAQICAwYEAQgCAgMDAwIBAgUCBAMDAQUCAQEDAQUDAg4DA?=
 =?us-ascii?q?gMDAwYBAgEBAgMDAQwEBQEBAQEXAQIDAgQCAgEBAgUBBAMBAQIBAgMCAg4GA?=
 =?us-ascii?q?QQFDAMCAQIfAgIDAwEEBQICAggCAgIBAwMBAwMFAQIDBAICAQUECgICAgICA?=
 =?us-ascii?q?gIBDAIKAwIDAQMFAQEEAgkFAQUBAgcCBQIDAQEBAgICBgKcF1uBJMJ8Y4MOh?=
 =?us-ascii?q?DycEzKpFJcvp2cQIxKBLTqBW00jgQGCNk8DGQ+SEopfQzE7AgcBCgEBAwmKP?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23: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
 gQNmPb2cd5VOYr81EhvLFJ9mdaSc3c=
IronPort-Data: A9a23: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
 XcdHQh5fa1wdaI9/QuMtZKY9NH1cQ4DFwkVUBo=
IronPort-HdrOrdr: A9a23:ej3dZqrRrSa/mPWPI+f7WxsaV5oeeYIsimQD101hICG9vPbo7v
 xG+85rriMc6QxhIE3I/OrrBEDuewK4yXcY2/hyAV7mZniEhILKFuBfBOnZslnd8kTFn4Y36U
 4jSchD4bbLfD9HZKjBkW+F+hUbrOVvMprEuQ4T9RhQpMhRBZ1d0w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72798820"
X-MGA-submission: =?us-ascii?q?MDFfgY3eDeabtGzrmX7a+fR7UZevIK01IKFSzv?=
 =?us-ascii?q?KTAtnxlyg+AUfxnSq4tCAGC0Ppblwh96YDr4NqRZtLnPy+e1ohhiHFHL?=
 =?us-ascii?q?Yn8tALVR+VFOmpN+SkR+24rk6QvxWh2oEyUYSNV2wo8v8IY0qgJOA7/K?=
 =?us-ascii?q?7h5f+VpgTuh5G9CVmzjOtyMg=3D=3D?=
Received: from mail-wm1-f42.google.com ([209.85.128.42])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:51:23 +0100
Received: by mail-wm1-f42.google.com with SMTP id v7so887313wmn.0
        for <cocci@inria.fr>; Thu, 03 Nov 2022 03:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAVUEZ8K9x0A23ANkp3i7Q8fQlH3UtM/epSm9Fk2bg0=;
        b=gMBYCTU8tBia6caMEIHFkIo79Amfq8/Ss6bJI/i6x+kOiKuPCmpi/hc7UIhtVBy5ey
         a5cfF73V9YqnK6XeEUO47is2I+Cid5/kE5rRGuui5MC8AH5zbKIvYaL+Cat6l5PlKmEg
         QBqdSaIOlY//PeJz3wPQnkQdFlrEfqMzQYDUaZ3CE45QMsFQ05TbzjSQHb1R3unZ6Rl7
         3cEaYFHipdWujWaebf+sbq7ZcvDs48ch1K55ngajnsKsXcquw4fp3afiSVZ39fNLtKNX
         sCxe6GjlCMN5KUpl+BXrJQJYvrsgvS6y1wDi4KGXPDjf88fTCDeZcMH31IvUF/aI9rzm
         aY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAVUEZ8K9x0A23ANkp3i7Q8fQlH3UtM/epSm9Fk2bg0=;
        b=qLkruoGQVfGphWdmw5lx4CKtS14F+rgQoC55T1Klyo4b7ZeCe1iS1KonrvkYWMc7Xc
         XxP7p/sBcsjSg7mj6o9tURVh9XhbhcQjU7Oymbe69Gtvle+v6/YRlBElSTPMr6pdhYnM
         ePpiI6vdop+5sOQC1jPHAvNhs4GC6lYXTacIffBAy7FX7gLw5SSF7E7i35ESJ08VP+X9
         7dx7vHYRK8slPHDDAcMoNuVOz/MAioAoN4FbfssDB2nz0CkfAQ0iISPZ+rNXBCZ1Kr4K
         VplDEbwjDo/Vdc61TZFcxC3QWvyTC7ixjTh0dIufdfdir/HtlLRqgAB4kwqL645QDLDa
         nS6A==
X-Gm-Message-State: ACrzQf0h5sWeERsx0nefyv+h6R5IDvFkLVMCvrlfIXiX05KP7M7SVzG4
	pRZFBdHWv5dG3wv06YmUHq672UIXsAqb7nGwehTxiX20yhE=
X-Google-Smtp-Source: AMsMyM6vOWBfnAP0P1KarvvRDb+A4O7qCukqybM1g/CYah4uxmk8U+NcS/tujQgMd+wc6c8edxbcOWbnUNNwOINiSYw=
X-Received: by 2002:a7b:cc15:0:b0:3b4:ca90:970d with SMTP id
 f21-20020a7bcc15000000b003b4ca90970dmr19124550wmh.198.1667472682334; Thu, 03
 Nov 2022 03:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
In-Reply-To: <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
From: Sebastiano Miano <mianosebastiano@gmail.com>
Date: Thu, 3 Nov 2022 11:51:12 +0100
Message-ID: <CAMENy5otzNE3wfm8=PJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Sebastiano Miano <mianosebastiano@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 704
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/CAMENy5otzNE3wfm8%3DPJxP_8T4t_AydhUWs_dmWGmvzrrBeQa7w%40mail.gmail.com>

Thanks Markus.
It definitely looks cleaner now.

On Wed, 2 Nov 2022 at 20:15, Markus Elfring <Markus.Elfring@web.de> wrote:
>
>
> > Any ideas on how to solve this issue?
>
>
> How do you think about to use the following SmPL rule variants instead?
>
> @initialize:python@
> @@
> import os
>
> @searching@
> expression path, fn;
> @@
>  MERGE_FUNCTION_OPENED(path, fn, ...);
>
> @script:python generation@
> path << searching.path;
> fn << searching.fn;
> new_fn;
> include_name;
> @@
> coccinelle.new_fn =3D cocci.make_expr(fn.strip('\"'))
> pre, ext =3D os.path.splitext(path.strip('\"'))
> coccinelle.include_name =3D cocci.make_ident("\n#include \"%s.h\"" % (pre=
))
>
> @replacement@
> expression searching.path, searching.fn, generation.new_fn;
> @@
> -MERGE_FUNCTION_OPENED
> +new_fn
>  (
> - path, fn,
>   ...
>  );
>
> @addition depends on replacement@
> identifier generation.include_name;
> @@
>  #include <...>
> +include_name
>
>
> Would you like to reconsider also the implementation detail that an =E2=
=80=9Cidentifier=E2=80=9D
> is used for the construction of a preprocessor directive so far?

I would love to reconsider it, but I didn't find an alternate solution.
Do you have any suggestions?

Thanks,
Sebastiano
