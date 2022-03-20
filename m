Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F412C433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=n58CokxmhwL1YCJy6iDbkP5ftM75uzyJCmDXbRut1Yg=;
  b=DtHUb5Me1eN5SbEdiGOm6K+UtoCvkdczvPeP8VuGWimWVzDC7bsFKOJ8
   R0eDmxeftKDBArOYn2PuNnvAWm+jLiBMKMqrw1L7cFvSksB4IuNqFScSB
   +OvoT2P4nQdfLK3s1kZ1QXvB0lvoy7jAYzMBgqZlgFyHZVKz75zUJkWU1
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27104839"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 22:19:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 07A9CE020F; Sun, 20 Mar 2022 22:19:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8430EE0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 22:19:02 +0100 (CET)
IronPort-SDR: UPJZZSPtFCkey4ZVOce7Wftj/4enpGC0qA0PvR4jBlvaLuLobzz+F+kiL2V3WLN0mEO6BFxk18
 b/mWBOQiCpWrekp8VlDsn9h0XLvjb7+4knlllxVK7zEq+BAa1isf2CPtiTmaX55upzivoq+GG1
 ib2KRbbfyFEHQ6zwMZa5/yQ5XrRm6nKZLmRjTJATU/8ktqgG0PLJ9EhuD6zVf1BQyj1xw00fid
 0t80TzWIDfNJS44B3Idgwp6pDEt3sd50dSUPNMdeOPpKE8l2gsVpugg25N8uETvZJFWFyiw7eU
 fUywmYsaCxsOvMCF+mJpWsRk
X-IPAS-Result: =?us-ascii?q?A0AWBQBrmTdi/0Xcza1agQmEAgeBTQEBASkEC5YwA4Qfm?=
 =?us-ascii?q?kALAQMBDUEEAQGFBwKENAIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEAVYyLAFjAWcBgU4BgXkGBD2CNSkBg2QBBTo/EAsYLlcGgxeDF60yg?=
 =?us-ascii?q?TOBAYl7gTyOSSccQIFNgRUngwM+iiIiBJgIgQITAYEcAhKBODqgAYIVnhaDU?=
 =?us-ascii?q?59eBhQulkmRdZZbpwKBPzklgVkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBC?=
 =?us-ascii?q?AEBAgGOKBYVjjkhAQEBaQIGCwEBAwmRcgEB?=
IronPort-PHdr: A9a23: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
 A==
IronPort-Data: A9a23:XCG4+qrFQoPj+DWxoZOzwji8QnteBmLSYxIvgKrLsJaIsI4StFCzt
 garIBnUbPuINmr9Ko9ybomw/U0E6MTUm9AySQRkpS8wQSNAp+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHkZqTZMEE/Nszo68wICqtMu0IDR7z+l4
 4uo+ZWEYgf9gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSXZ1c5Eondvd9MfBd+CH1mII9N0efudC3XXcy7lyUqclPp07NjE0E7MIkV4KBxDH0mG
 f4wcW9WKErb2qTsmur9FLgEascLdKEHOKsUvXprzBndDO06WtbOXKXH6NtVxnE2i9wm8fP2P
 ZVAMWY/N0iojxtnPkdOLaAQwbmUvXTOSH5x8F6Xhroq7D2GpOB2+OOxboGEJYziqd9utk2fr
 WnH13/oBwkTct2Z0zuMtHy27sfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPWZXutG8mgizRNJSJ
 kgZ4GwooLRaGFGXosfVeDPosFKgrzsnCvVeNfZm8ByvwYOMylPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQBSXK2ppWG1rejL8GvjUcQBBSpTOn9eFFptD8zL+dlr1nryosBf/LlZZ+AZ9Bn10
 3aHsygzirEel4gN2rnTEbH7b9CE/cmhou0dvFm/soeZAuVRP9bNi2uAsAez0Bq4BNzFJmRtR
 VBd8yVehchXZX13qASDQf8WAJai7OufPTvXjDZHRsd9qGv0py/zLd8AvVmSwXuF1O5fIlcFh
 2eI52tsCGJ7Zib0BUOJS93Z5zsWIVjIToi7DaGLPrKik7B8aw+K8SVjf0+W1CW1ySARfVIXY
 v+mnTKXJS9CU8xaIMyeGL9FidfGB0kWmwvueHwM50/+gOTEOyLNF+tt3ZnnRrlR0Z5oaT79q
 753X/ZmAT0GOAEnSiWIo4MVM34QKn03WcL/p8BNL77RJgt9BHpnBuDRzL4ldpYjmalJz7+a8
 na4U05e6Vz+mXyec1nRMCg+Me+2UMYtt28/MAwtIU2shSopb7Gv27hDJZE5Sr8qqb54xvluQ
 vhYJcjZWqZTSi7K8ig2ZIXmqNAwbwyigA+DZnL3YDU2c5N6aRbO/9voIlnm+CUUV3rlscolv
 6bm2xzbTJcHSh4kCsvKMar9w1S0tHkbueRzQ0qReIUIIh2xqdQzJnWo3PEtIswKJRHS/Reg1
 l6bUUUCuO3Ag44p692X16qKmIeeDLcsFERtGWSGv629MjPX/zf9zNYYAvqIZz3USEj95L6mO
 bdO1/j5PfAKwARKvo57H+o5xK4y/YKy9bpKiAl7HHjGa1mxTLVtPiDej8VIs6RMwJ5fuBe3A
 xjToYMCZOzVYc61QkQMIAcFb/iY0a9GkDfl7cMqfBfw6hhx8efVSk5VJRSN1XJQdeMnLIM/z
 O49k8cK8Ajj2AEyO9OLg3wG7WiKNXBcAawruotDXd3umkwm1VFPbJjREGnw7Y3WM4dANUwjI
 zm1gqvehu0GmhGYKydqSSHAjbhHmJADmBFW11tcdV6HrdrymaNl1hNm9zlqHB9eyQ9K0r8tN
 zEzZVF1P6iH4xxhmNNHAzK3AwhECRCUkqArJ4DlSIENo4iUum3xwKkVPPbL8V8Z/m9YcyId+
 ryEoIogvfAGY+mpthbem2Y8wxAgcTC13gnDg9y8WcmaH5Q3ZTf/xKmjeQLkbvch7dwZ3CX6S
 CoDwAq0Qan6LjIL5aAkC4SX0bkKDhaJOASuhB2nELwhRQnhRd155dRCx41dtC+AyzwmPHJU0
 /BTG/8=
