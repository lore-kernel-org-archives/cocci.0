Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FFCC4332F
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=AOAkDWghNKX8EZrV0tpR7EIlXHivcUaAOcdOzMwyo3E=;
  b=dfu34r98cUZusoCYSx3SMSGZz94emPuKDm+7YOXjjrr6liAGqYXTXHsp
   jwaY1rqPC6Tswj8aRe2yT6ZMygslK9CKH+5LHKDEU1u/TLaPw6dhTit0C
   qO5FQT0c2k281uSAyGkblhcxpttYcZbvWL8yqjj2N2XzhfFUdN05PtbQ/
   4=;
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
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72706300"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:56:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53662E01BE; Wed,  2 Nov 2022 18:56:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DF7EFE002A
	for <cocci@sympa.inria.fr>; Wed,  2 Nov 2022 18:56:39 +0100 (CET)
IronPort-SDR: 6362af57_gYdlWQhX7TSmYacagZvwYUXFOE2MuCEni4UKZNeJolpin3f
 6ro9Q5UMKXLXzUCUv0twAMGkbwjIVqcGUc12qUg==
X-IPAS-Result: =?us-ascii?q?A0CkAgACrmJjfy/dVdFagQmBT4ItgVYvBAtFhE6OdYIlA?=
 =?us-ascii?q?4tEgQeQW4F9DwEDAQ1EBAEBhQUChHkCHQcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNgjUpAYNjAQEBAQIBEhEdA?=
 =?us-ascii?q?RsdAQMMBgULDQICJgICIgERAQUBHAYTIoVIAQMNIwOgHIEEQoo4eoEVBQIWg?=
 =?us-ascii?q?QGCCQZSl0EKGSgNa4FaAgcSfyyFDoITHFdchw96JxyCDYEVNoJ0PogbgmYEl?=
 =?us-ascii?q?jsBAwcDBAYFDwMDAiEBAgFDHQIJAyMPAwsJCBMXKAYBAgEBDAdABAYVHwMBA?=
 =?us-ascii?q?Q8kAQECAgIDBAcCAQMGAwwCAgEBAQUGDQMCAwgBEgMCAQMFAgIEAQIECggBA?=
 =?us-ascii?q?gIBAgQFBwIBCAYFDQUJCwEBAgMHBAMRAgUDBQUDAwIBCgUCAwECAQEDBgQEA?=
 =?us-ascii?q?QECAwICAQYCAgEBAwMEAwECBgICBwIDAgEEAgMDAQEBAgICAgICAwMJAggHB?=
 =?us-ascii?q?QEGAQIBBAMCAgECBwEEAQgDAwUFCQ8DBQMBAwMCFAoFAQMIBggCBAUCBQMCB?=
 =?us-ascii?q?AIDAgIIAwIEAwsDBQQCBwQPBwIDAgIFAgICAgIFBAMBAgICAgICBQIDAgEFA?=
 =?us-ascii?q?QICAQICAgQBAgIHBAIDAQMEDgQDAgIHAQICAQYCBwMBAgEEAwEBBAIEAQIFA?=
 =?us-ascii?q?gQBAwYCBAMKAgIDAgICBgUDAwoIAgMFAgQBAQIHBAICCwEGAgcCAgMQAQMBB?=
 =?us-ascii?q?AUFAwMDCQICAwIEAgIKAQEBAQIBBwIEBw0CAgIEAgICAQMCAgEBAgIKEgEBA?=
 =?us-ascii?q?gMGBAYFAwIIGAEGAgEBAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECA?=
 =?us-ascii?q?QICAwMCAQQCBAMDAQIBAgICAwICAgMCAgEPAgYGAQICAgICAgICAgEFAQIBA?=
 =?us-ascii?q?gQCBwIEAwIBAgIFAgICAwEBBgIECwEDAgcGAQMCBwUCAwEEAwQDAwsFDAgBB?=
 =?us-ascii?q?QEDARIOAwICCAIHAgEGBQEPAwICAwICAQQKAgMFAgQCAQQIBwIEAQIJAwIGA?=
 =?us-ascii?q?gcFGAECAgcEDAoCAgIFBgIEAQEBAQMBAgEBAgMEAgMCBAUBBQIBAgUEAgIBA?=
 =?us-ascii?q?QIFAgwBAQcGAgcCAgICAwEEAgECAQMDAgMBAQEDBgYFBAQCAwMGAgICBgICA?=
 =?us-ascii?q?wIRAwcCBgMCBAENDwUEBQgBAgEBBwIEAgcJDgIBBgEFAgIDAgIBBQIBBgMBA?=
 =?us-ascii?q?gICAgUIBQMEBQMGDwMBAQQDAgECAQQDAgMHAwIEBAMBAgMEBgYBCQMCAgYDA?=
 =?us-ascii?q?gICDQMEAgIBAgECAwQEBgICAgECAgICAwEEAgIBAQMDAwICAgMEAgMDCwYKC?=
 =?us-ascii?q?AICAgMCAQULBAIDAgEDBgkCBAICBgECBAICAgICAgIDAQEDCgQCAQIDAgIGA?=
 =?us-ascii?q?wYCAQIBAgEJBQIBCQMBAgECAQQBAwkBAgIECQIEBwUEBgQCAgICCAICDgMDA?=
 =?us-ascii?q?gEBBAICBAUCAgsCAQIHAgUBAQMFBwICAQICAQQDAQkEAQICAwIBAQMDEQMDA?=
 =?us-ascii?q?wEEAgIFAwMNCQYCAgEDAgMBDQMDAQIBAgMBBQUXAwIBCAcDEwMCAQEDAgECA?=
 =?us-ascii?q?gMGBAEIAgIDAwMCAQIFAgQDAwEFAgEBAwEFAwIOAwIDAwMCBgECAQECAwMBD?=
 =?us-ascii?q?AQFAQEBARcBAgMCBAICAQECBQEEAwEBAgECAwICDgYBBAUMAwIBAh8CAgMDA?=
 =?us-ascii?q?QQFAgICCAICAgEDAwEDAwUBAgMEAgIBBQQKAgICAgICAgEMAgoDAgMBAwUBA?=
 =?us-ascii?q?QQCCQUBBQECBwIFAps1E0xbSgiBLaBvoTFjgw6EPJwTMqkTly2iNAWFLhAjE?=
 =?us-ascii?q?oEtOoFbTSNQMYI2TwMZD5ISil9DMTsCBwsBAQMJij4BAQ?=
