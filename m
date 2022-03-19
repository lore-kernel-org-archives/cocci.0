Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AEEC433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=1VSjSDcokgrSxArF329ttQIo69XIppKpBd38+By6tHw=;
  b=IOYoYnnBzKQm0ka23XIC8v+6Rj93uH3LsW0ELcmy5TPr5UZ5W8prwEPd
   z8jCLVPjxMYk1oCq5NyIcVzOlHML34HmbxSQzX6EAPxfeaOFAPluHIsg1
   31Vat7HVBDh6PM0SBlfOA8UzGnLeAotksfCCoZl8YMLx5SNsXsQK361Mu
   0=;
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
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="26963948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 01:51:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ADB04E01B9; Sat, 19 Mar 2022 01:51:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 48206E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 01:51:55 +0100 (CET)
IronPort-SDR: 5ujEHAtzfxMMpTiAoiKB5ZF+Y5H8FXMLTlMIYSSQd3RDQPD9MWUz4jbSHUe92zO5BBzDaRIkVC
 zvI8VmRggxhR/5voYFZSjiwSQGq6DuO3CbdOqKoR+4n0PZLNZsr/MOD2nSw8KI7iVp6ljvjmbC
 sVt8t9YU/S+EZIxKENycx+/ZGHRNuHmftmuBPOAhqeXt4+kgk1fcuUgG3TzR+vFX+lqgyaBQEu
 lvg1/z2+e8UkWXLpYNdhnwbXsOOwACErFTYSvPm1WhDvAFGtsfW2AAVYceX+HVH7u7oBLySSAB
 RKjiur+HQUyYJMmslFw5FsaO
X-IPAS-Result: =?us-ascii?q?A0CiBgD1JzVi/0Xcza1agQmEAgeBTQEBASkEC5Yznl4LA?=
 =?us-ascii?q?QMBDUEEAQGFBwKEMwIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQEAYEILAFjAWcBgU4BgXkGBD2CNSKDawEBAQECATpPCxguV4MdgnYhrQl4g?=
 =?us-ascii?q?TOBAYl7gTyOSSccQIFNgTwMgQmBPjA+hRKFMgSXFnKBD4EwQKNGnGeBLoNTn?=
 =?us-ascii?q?14GFC6WSZF0llunAoE/OSWBWR8UGggmCjuCak0BAgECAQwBAgIBAgECAQIBC?=
 =?us-ascii?q?AEBAgGOKBaOTiEBAQFpAgYLAQEDCY9OAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:eTJwkKtcKLbrVoTu4S7QINmgV+fnVHVYMUV32f8akzHdYApBsoF/q
 tZmKW/SMvbcMDCnL99wbNzg8BxQvZLVyIM3SVA+pX03QnkbgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCY0idfCc8IMsboUsLd9UR38g52bBVPyvX4
 Ymo+5aGaAf/s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnaeCYFguP4Deof1eczloHRF1GbYc16CSdBBTseTLp6HHW378hfhxDEw7OYACvOB6HQmi9
 9RBd2tLNEjewbjsmPTlG4GAhex7RCXvFIgYsXph5TXYFuo9B53cQ6jH4dJCmjE9mqiiGN6EO
 ZtHMmszN3wsZTVGH1NOBakZg9v3oVfxam16qAPKgrMOtj27IAtZi+Sza4uKKrRmX/59lUGTr
 WPu5HX8GhhcNdqFyDPD/GjEuwPUtSbrHo8NFLC18vNwxlue2gT/FSH6S3OAk9DmjU+TSetGa
 Gw0yiQepowprmO0G4yVswKDnFaIuRsVWtx1GuI86R2Qxqe83zt1FlToXRYaN4N77J5eqSgCk
 w7Wz4mwVFSDpZXMESrFnop4uw9eLsT8EIPvTSoUCwYa49TupIwpyBTCUr6P8ZJZbPWuSVkcI
 BjQ8EDSYon/a+ZRj81XGnie3VqRSmDhFFJd2+kudjvNA8MQTNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsrxRUM/VxX3WEL5cdF1M2xpjGGaA6bKIN8J+nwlBBlb5IN44DM9Wey+FzfroiReyP
 BGI6FwBjHOiFHa1baJ6Z4+rCsIhiPC5fekJpdiPBuejo/FZKme6wc2ZTRXJjj63zxR0z/1X1
 FXyWZ/EMEv2wJ9PlFKeL9rxG5dyrszn7W+MF5390Tq91r+SOCycRbsfaQvcauEi8LjCrRrV/
 ttbOtHMzRhDCbWsbi7S+I8VDFYLMXliX8yt8ZQKL7LaL1o0AnwlBt/Q3aglJd5vkZNVofiUr
 HuzbUlVlQjkjnrdJATXNH06MOHzXYxypG4QNDA3OQr6wGAqZIuitf9Nd5Y+cbQ92vZkyPp4E
 6sMd8maW6QdTjXc5y9bYIb9oYFmeQ7tgw+SZnL3bD86dp9mZgrI5t69JFe0rnFTV3buuJJn8
 bO61w7dTZ4SfChYDZ7bOKC10le8nXkBg+YsDUHGFdlkZxm++oZdLSGs3OQ8JNsBKEidy2LCh
 RqWGxoRucLEv5QxrIvSnamBooqkT7l+E05dEzWJ5Lq6L3CHrG+zh4JfUOuFeT3HEmX55Pz6N
 +lSyvj9NtwBnUpL6tAgSOwzkPtivta/9aVHyglEHWnQawr5AL1XIk6ZgZtFuJpLy+ILogCxQ
 E+Op4dXYO3bJMP/HVcNDwM5deDfh+oMkzzf4KhnOkn8/yMrrrOLXV8LYkuJmGpQM7t4PYco2
 6EntdJPs16zjR8jM9CniCFI9j3WcidaC/h+6sgXUN3xlw4m6lBeepiCWCX415G4dIkeOEcdJ
 DLJ1rHJgK5RxxecfiNrR2TNx+dUmb8HpAtOkA0ZP12Ml9fI7hPtMMa9LdjjosVpIhR7PyZbP
 3gtOlJ1KKiK8i0ugsVfN4xp98etGzXBknEdCXNQ/IEac6VsfmjMN3Emf+uS/E0U929GOD5W4
 Nl0DYojvSnCJKnMM+hbZaKhg/jiVsBqsADdmM2qG8mfWZ83fVIJR0NoiXUg83PaPC/6uKELS
 SSGMgq9hW0X+BP8e5EGNrQ=
