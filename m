Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AD9C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EA01C7txw8rHYHrkwH0dIJfsbqESKHb73L3OxadCphc=;
  b=InZA6a19aRNoaJJ8EjUYfYvjEswurcEO7mHJWS73UAPsqVBsZgGH1Zq9
   /A6WJTvZmO6hzLyccpIQXlXIWElmtYq4am1/CwDHu1V5JXwwxiEH0rsJj
   Hmonb8f85k/zQum8bcZZcAQpt1dNZ0+E6c7JNtKWch2jmfDX9h2V2vOiw
   c=;
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
   d="scan'208";a="26963752"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 01:45:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED631E0210; Sat, 19 Mar 2022 01:45:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 11475E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 01:45:07 +0100 (CET)
IronPort-SDR: isKz4ud3fU95c0PTCAcSOIOm7F7g0O40E8fEHGUiBT4Kn7TnrLok+NHR1Rox2HwqRTdxtOdQl1
 hP2O3sikc8Y1bPb51zJq3N4K8AWkf54SuIBqGZfTcdm3OWiBsl1AzdArQh2r2YoW2qI399Qab1
 MLpSuOTluDsaK+7UVbjmoZevSJ9GU6exy8n4nhGR/8WmuV0ALVMDRKz6xCxvJbgSKeEzIGdUNO
 pHXKxT0dsSdOKAJQxPVB09uA6/8Wv7yV1tDNdSUtA0K84rdv7kYYAorAaPyImr/Qn9geTk3U0n
 opvDh8iE+EehH/kJN7FcFbhp
X-IPAS-Result: =?us-ascii?q?A0DnBQDMJjVi/0Xcza1agQmBWoIoB4FNAQEBKQQLmVmbO?=
 =?us-ascii?q?AsBAwENQQQBAYk8Ah0GBjMGDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQEAYEILAFjAWcBgU4BgXkGBD2CNSKELIUUgxetfoEzgQGJe4E8jnAcQIFNg?=
 =?us-ascii?q?UiBCYE+hgCFMgSXFnKBD4EwpAacZ4Eug1MFn1kaLpZJkXSWW6cCgT84JoFZH?=
 =?us-ascii?q?xQaCCYKO4JqTQECAQIBDAECAgECAQIBAgEIAQECAZ0MIQEBAWkCBgsBAQMJj?=
 =?us-ascii?q?04BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:ijqjsqg3zeWbg2sl1t1SoJbCX161QxYKZh0ujC45NGQN5FlHY01je
 htvUG6OMqveZjegKdFxaoW1/R4C68XWyINnQAE+/CA0RnhjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSPYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Npll7f3bVkLYJP1o9s2aydqMwokIpBm5+qSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNayAN
 pRCNmYwBPjGS0ESeVYaGapipfz2rWPCchBf8GC0vINitgA/yyQqjOa2YYWFEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmDO9VZ0SGbC8++QshlCProAONPEIfXmQ5t3nqBCAYulgA
 HQqyAoF97cP1FP+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8Lo3uqJOoQXZmUeN4F+5afaURRvh
 wDZxYq4bdB6mOTNESr1y1uCkd+l1cEowYIqYD9CQBQF7tTnrZt1iB/TJjqCLEJXpoalcd0T6
 2rWxMTbu1n1pZRTv0lc1QmZ6w9AXrCTEmYICvz/BwpILmpRPeZJnbCA51nB9upnJ42EVFSHt
 3Vss5HAsL9TU8ncxXfdG7Rl8FSVCxCta2G0bblHRMZJythQ0yT+I+i8HhkhTKuWDir0UWS1P
 hSC5lM5CG57MWSqYKJzbpiwDc9vlfGIKDgWfqu8UzePC7AvHDK6ENZGPhfBgTqyzBByzcnS+
 /6zKK6RMJrTMow/pBLeegvX+eZDKvkWyTyBSJbl4Q6g1LbCNneZRa1cYAmKb/sl9+WJvwXY/
 tJSLY2MxgkGCL/yZSze8IgyK1EWLCFhWcus85EOKreOclh8BWUsK/7N2rd/KYZrqKRiibua9
 H+KXEIFmkH0gmfKKFjUZyk7Oq/vR5t2sVkyITcoYQSzw3EmbIv2tPUfepI7cKMJ7utmyfIoH
 fAJd9/ZUqZLSy/b4HIQcpnwoYhvblKtiB7XZ3ipZz02fphBQQ3V+4a+IlC1rHRXUnO67JJsr
 aeh2wXXRYs4az5jVMuGOuiyy16RvGQGnLwgVUX/Iu5MJBfm/r9sJnGjlfQwOcwNdEvOn2PIy
 waMDB4EjuDRuItposLRjKWJoor1QetzGk1WQzvS4bqsbHSI+3rlzJBAXeuMcCqbUm7oof3wa
 eJQxvD6EfsGgFcT6dYnSe42lP5n6ou9vaJewyRlAG7PMQahBIRgFWbaj8NBgatAm+1CsgysV
 0PSpNQDYeeVONnoGUI6LRY+arjRzukdnzTfsaYvLEPh6HMl9baLSxwPbRycziFCLLZ4NI4/h
 +EspJdOuQC4jxMrNPeAjzxVrj7QdSZYDvx775xKUpX2jgcLy01ZZcKOACHB4KaQN4dGPH4sL
 2LGn6HFnbldmxTPKiJhCXjX0ONBrp0SoxQWnkQaLlGEl9etaiXbB/GNHeDbjzi5zymrF8p2K
 i5mKE14KKGD5XFuidQrs6VA3e1eLEXxx6Az4wJheK7lo42AUm3WMHZ7NPmN8U0d/ngaeDVHl
 F1dJKAJTh6yFPwcHUIOtYpNr/34Ucc3+xLClc2jEt7DGZQmCdYgbmlCekJQwyba7QgNaIEra
 AWkECucqUE2CMLIn5AGNg==
