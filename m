Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04580C6FA8E
	for <cocci@archiver.kernel.org>; Mon, 26 Sep 2022 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NEB8Su2EmMGQStsf6g+FzyXWbmMpJR2zUjmG4cTznAk=;
  b=GvHavpphGUk3NtayPHHs1bFENPEyEgsVUlzM6OjtNyi5MqcBGLqCGXEO
   EQe/1smbMmXVkyEqf7JHKhp/kEMfdUh3GLI9HHjVGOWq1wD7fw3jq78dB
   LOGytZSWarKPhM2du6oYOukpGKAlkFznupIHTZd5c1Eeczuhyd82Dumrj
   E=;
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
X-IronPort-AV: E=Sophos;i="5.93,346,1654552800"; 
   d="scan'208";a="54606865"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Sep 2022 20:59:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAAF5E0130; Mon, 26 Sep 2022 20:59:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DC0BCE0090
	for <cocci@sympa.inria.fr>; Mon, 26 Sep 2022 20:52:43 +0200 (CEST)
IronPort-SDR: 6331f4fb_Nh733/ILwEuzl0VvJaRseuc2X33D5Ma88YaoysXA4+wOG8x
 dMAnAToUgXSUftxgU+lYlu0igZTrPf0G/70243g==
X-IPAS-Result: =?us-ascii?q?A0DXAwCR8zFjf67WVdFagQmBT4IkgVcuBFCNTIVxlBCLK?=
 =?us-ascii?q?oF8CwEDAQsBAUIEAQGBU4MyhG4CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBARgJGQcODgUkhWgNgjUpAYNmFhUTBgEBNwGBFAEFA?=
 =?us-ascii?q?VeFfAOdfoEEQoswgQEzgQGCCAEBBoYNgVwJCQEIgSuPL4EhHIFJRIEVjDqCL?=
 =?us-ascii?q?pkpOANEHUEDC0I1GAMUAwUkBwMZDyMNDQQdDAMDBSUDAgIbBwICAwIGEwUCA?=
 =?us-ascii?q?k02CAQIBCskDwUCBy8FBC8CHgQFBhEIAhYCBgQEBAQVAhAIAggmFwcTMxkBB?=
 =?us-ascii?q?VkQCSEcKA0FBhMDIG8FRA8oMWsrHRsKgQwqKBUDBAQDAgYTAwMiAhAqMRQEK?=
 =?us-ascii?q?RMSLQcrcwkCAyJsAwMEKCwDCSEfBygmPAdYOgUDAhAiPQYDCQMCJFuBLygFA?=
 =?us-ascii?q?w0ZJggFOh4ECDwCBQZXEwIKEgMTD5pwRDUcAUuCV6J0nl+DY4FJDJ8UEZZWi?=
 =?us-ascii?q?xqHA5cLoj+FAQIKBwYQI4E+Oi2BLjMaCCgIgyJOAxkPlyaFaiE0OwIGCwEBA?=
 =?us-ascii?q?wmJeV0BAQ?=