IronPort-HdrOrdr: A9a23:4sFPj6GxxMNFFW7GpLqE5MeALOsnbusQ8zAXPiFKOHpomq7xra
 +TdZsguyMc5AxxZJhko6HjBEDiewK6yXcW2/h1AV7KZmCP0wbFEGgh1/qH/9SKIVycygcy78
 ddmndFYuHNMQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="26963943"
X-MGA-submission: =?us-ascii?q?MDGG+NJKMaGhWxsfxTbNy6IdUlFnNMbfgbVRxz?=
 =?us-ascii?q?CtQC+xeJfAWWl3MOvkGZid8A0jS7zdt2aUDDmKMYl7WvmRIltzAubVom?=
 =?us-ascii?q?4um3PdZijFVj3nQeSz+bRiXz3irj+iYAbAyt/g6jfq4lbIjvAleP393u?=
 =?us-ascii?q?IPhMa87ViblgTaDh5tm3vhww=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 01:51:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 14A3081
	for <cocci@inria.fr>; Fri, 18 Mar 2022 17:51:51 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Vow0gAbPm7HI for <cocci@inria.fr>;
	Fri, 18 Mar 2022 17:51:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id D3D2240
	for <cocci@inria.fr>; Fri, 18 Mar 2022 17:51:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net D3D2240
Date: Fri, 18 Mar 2022 17:51:48 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
In-Reply-To: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
Message-ID: <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 231
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/75237f17-66ae-21c3-8796-c656315d99d0%40ewheeler.net>

On Fri, 18 Mar 2022, Eric Wheeler wrote:
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

Oh!  Adding another ... and changing + to ++ did it:

	@ r1 @
	typedef A;
	type T, FT;
	identifier F, j;
	@@

	typedef struct
	{
	    ...
	    FT F@j;
	    ...
	} T;

	@ r2 @
	type r1.T;
	identifier r1.F;
	identifier r1.j;
	@@
	f()
	{
	    ...
	++  if (a.j != b.j) NOMATCH(a, b, j);
	}

which produces:

	--- t.c
	+++ /tmp/cocci-output-19090-251154-t.c
	@@ -10,4 +10,16 @@ A a, b;
	 #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
	 f()
	 {
	+	if (a.z != b.z)
	+		NOMATCH(a, b, z);
	+	if (a.y != b.y)
	+		NOMATCH(a, b, y);
	+	if (a.x != b.x)
	+		NOMATCH(a, b, x);
	+	if (a.w != b.w)
	+		NOMATCH(a, b, w);
	+	if (a.v != b.v)
	+		NOMATCH(a, b, v);
	+	if (a.u != b.u)
	+		NOMATCH(a, b, u);
	 }

So, hurray for the SmPL ++ operator!  Also it doesn't look like I needed @j.

Is this how you would approach the problem?

-Eric


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
> 
> -Eric
> 
> 