IronPort-PHdr: A9a23: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
 zYzgwp6JPs3rXLivwhxKV3Nqy891kI2nIe96Q0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cYmslqnfl9/42BEWscwZQq5I7hPpDfIY3DAbv31ZSRFFG/Fw9v
 re5cjzsCWYtN9/Yh8dcLy7WZVoOEmskaKdg7N/AV7SZniBhILAFugLgbcKpQeBJ8SXzIVgPM
 xbAs1D4bPLfDtHpPe/zC2DV+whzt7vytHOuQ6P9R1QpSUGUdAD0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72706293"
X-MGA-submission: =?us-ascii?q?MDGg+r41TPRNc1/YDEeyYl2RbJD0rw1kLpNZNd?=
 =?us-ascii?q?oEnnN/QE2EkcDq+HEfTD9cpjGYi8XAGSgoC2uAqS7Iq5Xok5+ElnMoQT?=
 =?us-ascii?q?or+zSlKfUg89UWfq/MceCR/ODjFDjgKK+OpFO45BnXNC8IP/nvG4nga/?=
 =?us-ascii?q?ji2rJOlyD69vWGgTdWGwiK5Q=3D=3D?=
Received: from mail-wr1-f47.google.com ([209.85.221.47])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 18:56:39 +0100
Received: by mail-wr1-f47.google.com with SMTP id g12so25652777wrs.10;
        Wed, 02 Nov 2022 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AOAkDWghNKX8EZrV0tpR7EIlXHivcUaAOcdOzMwyo3E=;
        b=oZ/HAavdSt/LAxHUPtFshlWw33EOsOQV+iYCOG2NgVEduoF0K5vJa+uvTBOd52CwfC
         7zbl1NBgdDOZti2w1W+oNb2O3f5yGtzIEZEHdfU0LLkDNpHAPbodGWW3iFnha98NN4vp
         QZtbkOK9134UYtWvVd9Sqyd7xh3NDztJ+kHyqrG4rSQSsVPgf8ndxz3zHrwftwlOBti6
         EnSwP41W+huTnrENX0bYQAJnPSZ6ijqhPr7uHOCFDPFwbQo9lcyCD+WnHltUZ4OvFnl3
         TUQyu4L9aTPY5zemZTWH005CPm2aKWE8/OBYcdhooCUGIpJNWVmRDDvKpx5HwudTSJWq
         HPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOAkDWghNKX8EZrV0tpR7EIlXHivcUaAOcdOzMwyo3E=;
        b=JtY1VjdrBIVJMOI6l/IfiFoP+PNDciRkKX9xJoGHE+WovksaNsuDeMm1KMKhB8clSH
         tTzbSjbPKSqUpe+EXKwkhLhsxiB7UlUIbnWpguvr5C/dMydANoABpHhhT4bcWLHZqps7
         9HUUEpPvJAscj463tqXgmZPJjmNi5c5+tqMODCjWaOQO//ETrIAH5Kzy+xMoQaQHiZuA
         yGHdOG1Rc6dQyHl8mY9cSh67Cc+0pE1pD4/BRV7vR1NJ40tZpOwbGAmF8vjJwrLr4yV+
         owXRp66Bx28ACgy+ab2X53oeZWXL2A/yLMOswcRwK4FyP5Xe+77bPHs012bL9+L0cDhj
         b/CA==
