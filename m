Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B0EC433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:references:in-reply-to:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=OR5RwP7BKPT6IZmA/eZ7JuVR0DvYk6Ni8giKTs7dGnY=;
  b=T7RtQMnETAt5JnqtbSlQ7SeXlxwhwZ7CqJmenEVzGdPv0Gi2GuTsPAsz
   sFYZnRcJBl860i1q4Aztiw4uR8O42ksnbFdVGKuvSDDO5M6m+bRNUKtaZ
   2r5iPdJuGvBSdSOSgYOYRsdIg8ZeWWU3OAH05Y0bAaqkVf1+m6wOYhW1I
   w=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29753696"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 18:12:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BD8E8E033B; Sun,  3 Apr 2022 18:12:52 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A118CE00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 18:12:48 +0200 (CEST)
IronPort-SDR: UlXsHFGdT8OJFsKMFqZ2qliAorvT8gy5tYRx6NS5EiCGvAE4TsONMz42SyBqZ7T2+B1HQSIdP2
 6sllb5PABw2A4duYnL6wQLUzFZxOb/zljn1fcgaDRz+4lNf3JLFpBiQ1DELnryvV7nXTrTwucn
 T0lqPQkjnBCOIckGHBesxWHctMadIs+uq1gPXE7tAF3wU9u42jPz5ihhR6XmX+nh5ttpg2vDAU
 LSsss+kNnKhtbNzusstqzOIEdS8IK8x4Gtx6opCg+hCOg6eV5aQ6jpVU86kRf78swY3YvMdPxg
 XbBAlIQbfTpkTYWwfSG8XBbl
X-IPAS-Result: =?us-ascii?q?A0AcAAAEx0lify3QVdFaHAEBAQEBAQcBARIBAQQEAQGCB?=
 =?us-ascii?q?gcBAQsBgX8ogVUrBE+MemCIEgOJYIFGeAyQPYF8CwEDAQsBAUECBAEBhQcCh?=
 =?us-ascii?q?FoCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQ0LC?=
 =?us-ascii?q?QcICgIFDg4FYAFhAwFEgU+BdAsDMQ2CNSKDbAEBAQIBEi4BGx0BAwELBhADO?=
 =?us-ascii?q?BATEQEFAQEbBhMihUcBAw0hoW+BBD2MRwUXgQGCCQaESQoZKA1qOoEfAgcJA?=
 =?us-ascii?q?QgRgRkBjVN6JxyCDYFLgzKKRASZRwZ8EwGBHG2BGatllFpfgg5moDCWRZIKl?=
 =?us-ascii?q?l6mYwIKBwYQIxKBLIIVTSMVOzGCOE4BAgEBAQ0BAgEBAwECAQIJAQECjh03G?=
 =?us-ascii?q?lUBDoI9imA/NAIBNQIGCwEBAwmCOoMKJhMLAYl9AQE?=
IronPort-PHdr: A9a23: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
 SrW69Ni+hSozrTJxT1gXx5D7D1MgdDT1Xg=
