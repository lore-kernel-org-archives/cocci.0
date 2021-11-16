Return-Path: <SRS0=hYZ6=QD=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D860C433EF
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 13:43:51 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33961A09
	for <cocci@archiver.kernel.org>; Tue, 16 Nov 2021 13:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE33961A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3891701"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Nov 2021 14:43:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F41E8E00D0; Tue, 16 Nov 2021 14:43:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 83522E0092
	for <cocci@sympa.inria.fr>; Tue, 16 Nov 2021 14:43:47 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=avarab@gmail.com; spf=Pass smtp.mailfrom=avarab@gmail.com; spf=None smtp.helo=postmaster@mail-ed1-f43.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AeQN7rBdInZN120znMP7U89XKlGM+TN7LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWQG96BoK4Uw6qO6ua8AzRGuc7A+Fk5M7V0Hycfj?=
 =?us-ascii?q?ssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd?=
 =?us-ascii?q?6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAuroQnLuMQan4RuJ6kyxxDUpndEZ?=
 =?us-ascii?q?/layXlnKF6Ngxrw/Nu88IJm/y9Np/8v6slMXLngca8lV7JYFjMmM2405M3vqxb?=
 =?us-ascii?q?OSBaE62UfXGsLjBdGGhDJ4x7mUJj/tCv6rfd91zKBPcLqV7A0WC+t4LltRRT1l?=
 =?us-ascii?q?SoILT858GXQisxtkKJWpQ+qqhJjz4LIZoyeKfxzdb7fc9wHX2pMRsZfWTJcDI2?=
 =?us-ascii?q?yYYQBDOUOMvpDoonhu1cDtweyCRW2Ce7tzDJDm3/43bc90+QkCQzDxRIgEMgUs?=
 =?us-ascii?q?H/JsNj1LqESUe63zLHO1zXbb+5d1Cr/6IfSaBAhpOuDXal3ccrX1EIiEBnKjku?=
 =?us-ascii?q?Kpoz/JTyazf8As2ee7+V6VOKvj3QrpB12ojiq38ohjJTCiY0JxF7e7yp53Jo1K?=
 =?us-ascii?q?sOiSE59edOqHodcuS6GO4doQs0vXWJltTgnx7AIu5O2fCYExps5yhPQaPGJfIy?=
 =?us-ascii?q?F7BL+WOuRITp0mHJodr27ihuw9UWs1/PwW8+p21hJtipIisfAumwJ2hDJ6cWKS?=
 =?us-ascii?q?uFx8lm91TuMzQze5e9JLVgqmafUMZIt37A9moQJvUjeACP6hF/6gLKVe0gg/OW?=
 =?us-ascii?q?j9v7pba/8ppCGMo95kgH+Pboqmsy4Gek4NxIBX2mf+eilyrLs4FD1TKxEjvA5n?=
 =?us-ascii?q?KTVqp/aJcMcpq62Bw9azJwv5Aq4DzejyNgYnH8HI0xZeB+fkYTlJ1XDLOr7APq?=
 =?us-ascii?q?/mVigjitnyvPcMrDuDJjBNn3Dn63gfbZ55U5c0g0zzdVH6p1OFLEOOujzVVXqu?=
 =?us-ascii?q?9HDAR85Nha7w+fjCNlnyoweXmePDreDMKzOqV+I+v4vI+6UaYAJvzbyN+Qq5//?=
 =?us-ascii?q?1gH8imV4deLGp0oENZHC5GPRmOUSZbmD2jtcPC2dZ9jY5Geftg1aDeT9VfXe7G?=
 =?us-ascii?q?awmtR8hD4fzo5nKXMiEmrqP3rmhhtV8ZGlcD1mXFnGgI4yaUu0FYgqdJ8Zglno?=
 =?us-ascii?q?PUr33GNxp7g2nqAKvk+kvFeHT4CBN7foLO/B64uTSkVc58jkmVqx1MkmIRmBw2?=
 =?us-ascii?q?24EHno4gPs5rkt6xVOOl6N/hq4AfTS2z/xMWwY+c5Xbyr4iY+0=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3A6gRWQqwwRS0t3M+lweN6t+dsxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDskhDECmzcWDDuCOK2CMWL2ft11aI6y/U5Xv5WGzIJnOVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OlUbC?=
 =?us-ascii?q?cYEideCc9IMsfoUI78wIGqtUw6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kurPyc0lPT7KLeAbS0TxZXK+thhUErSs3uko5HKBEOAEH1nPTx4A3lI4lWZ+YE?=
 =?us-ascii?q?W/FOoXFhu0HWhNwHCR3PKkA87jCSZS6mZfDnhSYIiGEL/JGVRlqZ+X04N1fCmZ?=
 =?us-ascii?q?F/v0wMyEIdhnFhuSswbv9RPMEuyiJBN2zadlZ5WU5mGmfVeJ8FMiFGfSbvMsDi?=
 =?us-ascii?q?W9229QRSN/AQ+EcTRZvSDXJRSFVHmkWLYZnxLLywiCmZ1W0s3qQrKszpmXflUl?=
 =?us-ascii?q?/jOOrP93SddiHA85Smy6lSqv91zyRKnkn2Ba3k1JpM05Ah9MjWQv+UYMWUbC0r?=
 =?us-ascii?q?7tk3AbVyWsUBxkbE1C8pJFVT2bWt813cyQpFugG9MDeN3BHivHyWhS5pDiPuRt?=
 =?us-ascii?q?0tx94Dbgh8A/UokbLy1/xO4XHJwKtrPQpscY3QXoh0VrhcxbBbdBwmOX9dE9xP?=
 =?us-ascii?q?Yt4Yd9/1eb54IPCieI5odM53uTe?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgQ3ypK72lZ7i7WQ36gPXwPLXdLJyesId70hD?=
 =?us-ascii?q?6qg7IiYlF/Bw9vre/8jzuiWbtN98YhwdcPG7Sc29qBDnlaKdg7NxAV+iNDOW31?=
 =?us-ascii?q?dARbsKhbcKqAeOJ8SIzIRgPMlbH5SWcOeAb2SS0fyKhjVRrr0bq+W6zA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CSAgCttJNhfyvQVdFahlprjUqFa4Ili?=
 =?us-ascii?q?xt3DJIcCwEDAQsBAT8CBAEBh2gCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ0?=
 =?us-ascii?q?LEAg4JoVoDYI1IoQELgEbHgMSEEsTEQEFAQFWhSQBAy+fTYEEPYxHBReBAYIJB?=
 =?us-ascii?q?oRIChkoDWk5gR4CBwkBCBGBF45THIINgUuIRIUwBI8rTSGBDQGCc6pdlBdeggV?=
 =?us-ascii?q?gnzSVaJFElhShG4RpAgoHBhAjEoFDgX1NIxU7MYI4URkPjisBFoNQil9AMzgCB?=
 =?us-ascii?q?gsBAQMJgjqDCiYTCwGMBAEB?=