IronPort-HdrOrdr: A9a23:4A9IHq/IG8klXun6hpRuk+DhI+orL9Y04lQ7vn2ZhyY7TiX4rb
 HKoB1173XJYVoqNU3I3OrgBEDiewK/yXcW2+cs1N6ZNWGMhILrFuFfBODZsl7d8ljFh5dgPN
 BbAs5D4bPLYWSS9fyKhzVQROxQpOW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27104834"
X-MGA-submission: =?us-ascii?q?MDENDyiyWrvjE+TKBuwGssdFhY142BPL3T855X?=
 =?us-ascii?q?v8E5bCvjj/Yg4SR32r1ADGh7WpGtRQzbZop/lhT9OwwSz+X7+L1vLKIw?=
 =?us-ascii?q?mW5+54aAIgxccgwtbFsKCPHPUMSpMpnhyy0Nt+B8706vAzfMqroYEmTQ?=
 =?us-ascii?q?qCkQhKpj4UxqpjcJt8b+lPTQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 22:19:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 8014981;
	Sun, 20 Mar 2022 14:18:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xYHy1cE8sM_P; Sun, 20 Mar 2022 14:18:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 9763B40;
	Sun, 20 Mar 2022 14:18:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 9763B40
Date: Sun, 20 Mar 2022 14:18:56 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
Message-ID: <21f037cf-d0b8-8b25-163d-1d46c3a1f1d0@ewheeler.net>
References: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net> <alpine.DEB.2.22.394.2203192038220.3204@hadrien> <75def6a3-d1d3-8b7a-87c6-a74e685c48@ewheeler.net> <alpine.DEB.2.22.394.2203200732590.3429@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Using `parallel` to run over lots of .c files and
 avoiding stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 264
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/21f037cf-d0b8-8b25-163d-1d46c3a1f1d0%40ewheeler.net>

On Sun, 20 Mar 2022, Julia Lawall wrote:
> On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > On Sat, 19 Mar 2022, Julia Lawall wrote:
> > > On Sat, 19 Mar 2022, Eric Wheeler wrote:
> > >
> > > > Hi All,
> > > >
> > > > Just a quick tip for others (like me) who are new to Coccinelle:
> > > >
> > > > You might already use this, but if not, here's a hint for doing lots of
> > > > replacements in parallel:
> > > >
> > > > 	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c
> > > >
> > > > If the SmPL depends on interactions between files then `parallel` won't
> > > > work, but if the changes work per-file then it runs much faster with lots
> > > > of big .c files.
> > > >
> > > > In cases where you do need to run over lots of files and they _do_
> > > > interact, you might get a Stack Overflow error.  In this case set
> > > > something like this for 1GB of stack space:
> > > > 	ulimit -s $((1024*1024))
> > > >
> > > > In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few
> > > > minutes and finished thousands of replacements!
> > > >
> > > > Julia, you might add this to documentation if you think it would be
> > > > useful.
> > >
> > > I'm not sure what you are trying to do.  You can give spatch the name of a
> > > directory and the argument -j N for a number for cores N, ad it will run
> > > in parallel on the files in the directroy.
> >
> > Oh really? Well, nevermind what I said then.
> >
> > However, that could be a documentation bug:
> >
> > I don't see -j in the `spatch --help` output.
> 
> It's there, but there are many other options, so you may have missed it:
> 
>   --jobs          the number of processes to be used
>   -j              the number of processes to be used

hmm... is there a new version or does my OCaml not support the feature?

]# ./spatch.opt 2>&1 | grep jobs
  <no output>

coccinelle-git]# ./spatch.opt --version
spatch version 1.1.1-00106-ge65a6dd compiled with OCaml version 4.05.0
Flags passed to the configure script: --prefix=/usr/local/coccinelle-git/
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

-Eric
