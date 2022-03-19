Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CACBC433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=atJ5Q0nmCkiDskx+1rDg4fIKxclnHLQHn5Y7urPomaU=;
  b=X7k9VEYDqsc/6LxI7yIjIBol1Rzird2tJWJwxiNT3j9ejeAJSQvsgzZg
   631PvUgccN7pUx+KimiQs3RNtARx1T2F6spyEnYRsZ4mATgnjj1Pm/eBq
   xIGSeMlMs10taScSGgWmDvPGhxh17IEstvflXjQ8v9khEVCsS3bKM0Zoi
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26982163"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 09:20:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BF6CE01B9; Sat, 19 Mar 2022 09:20:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7CB5EE0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 09:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=atJ5Q0nmCkiDskx+1rDg4fIKxclnHLQHn5Y7urPomaU=;
  b=OLt5MaE4143iDD7/pgG7okO45j87CHD5ahOQAKg0fQbj0XaHSekqXHs1
   u/4J4wAkSfgJ1ar9s7Wq6NzzHNIKbm6/dcRQo9KvGu6HjdiO2S+AxB894
   cF3e4W3APppEt7FGHb3iqST02kyn+qRvuk2T1i29daKE7jRYT3ul3XTz4
   s=;
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9010915"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 09:20:04 +0100
Date: Sat, 19 Mar 2022 09:20:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Eric Wheeler <cocci@lists.ewheeler.net>
cc: cocci@inria.fr
In-Reply-To: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
Message-ID: <alpine.DEB.2.22.394.2203190919191.3204@hadrien>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 234
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/alpine.DEB.2.22.394.2203190919191.3204%40hadrien>



On Fri, 18 Mar 2022, Eric Wheeler wrote:

> Hi all,
>
> I have a bunch of structs with lots of members.  I need a way to compare
> to instances of those structs to see if they have changed.  The easiest
> way to do that is compare `if (a.j != b.j) { match() }` but it would be
> lots of tedious hand-typing all those if's, or doing a bunch of ugly greps
> and cuts on the .c files to hand-parse what I want.
>
> I would like to use Coccinelle to add all those struct member comparisons
> for me.  It would be really great if this is possible because there are a
> dozen structs each with lots of members:
>
> Lets say I have t.c as follows:
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
>
> 	f()
> 	{
> 	}
>
> The NOMATCH macro will stringify the struct members so I can print them
> for debugging.  For example, inside of f() I would like to add this:
>
> 	if (a.F != b.F) NOMATCH(a, b, F);
>
> I started writing this SmPL from what I've learned about Coccinelle so far
> and I don't quite have it working.  This almost works:
>
> 	@ r1 @
> 	typedef A;
> 	type T, FT;
> 	identifier F;
> 	@@
>
> 	typedef struct
> 	{
> 	    ...
> 	    FT F;
> 	} T;
>
> 	@ r2 @
> 	type r1.T;
> 	identifier r1.F;
> 	@@
> 	f()
> 	{
> 	    ...
> 	+   if (a.F != b.F) NOMATCH(a, b, F);
> 	}
>
> which produces:
>
> 	--- t.c
> 	+++ /tmp/cocci-output-7874-a515f6-t.c
> 	@@ -10,4 +10,6 @@ A a, b;
> 	 #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
> 	 f()
> 	 {
> 	+	if (a.w != b.w)
> 	+		NOMATCH(a, b, w);
> 	 }
>
>
> Can Coccinelle do this for all struct members?
>
> I tried playing with `<+ ... F ... +>` and `... when exists when any ...`.
> I've also tried `field` and `field list` instead of `type` with
> `identifier` withing the `typedef struct { ... }` braces.
>
> Note that the number of variables declared on a single line varies:
> 		int x, y, z;
> 		int u, v;
> 		int w;
>
> so I know that the `FT F;` part of the SmPL is insufficent, but I'm not
> sure how to address that to match all struct declarations.
>
> Ideas?

Why not just use

@@
identifier i;
field list fs;
@@

struct i { fs };

julia