X-IPAS-Result: =?us-ascii?q?A0CSAgCttJNhfyvQVdFahlprjUqFa4Ilixt3DJIcCwEDAQs?=
 =?us-ascii?q?BAT8CBAEBh2gCHQcBBDQTAQIEFQEBBQEBAQIBAwMEARMBAQ0LEAg4JoVoDYI1I?=
 =?us-ascii?q?oQELgEbHgMSEEsTEQEFAQFWhSQBAy+fTYEEPYxHBReBAYIJBoRIChkoDWk5gR4?=
 =?us-ascii?q?CBwkBCBGBF45THIINgUuIRIUwBI8rTSGBDQGCc6pdlBdeggVgnzSVaJFElhShG?=
 =?us-ascii?q?4RpAgoHBhAjEoFDgX1NIxU7MYI4URkPjisBFoNQil9AMzgCBgsBAQMJgjqDCiY?=
 =?us-ascii?q?TCwGMBAEB?=
X-IronPort-AV: E=Sophos;i="5.87,239,1631570400"; 
   d="scan'208";a="3891692"
X-MGA-submission: =?us-ascii?q?MDFDldaY3Lpw809sOs2fzyPQh+AfEMK0K3Lj1l?=
 =?us-ascii?q?YazCALYv4UO9fTcTD4xm9Bqt7qnvHpZutxgkwK0iOkgEsqPcBo8rKteL?=
 =?us-ascii?q?2T4IRqiYaZdaqEviEkfJB7M0+l3LGhzY7MlwDxK50BSUqzMpNOfjmrM3?=
 =?us-ascii?q?Ta1ReMVIUNJtlrDIDZSxuXUQ=3D=3D?=
