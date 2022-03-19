Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00707C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ADklu0T3ua1zdK4hrE7XbavjK23bIXjyhLBKBtWZ42M=;
  b=MibL7KcDVp3H59XPry5N8Lr8nhaB2eIZdEDxDtzUsCsw6ZVhDnr9FPa6
   jdbiGrBLluvArPC4XiIUT40qE4X618XNJbtPqP2TmQUON9rCfJ9kcEzkH
   Xsf7ZByf7FmqxVmJwN19KgMRG9glS0t3pp18v1dWkQEAZMTz4889v229Z
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26982380"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 09:23:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E527E01B9; Sat, 19 Mar 2022 09:23:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6778DE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 09:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ADklu0T3ua1zdK4hrE7XbavjK23bIXjyhLBKBtWZ42M=;
  b=ns0FgLGgGkDd2aArzHuonYNFS1zkOPtfvg9fGrbXit8pydH2NTLCKXIN
   pOPF6tngZ+BR1k8j/nj79aS1oicfxNQcGxqAinKLLqfDQH+ThtGAEnbrQ
   jzaMHsWBuD9+gO6B5ZiHiP86lK3YdQ1cAdl/nLfSyJMqOgPbJT+9m7oJV
   w=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9011041"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:23:44 +0100
Date: Sat, 19 Mar 2022 09:23:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug with '*' to display a match on the subsequent rule.
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 236
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203190922070.3204%40hadrien>



On Fri, 18 Mar 2022, Eric Wheeler wrote:

> Hello,
>
> I may have found a bug:
>
> 	@ r1 @
> 	type T;
> 	identifier I;
> 	@@
> 	*T I;
>
> 	@ r2 @
> 	@@
> 	f()
> 	{
> 	}
> 	+void a(){}
>
> which prints this error:
>
> 	init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
> 	File "cocci/broken.cocci", line 12, column 0, charpos = 57
> 	  around = '+',
> 	  whole content = +void a(){}

You can't mix * and + in a single semantic patch.  The patch you get would
be strange.  There would be a + for the code that you want to add and a -
for the code that you want to highlight.  If you want to make changes and
find out about some things, then you can use some python code to print out
whatever you wnt.

julia

>
> but if I remove the '*' or turn it to a '-' then it works:
>
> 	@ r1 @
> 	type T;
> 	identifier I;
> 	@@
> 	-T I;
>
> 	@ r2 @
> 	@@
> 	f()
> 	{
> 	}
> 	+void a(){}
>
> with the diff:
>
> 	--- t.c
> 	+++ /tmp/cocci-output-6974-08cd95-t.c
> 	@@ -5,11 +5,13 @@ typedef struct
> 		int w;
> 	 } A;
>
> 	-A a, b;
> 	-
> 	 #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
> 	 f()
> 	 {
> 	 }
>
> 	+void a()
> 	+{
> 	+}
> 	+
> 	 // functions here
>
>
> Here is the t.c file:
>
> 	typedef struct
> 	{
> 		int x, y, z;
> 		int u, v;
> 		int w;
> 	} A;
>
> 	A a, b;
>
> 	#define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
> 	f()
> 	{
> 	}
>
> 	// functions here
>
> --
> Eric Wheeler
>