IronPort-PHdr: A9a23:GHeAnRE0DtQY23jCW3e7xJ1Gf/NGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31xmSAd+QsqgUw8Pt8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PdbglSijewbq1+I
 BqroQnPtcQdnJdvJLs2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cWGFPXNteVzZZD42yb
 4UBEfQMM/tboYbyu1QBsACzBRWwCO711jNEmmP60bM83u88EQ/GxgsgH9cWvXrRstr6KrwSW
 v2rwanPyjXDbO5d1DD+6IfWbB8huu2DXbV3ccrS0kQgCwPFjk+XqYzgPjOVy+ENv3Kc7+p6W
 uKikmgqoBx+rTaz3MkjkJXJhp4LxVDe8yV02II4KcG8RUN4f9KqEIdcuiCGO4V5QM4vQnxlt
 SknxrMGt5C2fywHxZo7yhPed/CJfYuF7wziWeuNPzt2inJrdbK5ih2v/0agzej8WdO10FZMt
 idFjtjMtnUT2BDJ7siHTedy8V2l2TuJygvd6flELFgqmabHL5Mt2L09m5oJvUjdAyP7l1/6g
 LKUe0gr4uSk9uDqb7b8qpOBOIJ5ihvyP6Uhl8ClHOg1MwYDUm6G8uqmzrLj51f2QLBSg/02j
 KbZtJfaKNwepqGjAg9V1p8v6w67Dzu7ydgYk2QLIVBKdR6dgIjpPFbOIP/8DfihmVijjDBrx
 /XeMr3gBJXCMGTDna//cbph70NQ0gk+wNBF655KF70ML+j/VlLzudHXFhM5Nha7w+fjCNVzz
 IMeXmePD7eaMKzMr1CI/f4gI+6LZI8WozvyN/gl5+TpjX88mF8dYKyp0YEQaHCiEfRqO0OZb
 mH0jdcbDWgKphY+TPDtiFCaTDJff2yyUL4k5jEnFIKmCp/OSZyqgLOdwCi7H4ZbZntGC1CJC
 XfnbZ+IW/YKaCKII89uiCYIVba7S9xp6Rb7vwjxwLtPL+zO+yReu4iw+sJy4rjwmBwpvRdzC
 MfVh2KAQnp/mWQLbzQ2xqd6oFF4jFCZ3v4r0LRjCdVP6qYRAU8BPpnGwrk/UoiqMuqgVtKAS
 VL9B86jHSl0VdUphdkHf0d6HdymyBHFxSujRbEPxPSQHJJh1KXa0jDqItpljW7c3fwiglQ9S
 cxINkWthrR48gnOAsjOiUrK372ye/Ek1TXWvHyG0XLIuUhZVABqVqCQXn0SfUDRqtfR7UPYS
 LqvFLFhNRFOmoaZMqUfTNrvgB1dQev7ftTTZ2Xkg2CrGROB3a+BdqLvcmQZmT3ZUQ0Kyl9Pu
 3mBMgc6C2GqpGe24CVGM1Xpbgus9OB/rCj+VUoo10SRaFUn0bOp+xkTjPjaSvUJ37tCtj1z4
 zNzVE2w2d7bEb/i70JoYblcbNUh4VxGyXORtgpzOYalJrxjgVhWehp+vkfn3RF6Qotals1io
 HQvxQt0YaWWtTEJPzCV0Iv7PbrUAmLy5heqarPTnFbE35fe+6sC7ug5t0S2pBugRS9Auz1s1
 9hY1WfZ542fVlJDF8KsFBxuq14j+O2JB0t1r5nZ3nBtL6Su5zrL2tZyQfAg1g7lZNBHdqWNC
 A71FcQeQcmoMu0j3VazPXdmdKhf8rA5O8S+er6IwqmuaaxjkT+9hmNA46h20liL8ithT6jPx
 ZlPkJT6lkOXEizxilusqJW9mo1JfjoVGWmXwij+A4tQe6g0epwEQzTLQYX/1pB1gJjjXGRd/
 VioCgYd2cOnThGVakT0wQxa0Ul/TWWPoSKj1HQ0ljgoqvHaxynS26H5cwJBPGdXRW5khFOqI
 I6ujtlcUlL6JwQukRKk4w79yc057Ox8ImTISkBPfAD9L3tlV6qts/yFecEH5J4zsCpRWfixe
 hjAEu+780ZciXq/WTIBmHgybHmyt4/8ngBmhW74Tj47t3ffdcxqhF/e6NHaWf9Nz28DTSh8h
 yPQAwv0NN2o8NOI0pbb57rmBiTxC9sJKHWtlNzc507ZrSVwDBaynu6+gIjiGAk+imrg0sVyE
 D7PtFD6a5Xq0KKzNaRmeFNpDRny8ZkfeMk2n40uiZUXwXVfiI+S+C9Nkmr+Kt5c3qHWZ3oXQ
 jsK3tuT5xLqkh4GTDrB18fiW3ORz9E0Ldq3b3gd3SU+x8tKEqCR7aFB2yxvrRDryGCZKeg4l
 TAbx/w07XcciOxcowshwBKWBbUKFFVZNyjhxFyYqsqzp6JNaCOzYKC9gQBgyMu5AujI8WQ+E
 D7pP40vFihq4oBjPULQhTftv5r8doCYbMpP5EbJ1U6R164PdM13zr1Q2WJmIT6v4yFjkbVgy
 0Uwhdfi+9HWTgcltKOhXkwGaHusP5lVone1yvwG1seOg9LxQNM7RmRNDMOuFbXySHoTrai1a
 FzISWF68ybBX+KYRF/6ig8urmqTQc/3cSjNeT9Bi40lHUfVJVQD0llMDHNjwcF/Rkbyg5a4O
 EZhumJIuQW+80oQjLoub16mDAK97E+pcmtmEsDOakoLqFgYtwGNdpXBpuNrQ3MCp8Pn8VzLc
 z3BIVwPVDBBW1TYVQq6YP/0voiGqLLeXq3nfp6sKf2YoOhaHZ9k3LqJ1Y1rt3aJP8SLZTx5C
 uEjn1FERTZ/EtjYnDMGT2oWkTjMZoiVvkX0/Co/tc25/PnxPWCnrYKSF7tfN8lu8BGqkO+CM
 eCXniNwNTdf0NsF23bJzLEV2FNahTtpcnGhFrEJtCiFS6y1+OcfFxkAdyZ6L9dF9Yo51whJf
 Nbf05b7j+EkyPEyDFhBWBrqncToLc0GLmehNU/WUUaGMLPVQF+Di8rzYK66VfhRlLAO70z26
 WvdSRa/eG3cy2qMNVjnK+xHgSCFMQYLvYi8dk0oEm3/VJf9bQX9NtZrjDowyLlyh3XQNGdaP
 yIvFiEF5rCW8y5che1yXmJb6X8wZ+qJlj2S6O7bAp0Wq/xuAzlx0eVA7z5prtkdpDEBX/Fzl
 CbI+5R2pEq6l+CU1jd9eB9HqzIOnIbS+Es7Zvmf+Z5HVnLJuhkK6C/DbnZC78sgAdrptadKz
 9HJn6+mMzZO/eXf+s4EDtTVIsaKWJLAGR/gGTqRFA9cCDDyaj2ZiEtan/WfsHaSq8piwnADs
 JEOULheVUEwUPQABRY8dDTnCJx3RDQhkKOeyskS6ijmxCQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:eu/TrqHjvhyDDz/BpLqE2ceALOsnbusQ8zAXPo5KOHhom+ij5r
 uTdZUgpGfJYVMqMk3I9urwW5VoLUmsl6KdgrNhRItKPjOW3ldARbsKheCD/9SJIUzDH4VmpM
 BdmsZFebjN5JtB4foSIjPULz/t+ra6GWmT69vj8w==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,346,1654552800"; 
   d="scan'208";a="24730627"
