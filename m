Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0011EC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=8XoVJMDZ6gBg/tz5iTwaIcARvt9qV7QmBCBDYhnbVyo=;
  b=Kbnk+/djKznYAP7SQ1EiOdkVwg14++QaqxoA7gXCApWMFL+ZEKiapFCD
   JB9K5Eqt2gzdQyTuBNrun8wV+gqYNoSNjDodVWxdKj6GFVX/SALgDXQX6
   wRWv9P5KURNjfjgoBKv2+6S95hbzvosGNLb95RROsx46KpreapIIJ4i3H
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27037278"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 23:38:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE305E020F; Sat, 19 Mar 2022 23:38:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 69C2AE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 23:38:14 +0100 (CET)
IronPort-SDR: GjUNOfmEXlNFKx1kGsFjkZUhPiLYeAGhKBqLxQfoWSyYJZGLgSeKvApb0ALoWRjT0FBTOPFNpb
 W92r91VWnf4kUdvoOItyEGYBEpAM756+OwEBk1L9+y5NnbdaizZXK2GASyL75rI9DQ9R4g4UPh
 syUeZ+p+oBwLdbzV0bdPl88SKqElQRQ0OlIUjHMn8tffxsvJmtzaQFeAuZ8legblssjKE63xH1
 kBnZe/uuOE1v5xCqzSRNX3Z3XGc+43o6nDg55p+uSwW1z32MUhuKuevyvUboRoUw5JDorjnrtE
 6o8zGHOCoKqXvDX7HM9DjNz+
X-IPAS-Result: =?us-ascii?q?A0BEAwC/WjZi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuCK?=
 =?us-ascii?q?JxjgXwLAQMBDUEEAQGFBwKENAIdBgYwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBB?=
 =?us-ascii?q?QEBAQIBAQIEBAGBCCwBYwFnAYFOAYF5BgQ9gjUpAYNjAQEBAQIBOj8QCxguV?=
 =?us-ascii?q?waDF4J2IaxyeIEzgQGJe4E8jkknHECBTYE8gwM+iiIiBJgIgQITAYEcFIFyo?=
 =?us-ascii?q?AGCFZ4Wg1OfXhoulkmRdZZbpwKBPyI8gVkfFBoIJgqDJU0BAgECAQwBAgIBA?=
 =?us-ascii?q?gECAQIBCAEBAgGOKBYVjjkhAQEBaQIGCwEBAwmRcgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:jQ1jjKyJXmKf62oIJU96t+cMwCrEfRIJ4+MujC+fZmUNrF6WrkVVz
 zBKC2vXOKqLYTejLdgga9u0pEJXvJWHx4M2QAY9pFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 IKq+KUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPh4k
 tpmip2UeDwRN52Rs+UabSd6FAphaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY3J8WRqmEP
 ZVxhTxHbgj4OxJRM00tLqk+tua43UWmfxJTpwfAzUYwyzOPklcgj+iF3MDuUteNTs5Utl2Jo
 3rPuWX/GBATctKFoRKB+22lguvnjyL+UpgbUry+7P9jxlOJrlH/EzUTRR22vvm0h0qzQZRZJ
 lB8FjcSQbYa/RakZeb8eyyDmHe04zUdXORuMeoR91TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mO0c8PV6S9H6+LKFCrMnluAhXbjZnhPdD5qiTosFFNdu7HeTJcPYgUjp+uP/Yawnpv4BjH9z
 jSHtm44iql7YS83O0eTpgGvb9GE/MShousJCuP/BTrNAuRRPdHNWmBQwQKHhcus1a7AJrRB1
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOA3gE2Q8hxp2v9phZPmLy8Bhklfy+F1e5fJ1fUj
 LL7414PjHOtFCTCgVBLj3KZUJh0lvm/RbwJp9jZcdpDb5x8bg6B92Q2PCatM5PFyyARfGBWE
 cnzTPtA+l5BUPU5lmXqH7lBuVLprwhnrV7uqVnA50zP+dKjiLS9EN/p6XOCMbI06r2qugLQ/
 4oNPseG0UwPAun/eTXMt4MMLV0HKXUhQ5b7t5UPJOKEJwNnHkAnCuPQmOl9INY9wv0Jz+qYr
 GugXkJ4yUbkgSOVIwu9akd8NOHlU6F5oC9pJicrJ1uphiYuON798KcFepIrVrA77+g/n+VsR
 vwIdpzYUPRCQzjK4RoHapz5oNAwfRinn1vebS6keyQkOZN/RwHE/tL+OA3i6HBWXCawsMI/p
 Zym1x/aGMBfHF46UZ+KMf/2lgG/p3kQnu52TnDkGNgLdRW+6pVuJgzwkuQzfZMGJyLD8STGh
 QyYNhEV+LvWqIgv/diU263d99W1E/FzF1ZxFnXA6erkLjHT+2euzNMSUOuMejyBBmr49L/7O
 LdQ37fxL/0KkVJHqcx6HqoylfAy4N7mprl7yAV4HSyRMw/xUu45fiCLjZtVq6lA5r5Fog/oC
 EiBzdltJunbMs3SFlNMdhEuaf6O1KxKl2CKv+g1Okjz+AR+4KGDDRdJJxCJhSEBfqF5Npgpn
 bUotMIMslHtjwpsP8mGgy1Q+n7KKHEcCv11upYfCY7tqwwq1lAbO8CHUHeruc3WZoUeKFQuL
 x+VmLHG2eZWyH3CRGVvR3LD6uxQ2MYVsxdQwV5feVnQwojZhuU61QF6+CgsSlgH1Q1O1u9+N
 wCH7aGuyXliK9upuCRCY4xoMwRRQhCG+kH8z1YT0mvUUyFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmcyX35SnDnY8H80y8/QwhjpuCLoRmdMOHdsJjPIilGdqXWpRLhg7SyfiwFtBvqDMc8ngvBq
 PUCECOcr0HkHXZ4npDXwLV2GVjdpN5o6YCCrTxcEHs1IFzh