Received: from mail-ed1-f43.google.com ([209.85.208.43])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2021 14:43:47 +0100
Received: by mail-ed1-f43.google.com with SMTP id m20so42229824edc.5
        for <cocci@inria.fr>; Tue, 16 Nov 2021 05:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:user-agent:message-id:mime-version;
        bh=FyXqJgxiGXFUvhFVQA2PZ0s870j4ssoHTNxwutaFVdo=;
        b=FP+keIWSUUqybReYrpoHMKdZskB7d3EQ0fo8UHX2gb0YucdmwZ6x0c+djLy3rfUXdd
         SyO+GkdcKLQwGDsGmwKJpPBGSCgc68DyEu2Wge+FeZfjOJ17DVeQymA7Hb6GiRZCdMRW
         BVMe++FW80xnmjFFXarn1V3TNy5SFyI8fYRvJVFJyx2fIgpBpvAxLzeStec7ELspDt48
         FCey9HWWlSsGmOtTM/BId4wt6XLdKC+Gyf/akd6v7N1B+2hwG12eFQ+qsZOdFEe+Ubbs
         05qzAymVmA7Eb9byv3QPW26i4cp8Ykbkfkc9owj4eHg2QrMzZpV6hI/sMepPqKJIjHbp
         0hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:user-agent:message-id
         :mime-version;
        bh=FyXqJgxiGXFUvhFVQA2PZ0s870j4ssoHTNxwutaFVdo=;
        b=SNTBlmRmpZGD2OisPLk/uhMA/eTGZUvPpcfYtd3LNSnDPSct+xwrjUqOc9Kb9mEkvI
         xs9yUQRcRwcM/CHuCv0dOfB2IDDiK9aaIh46nAoOu9Fwc8X6gl/FnJtkZQq0flOJmKp2
         15Cs3Q2rDthdL6FxPTm+LxzqqGGg+bvmCBSuR1fQl8dD9MGGDs1wcD/HXyHjYC7tQvVb
         ceWSAQ38CGaS1xU2Ux7Zo9/1rD1UnPdmPCdZjJLdxRLSWlwk2NfPFoy3tbd1iqW7TtsK
         x102XgIeppEKAV1wte9ijnTwLqV6HfX+IF45s0U2I34xRbJGXt/AqVEGyeKe5+Zuo7qN
         NN1w==
X-Gm-Message-State: AOAM533vz/jvPLi9jBIQ3cNHQjCazmJihTBbmvr1X68w5ZKv0eCBzuZm
	xh/KM8Fy7jWfWglhcj3OFnxdHBs9Sc6fUg==
X-Google-Smtp-Source: ABdhPJzLtHw7YXWPC266EYJ/EQy7E9R5LaFiAeJxWZzcp/2q0WTAaHPnWCXaloeokyonc0d96iIU0Q==
X-Received: by 2002:a05:6402:5251:: with SMTP id t17mr10213273edd.397.1637070226051;
        Tue, 16 Nov 2021 05:43:46 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c7sm8429149ejd.91.2021.11.16.05.43.45
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 05:43:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1mmykT-001Qje-Bt
	for cocci@inria.fr;
	Tue, 16 Nov 2021 14:43:45 +0100
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: cocci@inria.fr
Date: Tue, 16 Nov 2021 14:27:41 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
Message-ID: <211116.86lf1op65q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [cocci] Is there a --no-includes --but-includet-this foo.h
 --but-in[...] mode?
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 102
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/211116.86lf1op65q.gmgdl%40evledraar.gmail.com>

[First time poster, long time spatch user, thanks a lot for providing
it!]

I'm trying to optimize the runtime of spatch in git.git by leveraging
information that's already in the Makefile. Both GCC and Clang know how
to spew out information about what headers a given file depends on in
"Makefile" format, e.g. for a "hook.c" in git.git:
    
    $ cat .depend/hook.o.d 
    hook.o: hook.c cache.h git-compat-util.h compat/bswap.h wildmatch.h \
     banned.h strbuf.h hashmap.h hash.h repository.h path.h sha1dc_git.h \
     sha1collisiondetection/lib/sha1.h sha256/block/sha256.h list.h advice.h \
     gettext.h convert.h string-list.h trace.h trace2.h pack-revindex.h \
     oid-array.h mem-pool.h hook.h run-command.h thread-utils.h strvec.h
    [...]

I wanted to feed that into spatch somehow, but with e.g. --include it
will not include anything:

    ~/g/coccinelle/spatch.opt --sp-file contrib/coccinelle/strbuf.cocci --verbose-includes --no-includes --include cache.h --include path.h hook.c
    init_defs_builtins: /home/avar/g/coccinelle/standard.h
    HANDLING: hook.c

It seems that there's --recursive-includes, --all-includes,
--no-includes etc, but those all tweak different aspects of
auto-discover, or "seed" the auto-discovery via --include.

But I'd like a way to say "here, exhaustively, are my includes", does it
have such a mode? If not consider this a feature request.

Even better on top would be to further optionally tell it due die if it
ever encounters an include file that's not explicitly provided on the
command-line.

That would serve as a nice sanity check on the *.d files we get from
gcc/clang, and make sure that this way of optimizing its runtime works
as intended. I was planning to do that by parsing its output, but having
it as a native option would be easier.

Note: I probably don't *really* need this, since I can look at the *.d
file myself and have "make" determine if spatch needs to run at all, and
I trust the gcc/clang information well enough.

But being able to have spatch use that information exclusively would
also be nice, especially for the above mentioned sanity check.

Thanks!