IronPort-HdrOrdr: A9a23:/uA7Na7mIq/reYb42QPXwNjXdLJyesId70hD6qkRc20wTiT7//
 rAoB1173HJYVoqOU3I+urwXZVoI0msl6KdiLN5VdzOMDUO01HYT72Kg7GD/9Q+IUfDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="26963747"
X-MGA-submission: =?us-ascii?q?MDGolwWDklb9PL/mXQ89bsc/90C6r3yFOYcZCh?=
 =?us-ascii?q?dbPai9rFzbhqsj7lU30WWqnkPX+6s7c9+gmL++OW7X3JdGugGitkbIOY?=
 =?us-ascii?q?blACQQeYQ1K1kNiME3szaIzMpxgB/SEPXASVsULAb8Th3heKVncN0jvh?=
 =?us-ascii?q?awo0Xf1A7bQnjV+e9umCb3RA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 01:45:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id EC9CA81
	for <cocci@inria.fr>; Fri, 18 Mar 2022 17:45:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m40dRTtKwpmL for <cocci@inria.fr>;
	Fri, 18 Mar 2022 17:45:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 1405040
	for <cocci@inria.fr>; Fri, 18 Mar 2022 17:45:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 1405040
Date: Fri, 18 Mar 2022 17:45:00 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Can fields from structs be used added code as expressions?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 230
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/a2422ea-5dd9-753-cf9b-97439e7db462%40ewheeler.net>

Hi all,

I have a bunch of structs with lots of members.  I need a way to compare 
to instances of those structs to see if they have changed.  The easiest 
way to do that is compare `if (a.j != b.j) { match() }` but it would be 
lots of tedious hand-typing all those if's, or doing a bunch of ugly greps 
and cuts on the .c files to hand-parse what I want.

I would like to use Coccinelle to add all those struct member comparisons 
for me.  It would be really great if this is possible because there are a 
dozen structs each with lots of members:

Lets say I have t.c as follows:

	typedef struct 
	{
		int x, y, z;
		int u, v;
		int w;
	} A;

	A a, b;

	#define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);

	f()
	{
	}

The NOMATCH macro will stringify the struct members so I can print them 
for debugging.  For example, inside of f() I would like to add this:

	if (a.F != b.F) NOMATCH(a, b, F);

I started writing this SmPL from what I've learned about Coccinelle so far 
and I don't quite have it working.  This almost works:

	@ r1 @
	typedef A;
	type T, FT;
	identifier F;
	@@

	typedef struct
	{
	    ...
	    FT F;
	} T;

	@ r2 @
	type r1.T;
	identifier r1.F;
	@@
	f()
	{
	    ...
	+   if (a.F != b.F) NOMATCH(a, b, F);
	}

which produces:

	--- t.c
	+++ /tmp/cocci-output-7874-a515f6-t.c
	@@ -10,4 +10,6 @@ A a, b;
	 #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
	 f()
	 {
	+	if (a.w != b.w)
	+		NOMATCH(a, b, w);
	 }


Can Coccinelle do this for all struct members?

I tried playing with `<+ ... F ... +>` and `... when exists when any ...`. 
I've also tried `field` and `field list` instead of `type` with 
`identifier` withing the `typedef struct { ... }` braces.

Note that the number of variables declared on a single line varies: 
		int x, y, z;
		int u, v;
		int w;

so I know that the `FT F;` part of the SmPL is insufficent, but I'm not 
sure how to address that to match all struct declarations.

Ideas?

-Eric