X-MGA-submission: =?us-ascii?q?MDGitCRrdEttMjpN5XexGhy9RZaoVsr+NnnYXf?=
 =?us-ascii?q?P8aqpkm+nwK4iRZJ0Q0uPo4yyiBXKXqn3YL8YFkeG7sYVE6TdV6vMFmY?=
 =?us-ascii?q?ytNMSSbFduiAjyQxRRS7oP5sXGDo2h3Rh36b42LsrCl1lFNJYZUFIgkD?=
 =?us-ascii?q?dimevNn1hw+WhiJevO3oddZw=3D=3D?=
Received: from mail-pl1-f174.google.com ([209.85.214.174])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 20:52:43 +0200
Received: by mail-pl1-f174.google.com with SMTP id d24so7072461pls.4
        for <cocci@inria.fr>; Mon, 26 Sep 2022 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=NEB8Su2EmMGQStsf6g+FzyXWbmMpJR2zUjmG4cTznAk=;
        b=dwOcC6ZjH4thfu/Adyzlmm9mQY65uV3oa0oLKJsAYlnqsHKxSAnWiB+9TLG4RHTNLU
         fKvEuhQlFPLO3UBzZ+OoPF6+5ZocPulVTnJfIQN0+rRk5lS5qL/R1h9ZDyUL5yOGxCgG
         CicTIh/ZNLQx2tIVI+CUBsK42o0gRYF0h+2+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NEB8Su2EmMGQStsf6g+FzyXWbmMpJR2zUjmG4cTznAk=;
        b=NbTLm69N20Ca6G3mRCMjWADNveAR+XAJvorl2zG2gs9uSHbx6+OkvrhrReSzNgoA7S
         In8Dj/mA1lWguwyjD/VeYf1/1fxGSK4jaSpuiud3mWraZ1p2gjxQAARvZccbFouPGvyf
         a4Y+Y5ef8htks86QEKdozM+onTnGyyqoj+cMhYTOlUSrLYbi/Q0Ux05I4BtYOoIepIxP
         TM+7vppX4jYLn0U6QcjHMuWOad4Zpdy2SxWewaZo58l1zoYtcOjHrKfcA9xnEBWMj1u3
         nwCMKbH6kGur/Zj0bZmSAm/SVITgAAk3x18tSIgQxxsBWfC19mfxJKgyURdYmcRJKebz
         lceg==
X-Gm-Message-State: ACrzQf39Zri5U6bC3jwUyy+c1/LSTbeLh+IY/zXQdcEOJ/9AwWC46u9k
	OBnEBnGLzSRMnVXSdznJ9ZLCtQ==
