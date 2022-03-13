Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0194C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 01:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ooXqwb11wdOX2/gXl9fy9kRSCvyxZDshl7dzhctZx/c=;
  b=PcCoXmegcXyuG3dwdTZ6nFLB6QEExf685URN4jUyhtGS9LRFjMgPzDX0
   CuLSOuQPjhmUW7mFHecYB7tqeanZKFjyXsAwRQDH0UqnmK71SoS9cIYm1
   u0c7qHAVoTzua5NZ+4JerMEoQY3W6eVrVmRiCA0BiDkXNJ4+KyiX1J59M
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
X-IronPort-AV: E=Sophos;i="5.90,177,1643670000"; 
   d="scan'208";a="25823513"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 02:20:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED631E006C; Sun, 13 Mar 2022 02:20:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CF30E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 02:20:44 +0100 (CET)
IronPort-SDR: 3MCBQXrCMTzztcv38nexdm0t1lRLp6unxAqEeUIyrTTrNEsf0NjbhhoWnQra+4JwNhQ7yN0kad
 X8hSTTIPLEDwOiRu4Xg+rCjejHyH7kdXtMTMxHaVXTk526BXdoVApSn2sZlshiXEliE4p8yDkw
 X1qsdLABBQjv38L1z3FVc1aIMZMkxdul02D6JZDUhS/pYCCpNpWtXPH0E7jk7C1p+XhZA+rWm4
 RX8uCuvSgzq8COwvQ8LWM4LoNtJG6fCbkTWt6B6ZP2e7YCIcpqx+TNzLrZ2u9pmQNSVZdlsI9U
 +xwAuuLj3TCk2yRakaT7eZMP
X-IPAS-Result: =?us-ascii?q?A0AMBgA/Ri1i/0Xcza1aHgE8DAILFYFagigHgU0BAQEpB?=
 =?us-ascii?q?AuWAoNXmU2BaAsBAwENQQQBAYktAh0GBjMGDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSKEGROFFIMXrkeBATKBA?=
 =?us-ascii?q?Yl7gTyGFBRCiAUcQIFNgTwMgQmBPoR+ARIBboUyBJcmgjSBf5ITjWaCFZxlg?=
 =?us-ascii?q?S6DUwWJaJVpBhEDLpZGkXGWV6FDgVWDY4E/OCZpcB8UGggmCjuCak0BAgECA?=
 =?us-ascii?q?QwBAgIBAgECAQIBCAEBAgGdDSABAQFpAgYLAQEDCZJlAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bBbLqaKtxaSeVtz5FE+Ry5MlxSXFcZb7ZxGr2PjKsXjdYENSgz0Dy
 2sZCD3Vb/qPM2Knfdtxadi+8kNXscDWzYUxG1Md+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFrX4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhgoF3k
 PEQlayKcywGJvORtd40T0ZAKnQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9Gdr2Z4RQK22i
 8wxd2tfdTfjQiVzKlJIJqgyovn53WnVbGgNwL6SjfFrvTOCk1wZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXOFz0hKA4jShme/CkCf2QsQUGaHQGuNWbEO72z0VUDlLdWuBm9KWkhDjduh2N
 xMMw397xUQtz3CDQt74Vhy+hXeLuB8ARtZde9EHBBGxJrn8uFnGWzBVJtJVQJl3659sHG1CO
 kqhxouxXVRSXKuppWVxH4p4QBu3KW4YMm8PaCsJV00D7sWLTGAPYvDnFYYL/E2d1IGd9dTML
 9ei9XVWulnrpZRXv5hXBHie699sz7CQJuLP2i3ZX3i+8iRyb5O/aoqj5DDztKgcc9/AFQfY7
 CBVxKByCdzi67nWyURhp81WQ9mUCwutamCC6bKRN8dJG8uRF46LJtwOu2AhdC+Fw+4JZj/kb
 UveowJX79oLZROXgVxfOOqM5gVD5faIKOkJodiPN4sQOMctLFHblMysDGbJt13QfIEXuflXE
 f+mnQyEVB720Ixrk2i7Qfkzy7guynxszG/fX8mrnRCmyqaFInOKSboINFaUKOY08Prc8gnS9
 t9eMeqMygleCbeiOXOPrNdPdF1af2ImAZ3WqtBMcrDRKARRGFY+V63bz4QndtE3hK9SjOrJo
 y+wAxcK1FrliHTbAgyWcXQ/Oqj3VJNyoCtjbywhNFqlwVY5ZoOr4PtNfpc7Z+B3puhi1uJvC
 fQae8iNBvlVDDLK521FP5X6qYVjcjWthB6PZnD5O2JnIsc8HgGQo43qZAri8iUKHxGbj8pmr
 u3yzB7fTLoCWx9mUpTcZsWv+Ezt73ITr+R/AhnTKd5JdUSxroUzc37tjuU6Kt0nIAnYwmfIz
 B6fBBoVqLWfo4Ix99WV16mIo53wTrl7DgxXAGnW4LK7L2/c83b6md1MV+OBfDb8UmLo+fz4O
 b4Pl6ylbKQKzARQro5xM7d31qZgtdHhkL9t0Vg2Fnv8aVn2WKhrJWOL3JQRu/QVlKNZowa/R
 mmG5sJeZeeSIMrgHVNNdhApaP+PiaMdljXItKlnJVW86TB38beDXF8UORSQ0XQPILxwOYIj4
 OEgpM9PsVDk0EJ3a4rfg3AG7XmII1wBT74j6MMQDrjrvRV3mFtMVprRV33t65aVZtQRbERze
 m2IhLDPjqh3z1bZdyZhDmDE2OdQiPziYvyRIIPu87hIpjbEuhPz9BhBtzkoTglYyhhdleR+J
 gCH8qGzybqmp19VaAprBghA2D2twDWd+1ft0B0Ei23UQk2lTCrLIXFV1SNhOqwG2zo0Q9WYl
 Y10DE7hUC32Z4f8wSs/VEposbrlQMAZGsguXiy4N5ztIqTWqgYJTkNjiaTkZvcn7Q4MaJX7m
 NRX