IronPort-HdrOrdr: A9a23:9i2SWaBRPF6CxenlHemo55DYdb4zR+YMi2TDtnoBMCC8EKSj+P
 xG88506faZslcssTQb6LW90cq7MBXhHPxOkO0s1N6ZNWGM1QeVxcNZnOzfKlbbak/DH4BmtZ
 uIrJIVNPT7BzFB/KXH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27037227"
X-MGA-submission: =?us-ascii?q?MDGj475SpaTg6jWf6m1z5ELycu7wE1r6ncbPH2?=
 =?us-ascii?q?Y7z3P7AirPBI0q/MbIDP+Kuwj6Ot68OAmLwhIZ0X21foP6mp3uE9/Xdc?=
 =?us-ascii?q?d+qqT3pftOP2/PzUUfXMVFJgBflKuYGdDq4J1XXseN89t0/9Dd46MJsx?=
 =?us-ascii?q?ECnmK/FtMDmnTjhcKd0YOiRQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:38:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id A61C848;
	Sat, 19 Mar 2022 15:38:10 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cnLP2x8KMt0v; Sat, 19 Mar 2022 15:38:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id BACA940;
	Sat, 19 Mar 2022 15:38:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net BACA940
Date: Sat, 19 Mar 2022 15:38:07 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
Message-ID: <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 257
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/75def6a3-d1d3-8b7a-87c6-a74e685c48%40ewheeler.net>

On Sat, 19 Mar 2022, Julia Lawall wrote:
> On Sat, 19 Mar 2022, Eric Wheeler wrote:
> 
> > Hi All,
> >
> > Just a quick tip for others (like me) who are new to Coccinelle:
> >
> > You might already use this, but if not, here's a hint for doing lots of
> > replacements in parallel:
> >
> > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> >
> > If the SmPL depends on interactions between files then `parallel` won't
> > work, but if the changes work per-file then it runs much faster with lots
> > of big .c files.
> >
> > In cases where you do need to run over lots of files and they _do_
> > interact, you might get a Stack Overflow error.  In this case set
> > something like this for 1GB of stack space:
> > 	ulimit -s $((1024*1024))
> >
> > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > minutes and finished thousands of replacements!
> >
> > Julia, you might add this to documentation if you think it would be
> > useful.
> 
> I'm not sure what you are trying to do.  You can give spatch the name of a
> directory and the argument -j N for a number for cores N, ad it will run
> in parallel on the files in the directroy.

Oh really? Well, nevermind what I said then.

However, that could be a documentation bug:

I don't see -j in the `spatch --help` output.

--
Eric Wheeler


> 
> julia
> 