IronPort-Data: A9a23:WFAcd63JIsMH4J3D2fbD5ed3kn2cJEfYwER7XKvMYLTBsI5bpzxTy
 WFNDD2FP/eLZGanc4h+a96yoUsEvpWGyYRnTVE43Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1/V4
 ouryyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt85ti
 /5/u8edcz1qM6uPwb4lQShgCxgraMWq+JefSZS+mcmazkmDfne1hvsyUQc5OooX/usxCmZLn
 RAaAGpVP1bT2qTsmOL9FrQEascLdKEHOKsWpHh6xDvxAvMvQJSFSKLPjTNd9G5o2pkSRaeDD
 yYfQRViNQ3LSF52A1JNApIakubzj3ChXiIN/Tp5ooJuuzSJpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zDOE9jehiraKk3+mHo0VE7K8+7hhh1j7KnEv5AM+S0f4isu30WOEYZFSL
 Q9NoBI8nJAqzRn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopY4BS7JWQDoqRYROLQbWN8KqS8Cj
 QDWwou4bdB7mPjEFiLHr+b8QSaaYHBNdQc/iTk4oRzpCuQPTak2hxPLC9tvSeu70oCzFjb3z
 DSH6iM5gt3/bPLnNY3koDgrYBr2/vAlqzLZAC2JBApJCSsnP+aYi3SAswSz0Bq5BN/xoqO9l
 HYFgdOCy+sFEIuAkieAKM1UQu35tqzZamWE2gE2d3XEy9hL0y78FWy3yGEuTHqFzu5ZEdMUS
 BOL6VIIvME70IWCPPIqOdzZ5zsWIVjITIy5DJg4n/JBZZ9+cALvwc2dTR/44owZq2B1yftXE
 c7DL66EVC9CYYw+lWbeb7pDjNcDm39mrUuOFMiT50n2itK2OS/FIZ9bagfmRr5it8us/l6Fm
 +uzwuPQlH2zpsWlMneJmWPSRHhWRUUG6Wfe8JcIJrbaclM5QAnMyZb5mNscRmCspIwN/s+gw
 513chYwJIPXiSKVJAOURGpkbb+zD59zoWhqbyMpNFesnXMkZN/3vqsYcpI2e5gh9fBinaYkF
 albJ53YD6QdUCnD9hQccYL5895veRGtsgSEYHiobT05SJh/SlGb4dTjZAbuqHIDA3Pv58szq
 rGtzC3BRp8HS1gwBcracqP9wFa4vHxbk+V3BhOaLt5WcUTq0Y5rNy2h1q9tc59QcU3On2LI2
 RyXDBEUofj2j7U0qNSZ17qZq4qJEvdlGhUIEmTe64GwP3aI82emx7hGT7/ULz3QUWXD+JKia
 /9Q+PfyPaBVh11NqYd9T+9mwK9itdvio7hWklZtEHnRNQ/5D7phJjyL0ZAKuPEQgLBevgSyV
 wSE/dwDYeeFP8bsEVgwIgs5b7TciatFxGGKtfllcl/n4CJX/aacVRkANRe7jiEAfqB+N5kow
 Lt8tcNKuRazjAEmboSPgixOrT/eK3UBV+AqushfDtO2zAUszV5GbNrXDSqvuMODbNBFM08LJ
 D6Ihfqd2+4NmBKaK3djR2LQ2ed9hIgVvEwYxlE1IVnUyMHOgeU63UEM/Dk6JuiPIs6rDw6u1
 qlX20xJyWGm+j5pgI1OUznpFV0cQhKe/UP1xh0Ck2ixo4xEkIDSBDVVBApP1BlxH6Fgkvxz8
 7SRyWKjWjHvFC009jVnQlZr8pQPUvQonjAvW6mb8wCtEJwzYD6jiairDYbNR90LHutp7HD6S
 SJWECqcpEE12eP8Y0H2NmVC6YktdQ==
IronPort-HdrOrdr: A9a23:n4tfQqkv1I/N1ErscRE6yQCyAOzpDfL43DAbv31ZSRFFG/FwWf
 re+MjztCWE9Ar5PUtLpTnuAtjnfZqxz+8W3aAwOvO4UBDiqC+0KuhZnPDfKl7balDDH4xmpN
 1dmsFFYbWabSkYsS+52njALz9J+ri6GcuT9IDjJhlWPGRXQp174xw8AgiWFVAefng/OXP7Lv
 ahDwh8ygZItU55Ui1zPBc4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10414095"
X-MGA-submission: =?us-ascii?q?MDF2qzWL+YG/yhF5qLDhN2C78FKTecWGuTMHBL?=
 =?us-ascii?q?jGFvTAh8QK4wX982ZMtkCH6ef7FHPEHVj1svBW1e9vIG05OdVoDH2E0l?=
 =?us-ascii?q?kUUeVDmKUT1tDUTgbRPRj/yYVKG7d115bwC0fkkZO+M65hDnAWFvkrXD?=
 =?us-ascii?q?J4ibDsQw/8p+DUu6LGm0wrOw=3D=3D?=
Received: from mail-ed1-f45.google.com ([209.85.208.45])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 18:12:47 +0200
Received: by mail-ed1-f45.google.com with SMTP id g20so8354058edw.6
        for <cocci@inria.fr>; Sun, 03 Apr 2022 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OR5RwP7BKPT6IZmA/eZ7JuVR0DvYk6Ni8giKTs7dGnY=;
        b=l60A6nhcBEYUVE4NCW4nJ9jwiJHphT9uls2bPzRjgChrsFwc2uoykNkP2msEp9C/AR
         Z8XDXDQPVTE9xYgE4toNJrp8S6kBwo0NQoS4Nnct3VoT6kgFJeSC9yWNEkln+AQimOfd
         FfJ8FFzwsaJ7pIr4lYekYlfU4KZWzgdxJ1A+wxHHBQ+N9GrSYn9J2FMzDKq0J0uYTNTU
         1TtQuWjJ28l6WqhvBjsXgChkZ+rBQZdBRnqrcXh1woTsscQfMrxBudYkjVxZdaqLgtPS
         d0wYN10+RVXnA/CtVw8QwEGk6g1TiP1VArknIQS4bKlJarRHMRb8OVVO/4nadfaq1NQa
         Q9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OR5RwP7BKPT6IZmA/eZ7JuVR0DvYk6Ni8giKTs7dGnY=;
        b=45A9UHI+SX6Lwm/AKFjT/rtaxbnac/XZpz65tAI6304fSESLSSF10fmdO+AgibtPaG
         qAEw5WLJ7w86fwdUtD2eMgNeIKlOw0B3KpGL2TPS3JCSDhaTAxmPyT4ATkAsrYGKXIFl
         3xnpQjpbYSNhyMGrdKpRBl/zr7TctG9c6d7NHthpSQ65SSlaBoSjBroRRnPcVA+sF9Mf
         +rG/tJwDjr5ufy2pERL53Vgw4XGsXjqC2yHPFNFLEojCW9hiuKTmQdLdziwNsXtqw9uX
         UzC4+o/eENv849rVPdg6UtKXdRCiD0SUf3zSBiOcpwHGOus3TIPhPpa6ZTu19hC7QhLO
         m05g==
