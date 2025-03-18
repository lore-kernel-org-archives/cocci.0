Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C4BC28B28
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z6Z8hKpUOQSIwurw4oUAzExyudyPCnPbtIHFumOhask=;
  b=Tfr3LruawxXgdJdejiAUVp2/DHclYovaEF0+XKNEarRr3OaQql6haiBR
   H97+QM706qkEHgbojcuvGikEFNH9p8toVDVjXF6ZdEwul+prOcWUqSG+l
   frjVpOhQg4SQhDhh5cnqVv/oYeiQisfCo9lVD5+z8AEJfkD3jQEEu7lYY
   U=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213430585"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:43:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26AF2E0264; Tue, 18 Mar 2025 10:43:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D58A3E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 10:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=Z6Z8hKpUOQSIwurw4oUAzExyudyPCnPbtIHFumOhask=;
  b=H6P9SUOzxLUbrUXLcK35dLAXWghbmRpBIV35NKQYOZ+RZVwYC7PS+xG0
   5HC1+iGabZR6jCA6ger+j6Iy/oAtp/l6k8OOZx5uCm2H9V4YvXposazD5
   aiyAX+3BcT0qeboppwti6KtPuMBoOq7N4x9QPXR1DJjbwSWeX6LyOSwOD
   U=;
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213430565"
X-MGA-submission: =?us-ascii?q?MDFx9CsegztH+Rl6sVcmWay9cDEtQKx4VC1PTx?=
 =?us-ascii?q?vH2CY+vzqQeXjRb0vVjLPLsn7EVOHtXTTzTMPN3C9wmbD2EXgvVM0cCx?=
 =?us-ascii?q?YFwZdWb9Nxwly5w/WABBOc4cpTkI6b/H63v8HiHv8FUHgGIXOMQaghrn?=
 =?us-ascii?q?K43ZFZLoGujKVRmxSAGyDJXw=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 10:43:39 +0100
Date: Tue, 18 Mar 2025 10:43:37 +0100 (CET)
From: Ella Ma <xutong.ma@inria.fr>
To: Edgar Khachatryan <khachatryan.edgar@student.rau.am>
Cc: cocci <cocci@inria.fr>
Message-ID: <903617126.10749233.1742291017746.JavaMail.zimbra@inria.fr>
In-Reply-To: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
References: <CAN1=rvJBSpCq35PY-tTFomZ17wNBRN=bNV4vwKTV-TgYe38FdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [128.93.82.115]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - GC134 (Linux)/10.1.5_GA_4734)
Thread-Topic: Detecting Use-After-Free and Analyzing CMake Projects
Thread-Index: ch0d7TfMt6o5ngo4+A5sDELjh0CTcA==
Subject: Re: [cocci] Detecting Use-After-Free and Analyzing CMake Projects
Reply-To: Ella Ma <xutong.ma@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2606
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/903617126.10749233.1742291017746.JavaMail.zimbra%40inria.fr>

Hi Edgar,

I have been using coccinelle for months. Here are my non-official suggestio=
ns.
You can also wait for the answers of other experienced users.

----- =E5=8E=9F=E5=A7=8B=E9=83=B5=E4=BB=B6 -----
> =E5=AF=84=E4=BB=B6=E4=BA=BA: "Edgar Khachatryan" <khachatryan.edgar@stude=
nt.rau.am>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "cocci" <cocci@inria.fr>
> =E5=AF=84=E4=BB=B6=E7=AE=B1: 2025=E5=B9=B43 =E6=9C=8810=E6=97=A5, =E6=98=
=9F=E6=9C=9F=E4=B8=80 =E4=B8=8B=E5=8D=88 3:39:10
> =E6=A8=99=E9=A1=8C: [cocci] Detecting Use-After-Free and Analyzing CMake =
Projects

> Dear Coccinelle Team,
>=20
> My name is Edgar Khachatryan, and I am a student currently working on a
> project that involves static analysis of C programs. I am particularly
> interested in using Coccinelle to detect use-after-free bugs.
>=20
> I have found and tried to use the kfree.cocci semantic patch provided for
> the Linux kernel. However, when I run the command:
> spatch --sp-file kfree.cocci file.c
>=20
> Although I am certain that file.c contains a very simple use-after-free
> example, Coccinelle reports the following message:
> No rules apply. Perhaps your semantic patch doesn't contain any +/-/* cod=
e,
> or you have a failed dependency. If the problem is not clear, try
> --debug-parse-cocci or check whether any virtual rules (e.g., report)
> should be defined.

The cocci file scripts/coccinelle/free/kfree.cocci contains two virtual rul=
es
controlling in which way a detected bug should be reported.
So you should run coccinelle with any of them defined,
e.g. spatch -sp-file kfree.cocci file.c -D org
or  spatch -sp-file kfree.cocci file.c -D report
or both.

The error message you received indicates that there are no rules to be exec=
uted,
which includes a transformation rule with +/- changes;
a noting rule with * changes, which will be transformed into a - rule;
or a script rule to be executed when dependencies can be satisfied.

There are no transformations in this script,
and all two script rules depend on virtual rules,
so nothing will be executed unless any declared virtual rules are defined.

>=20
> I also tried running it with --debug-parse-cocci, but I am still unsure h=
ow
> to proceed. Could you please advise me on how to properly apply Coccinell=
e
> to detect use-after-free issues in simple test files? Am I missing specif=
ic
> steps or dependencies when using kernel semantic patches on general C cod=
e?
>=20
> Additionally, I would like to know if there are any recommended ways to r=
un
> Coccinelle on CMake-based projects. Is there an established method to
> integrate Coccinelle with CMake builds, or any workarounds you would
> suggest for analyzing such projects?

Coccinelle will not try to handle the compile commands.
So you can analyze any source code files no matter how the project is organ=
ized.
You can use -dir option to analyze all .c files in a directory,
together with -include-headers to also analyze all .h files.

E.g. when I analyze a project, I usually use the following commands:

/path/to/project$ spatch -sp-file sp.cocci -dir . -include-headers -j `npro=
c`


ella

>=20
> I would greatly appreciate any guidance, documentation, or best practices
> you can share on these topics. Thank you very much for your time and
> assistance!
>=20
> Best regards,
> Edgar Khachatryan,
> Russian-Armenian University