X-Google-Smtp-Source: AMsMyM72DtGARIXgkdVnPzvRzOoCfJIC0d5dVlFJViBy658hdyNWbtfW9PPWIz8wL0bizoiyuvmFEg==
X-Received: by 2002:a17:902:d143:b0:178:456b:8444 with SMTP id t3-20020a170902d14300b00178456b8444mr23551412plt.137.1664218360484;
        Mon, 26 Sep 2022 11:52:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a408e00b001fd8316db51sm6816101pjg.7.2022.09.26.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:52:39 -0700 (PDT)
Date: Mon, 26 Sep 2022 11:52:38 -0700
From: Kees Cook <keescook@chromium.org>
To: cocci@inria.fr
Cc: Julia Lawall <Julia.Lawall@inria.fr>, linux-hardening@vger.kernle.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <202209260912.8DCCD70@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] spatch --jobs N missing matches?
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 590
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/202209260912.8DCCD70%40keescook>

Hi,

I have been unable to figure out what is going wrong with spatch doing
what seems like a simple match, but not finding correct results. Here is
the .cocci file:

----
// "level1" matches a struct ending in a flexible array.
@level1@
identifier inner, flex;
type T;
@@
        struct inner {
                ...
                T flex[];
        };

// "level2" matches a composite flexible array struct (struct ending with "level1")
@level2@
identifier level1.inner;
identifier outer, compflex;
@@
        struct outer {
                ...
                struct inner compflex;
        };

// match memcpy() which has a composite flexible array struct as the destination
@memcpy_compflex_dest depends on level2@
identifier level2.outer, level2.compflex;
struct outer *PTR;
expression SRC, SIZE;
@@

  memcpy(
*       &PTR->compflex
  , SRC, SIZE)

----

I am using spatch on Ubuntu 22.04.1 LTS:

$ spatch --version
spatch version 1.1.1 compiled with OCaml version 4.13.1

But I've also tried this with the latest from git with (worse?) results
(see below).

I'm using the same "include" options as generated by current Linux builds:

$ INCLUDES="-I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi -I ./include/generated/uapi --include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h"

And here are the other common arguments:

$ ARGS="--very-quiet $INCLUDES --cocci-file compflex-simple.cocci"

I'm running this against linux-next (20220923).

The first issue I encountered, was that the default didn't match for a
known case:

$ time spatch $ARGS net/sched/cls_u32.c | grep ^---

real    0m0.096s
...

Also it didn't work with "--all-includes":

$ time spatch $ARGS --all-includes net/sched/cls_u32.c | grep ^---

real    0m1.150s
...

In reading the documentation carefully, it seem the desired option is
actually "--recursive-includes" option, which _does_ work:

$ time spatch $ARGS --recursive-includes net/sched/cls_u32.c | grep ^---
--- net/sched/cls_u32.c

real    0m25.332s
...

This takes _much_ longer to run, though. (25 seconds vs 1 ...)

However, if I run this in parallel (using the options shown in the
kernel's build), it does _not_ find the hit in net/sched/cls_u32.c (?!)

$ time spatch $ARGS --recursive-includes --jobs 36 --chunksize 1 --dir . | grep ^---
6594 files match
EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_command.c
EXN: Sys_error("./sound/firewire/bebob/lib.h: No such file or directory") in ./sound/firewire/bebob/bebob_command.c
EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_transaction.c
--- ./fs/dlm/requestqueue.c
--- ./drivers/w1/w1_netlink.c
--- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
--- ./drivers/platform/surface/surface_acpi_notify.c
--- ./net/nfc/hci/hcp.c
--- ./drivers/s390/net/qeth_l2_main.c

real    8m50.993s
...

With the latest from git, it additionally misses "fs/dlm/requestqueue.c",
(but it takes half the time):

$ time ~/.local/bin/spatch $ARGS --recursive-includes --jobs 36 --chunksize 1 --dir . | grep ^---
6594 files match
--- ./drivers/w1/w1_netlink.c
--- ./drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
--- ./drivers/platform/surface/surface_acpi_notify.c
--- ./net/nfc/hci/hcp.c
--- ./drivers/s390/net/qeth_l2_main.c

real    4m39.263s
...

If I run it _not_ in parallel it is obviously MUCH slower, but ends up
finding _no_ hits at all!

$ $ time spatch $ARGS --recursive-includes --dir . | tee /tmp/slow.log | grep ^---
6594 files match
EXN: Sys_error("./sound/firewire/bebob/lib.h: No such file or directory") in ./sound/firewire/bebob/bebob_command.c
EXN: Sys_error("./sound/firewire/fireworks/packets-buffer.h: No such file or directory") in ./sound/firewire/fireworks/fireworks_command.c

real    66m49.620s
...

Do you have any idea what is going on?

-- 
Kees Cook