IronPort-HdrOrdr: A9a23:5x8HkqMttbksxMBcTtGjsMiBIKoaSvp037BL7TEUdfQ2Gvb2qy
 nAppomPHPP6Qr5O0tQ/OxoWpPwI080nKQdieJ9UYtKNzOW21dAQrsD0WI8+VfdJxE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,177,1643670000"; 
   d="scan'208";a="8376753"
X-MGA-submission: =?us-ascii?q?MDE8QQMCP7hHZBiSfgA/WeszRlC4Sea/BsTqKh?=
 =?us-ascii?q?eonOjcTzDgvJVkvhU16+IHHODHe+xIyRW7TvWdHWiT1BPR/sDZ4r24mQ?=
 =?us-ascii?q?M62xnx1KffbJ6U7DPCGj4bdy8Govuwm2R1DgkOvH5FO+GPNnvyp1THhF?=
 =?us-ascii?q?TNwg3TJqIZ+JTgNj6tMQ8KuA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 02:20:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 7432781
	for <cocci@inria.fr>; Sat, 12 Mar 2022 17:20:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9n1V1NbDB4pG for <cocci@inria.fr>;
	Sat, 12 Mar 2022 17:20:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 75FBD40
	for <cocci@inria.fr>; Sat, 12 Mar 2022 17:20:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 75FBD40
Date: Sat, 12 Mar 2022 17:20:37 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <44139568-4c27-7ae5-75b3-f9c9c2d88a73@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] How can Coccinelle operate on a series of else-if
 statements?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 212
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/44139568-4c27-7ae5-75b3-f9c9c2d88a73%40ewheeler.net>

Hello,

I am trying to generate a patch like this for every if and else-if 
occurance in the function below:

	-    else if (strcmp(v->format, "%d") == 0)
	-        count = sscanf(line, v->format, (int*)v->vars[0]);
	+    else if (strcmp(v->format, "%d") == 0)
	+        count = sscanf(line, "%d%n", (int*)v->vars[0], &check);


Side note: see the other email about string concatination for the "%n" 
part, but this email is about handling else-if's, so I let (for example) 
"%d%n" remain "%d" and just name it metavariable C in this example:

	@ verify_parsed_vars @
	identifier F = {parse_var};
	constant C;
	type T;
	parameter list PL;
	@@
	F(PL)
	{
	    ... when exists
	    when any
	    if (...) {...}
	-else if (strcmp(v->format, C) == 0) count = sscanf(line, v->format, (T)v->vars[0]);
	+else if (strcmp(v->format, C) == 0)
	+   count = sscanf(line, C, (T)v->vars[0], &check);

	    ... when exists
	    when any
	}

This works for the first occurance as you can see here (even though the 
formatting gets clobbered, which I can live with and call `indent` unless 
there is a cocci fix for that):

	--- t.c
	+++ /tmp/cocci-output-12307-187abf-t.c
	@@ -16,8 +16,9 @@ int parse_var(rc_config_vars_t *v, char
	 
	     if (strcmp(v->format, "%d") == 0)
		 count = sscanf(line, v->format, (int*)v->vars[0]);
	-    else if (strcmp(v->format, "%d") == 0)
	-        count = sscanf(line, v->format, (int*)v->vars[0]);
	+    else
	+        if (strcmp(v->format, "%d") == 0)
	+        count = sscanf(line, "%d", (int *)v->vars[0], &check);

but there are several more else-if's in the series in the same format.  I 
would like to do the first 'if', too, but I can do that by hand if it is 
inconvenient to do in SmPL.  Once I understand how to do this I can write 
one for the "%d,%d" formats with multiple vars:

Thanks for your help understanding SmPL+else-if's!

-Eric

Here is the simplified function:

	int parse_var(rc_config_vars_t *v, char *line)
	{
	    int count = 0;
	    int check = 0;

	    if (strcmp(v->format, "%d") == 0)
		count = sscanf(line, v->format, (int*)v->vars[0]);
	    else if (strcmp(v->format, "%s") == 0)
	    {
		strncpy((char*)v->vars[0], line, v->size - 1);
		count = 1;
	    }
	    else if (strcmp(v->format, "%f") == 0)
		count = sscanf(line, v->format, (double*)v->vars[0]);
	    else if (strcmp(v->format, "%lf") == 0)
		count = sscanf(line, v->format, (double*)v->vars[0]);

	    // These scanf's would use a slightly different SmPL patch (or disjunction):
	    else if (strcmp(v->format, "%d,%d") == 0)
		count = sscanf(line, v->format, (int*)v->vars[0], (int*)v->vars[1]);
	    else if (strcmp(v->format, "%f,%f") == 0)
		count = sscanf(line, v->format, (float*)v->vars[0], (float*)v->vars[1]);
	    else if (strcmp(v->format, "%lf,%lf") == 0)
		count = sscanf(line, v->format, (double*)v->vars[0], (double*)v->vars[1]);
	}


--
Eric Wheeler