X-Gm-Message-State: AOAM532/Tan2htShUIMODhl9FabzppQrqd53Q834pPVynRZ9DhGkwMwx
	5r9r4ItiuFFN6BUSODEZBxPPp4r229M=
X-Google-Smtp-Source: ABdhPJy/i21uUTEVye0gyhp/m6hGy/ZoVCF9fa3h3ej/kk5PDjOs6I8Q7WHHe7mzJUJD4GBfpGhBHQ==
X-Received: by 2002:aa7:c307:0:b0:41c:d381:d60e with SMTP id l7-20020aa7c307000000b0041cd381d60emr611634edq.184.1649002366754;
        Sun, 03 Apr 2022 09:12:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u26-20020a05640207da00b00419a14928e5sm3839763edy.28.2022.04.03.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:12:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1nb2qL-002Hcz-Ro;
	Sun, 03 Apr 2022 18:12:45 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
Date: Sun, 03 Apr 2022 17:58:54 +0200
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
Message-ID: <220403.86bkxikuwy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [cocci] using gcc & clang -MF to reduce spatch work (was: Using
 `parallel` [...])
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 349
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/220403.86bkxikuwy.gmgdl%40evledraar.gmail.com>


On Sat, Mar 19 2022, Eric Wheeler wrote:

> Hi All,
>
> Just a quick tip for others (like me) who are new to Coccinelle:
>
> You might already use this, but if not, here's a hint for doing lots of 
> replacements in parallel:
>
> 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
>
> If the SmPL depends on interactions between files then `parallel` won't 
> work, but if the changes work per-file then it runs much faster with lots 
> of big .c files.
>
> In cases where you do need to run over lots of files and they _do_ 
> interact, you might get a Stack Overflow error.  In this case set 
> something like this for 1GB of stack space:
> 	ulimit -s $((1024*1024))
>
> In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few 
> minutes and finished thousands of replacements!
>
> Julia, you might add this to documentation if you think it would be 
> useful.

To change the $subject to an alternate approach that may work for you,
and that I've been experimenting with.

If you use GCC or Clang to compile your C code you can use the -MF
option to emit a dependency tree for your *.c files, i.e. your compiler
is already doing all the work that spatch needs to re-do to find
includes.

But more importantly, if you have 100 files and change a *.h only used
by 10 of them, you'll only need to invoke spatch on those 10 files.

I had a question related to this here on-list in
<211116.86h7ccox6b.gmgdl@evledraar.gmail.com>, i.e. you can use
--no-includes and instead feed the list of files to be included to
spatch. If those files come from your dependencies made with -MF you
migth be able to assume they're correct.

Well, not if your *.o file is newer than your *.c, as it might have
grown new includes, but in this sub-example you'd make your *.c.cocci-ok
(or whatever) generation depend on the corresponding *.o, or would
otherwise compile first (which is much, much faster than spatch,
especially with ccache).

I don't have any stand-alone example for use, sorry, but basically in
make syntax something like:

	# get dependencies from our last compilation
	-inlude $(wildcard *.mak)
	# next compilation
	%.o: %.c
		$(CC) ... -MF $@.mak -MT $@ -MT $@.cocci-ok $<
	%.o.cocci-ok: %.o
		spatch ...

I just typed that up now, and there's sure to be syntax errors etc, but
I think you get the idea, i.e. you'll save yourself spatch work by
bootstrapping from your C compilation.

Also note that you don't need to run GNU make, if you build with
something else you can (with a tiny bit of munging) change the make
syntax it emits to just a list of files to depend on (the easiest way to
parse it being to invoke a make one-liner to spew it out for you).

I think it would be really useful if spatch could spew out the list of
headers it understood from a given file.

Depending on your compilation (e.g. ifdefs) the two may not 1=1 map, but
you could also do this CC trick in reverse, i.e. if you ran spatch first
you could feed the resulting dependency graph from spatch to your C
compiler.

In pracice I haven't found reason to worry about that lack of 1=1
mapping.