X-Gm-Message-State: ACrzQf19wZJdpH2H4wKALtEiCGqbNu3TyZU3FSKeIeKKDQAwCEnfwy5x
	VFHRRFmBU8gdEW7p2qjjSRy/0+pn0dArKNcVmq7uVPmWuqg=
X-Google-Smtp-Source: AMsMyM43ZwI0OVU924Z5XunzMqExo3zRyrJLkgYB1/GEk7LfaxpkvEkwqc7YuRXAt2oSCwBePusbJ6wtxu4Mbq/K31k=
X-Received: by 2002:a05:6000:118d:b0:236:f075:dccd with SMTP id
 g13-20020a056000118d00b00236f075dccdmr3065635wrx.37.1667411798601; Wed, 02
 Nov 2022 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <af27585c-14bc-922e-73bf-b4e1dd83533d@inria.fr>
In-Reply-To: <af27585c-14bc-922e-73bf-b4e1dd83533d@inria.fr>
From: Sebastiano Miano <mianosebastiano@gmail.com>
Date: Wed, 2 Nov 2022 18:56:27 +0100
Message-ID: <CAMENy5pUFcbA0SzQ=CYB4UevcUA-fBuWEMmO0d9UvTAa+T8r0w@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Sebastiano Miano <mianosebastiano@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 700
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/CAMENy5pUFcbA0SzQ%3DCYB4UevcUA-fBuWEMmO0d9UvTAa%2BT8r0w%40mail.gmail.com>

Hi Julia,

On Wed, 2 Nov 2022 at 18:30, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Wed, 2 Nov 2022, Sebastiano Miano wrote:
>
> > Hello,
> >
> > I am trying to use Coccinelle to replace a function that is called
> > multiple times in the code with a different version whose name is
> > taken from the string variable that is passed as the second parameter.
> >
> > To explain better, my C code is the following:
> >
> > #include <string.h>
> >
> > static int process(__u64 off) {
> >   MERGE_FUNCTION_OPENED("file.c", "ping_pong", arg1, arg2, arg3, arg4, NULL);
> >   MERGE_FUNCTION_OPENED("file2.c", "ping_pong2", arg1, arg2, arg3, NULL);
> >   return 0;
> > }
> >
> > I want my code to be transformed into the following version:
> >
> > #include <string.h>
> > #include "file.h"
> >
> > static int process(__u64 off) {
> >   ping_pong(arg1, arg2, arg3, arg4, NULL);
> >   ping_pong2(arg1, arg2, arg3, NULL);
> >   return 0;
> > }
> >
> > where the string that is passed as the second parameter is used as the
> > function name, and all the other arguments are copied as they are.
> >
> > I managed to write a working cocci script (listed below) that is doing the job.
> >
> > @merge_annotation@
> > expression path, fn;
> > @@
> >
> > MERGE_FUNCTION_OPENED(path, fn, ...);
> >
> > @script:python merge_p@
> > path << merge_annotation.path;
> > fn << merge_annotation.fn;
> > new_fn;
> > include_name;
> > @@
> > print "Obtained path: %s and file name: %s" % (path,fn)
> > coccinelle.new_fn = cocci.make_expr(fn.strip('\"'))
> >
> > import os
> > pre, ext = os.path.splitext(path.strip('\"'))
> > p = "%s.h" % (pre)
> >
> > coccinelle.include_name = cocci.make_ident("\n#include \"%s\"" % (p))
> >
> > @c@
> > expression merge_p.new_fn;
> > expression E1, E2;
> > expression list E3;
>
> The problem is here.  You don't put any constraints on the arguments of
> MERGE_FUNCTION_OPENED, so both new variables (ping_pong and ping_pong2)
> affect both calls.  You should use merge_annotation.path and
> merge_annotation.fn to be sure to get only the calls that are related to
> the new names you have made.

That's amazing, it works now.
Thanks a lot for the clarification.

>
> julia
>
> > @@
> > - MERGE_FUNCTION_OPENED(E1, E2, E3);
> > + new_fn(E3);
> >
> > @add_include depends on c@
> > identifier merge_p.include_name;
> > @@
> >
> > #include <...>
> > + include_name
> >
> > Unfortunately, this script works only when a single instance of the
> > MERGE_FUNCTION_OPENED(...) function is used. When I use both of them I
> > get a "c: already tagged token:" error.
> > Using "++" instead of "+" removes the error, but produces a code that
> > contains 2 calls to the ping_pong function, and 2 calls to the
> > ping_pong2 function.
> > Any ideas on how to solve this issue?
> >
> > Thanks in advance,
> > Sebastiano
> >
