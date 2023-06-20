Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0210EB64D9
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=chYzG703UXRGFNxcNHWjMgnX1JBORe/iCGPY4ZW6DqE=;
  b=M1KvsAnHTq6ZzfZ/kzR0IdRPMUoBwLp/6bwQbi1Dfg4GeEiGevHZTVzl
   EYJ3Itfltnzq9WDz7uy9M+hCv/zjkcgjD8WxTeoAgFUo5nGedtL8IO5Le
   ask5cr1ou0U2ELstVf2vG7I4F1WNslFOnf+I0+4dMHb55JHn+wpwhpAZ9
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.00,255,1681164000"; 
   d="scan'208";a="113651425"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 02:20:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE80AE03AB; Tue, 20 Jun 2023 02:20:01 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98637E0157
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 02:19:57 +0200 (CEST)
IronPort-SDR: 6490f0ab_d+uSgb2096VTrOU6yWvCo0AA452aqWijhlQAk6hZFTj48IB
 rXPLVIba3cnUtgjQc3sLMRli8WwY2fjwjeYhUuQ==
X-IPAS-Result: =?us-ascii?q?A0EcHgDL75Bk/0Xcza1agQmDfgduVTEEC0cImUSBEJdjg?=
 =?us-ascii?q?xY+DwEDAQ05CwQBAQMEgUyJNQIdBgY0EwECBAEBAQEDAgMBAQEBAQEDAQEFA?=
 =?us-ascii?q?QEBAgEBAgQFAQKBBhOFRiINgjciGWRNOwEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQUCDUJkE4UOAYJcAxEGryqBATOBAaFCBoFCh1p8i?=
 =?us-ascii?q?QonG0CBTYEVJ4JTAQGDTwICGIgIBI4ohWUHilRlgShvgR6BInoCCQIRZ4EIC?=
 =?us-ascii?q?F+BckACDVULC2OBHIJSAgIROhRSeBsDBwOBBRAvBwQyJwYJGC8lBlEFAi0kC?=
 =?us-ascii?q?RMVQQSDWAqBDD8VDhGCWmE/G1GCATcDRB1AAwtwPTUUHwYmgiGBeApHoA0Dh?=
 =?us-ascii?q?BATLIFeX5J+jwiCG6AohBIFi3eVCRkvhAGMbIY0kjeYGY1blRiFRYFBOSaBW?=
 =?us-ascii?q?R8UGggmCoMjTgMZD414ATMWg1KQGSQxOwIHCwEBAwmLSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 C7lNAMfNMk2YdiIndgQLjgussdzy9Hi4uvEGwE=
IronPort-HdrOrdr: A9a23:d1R+xqxKy/voM9aMT98HKrPwPL1zdoMgy1knxilNoH1uA6ilf6
 LHppsmPHDP5gr5NEtApTniAtjkfZq/z+8W3WB5B97LN2SLhILCFvAA0WKN+V3d8vLFnNJg6Q
 ==
X-Talos-CUID: 9a23:e6y7X24F7X5l1RFzx9ss5hYXQNIIU13m1zTLJG2TJWdQVuHPYArF
X-Talos-MUID: =?us-ascii?q?9a23=3APnmd5Q4jSoj3Ht9YLkDetrDCxoxaoIGgCmZWwa4?=
 =?us-ascii?q?BqvaIDDVuET6HhTq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,255,1681164000"; 
   d="scan'208";a="113651419"
X-MGA-submission: =?us-ascii?q?MDGyJVwXaYGiFx1nVXzLG3S60QavMLBjuKZ6F5?=
 =?us-ascii?q?dgLhJljUGxDAoz5mmZodHS8VPwaFnUAh9BCWTKnLr+xTgADU1nEqLMmT?=
 =?us-ascii?q?eGbu5UrjWTemOZd6pfe545XZHojwDS6Yc3OrKkL4sgJL48HsSVUBN7a2?=
 =?us-ascii?q?LmB7tnmB5jjg56spnQZHDOZQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 02:19:55 +0200
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id A182585
	for <cocci@inria.fr>; Mon, 19 Jun 2023 17:19:54 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id L9q5zUPatPgI for <cocci@inria.fr>;
	Mon, 19 Jun 2023 17:19:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 54C2945
	for <cocci@inria.fr>; Mon, 19 Jun 2023 17:19:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 54C2945
Date: Mon, 19 Jun 2023 17:19:53 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Strange spatch behavior while patching an array of structs
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 1197
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/b28e953-86e3-a6bb-fc84-1d2794a81135%40ewheeler.net>

Hello all,

I ran the following .cocci spatch on the code below (which is a minimum 
excerpt from [1] for the project [2]) and was surprised by the results. If 
I understand .cocci (and perhaps this is my misunderstanding) then I would 
expect the patch _not_ to apply here at all.

Here is my spatch version:
	spatch version 1.1.1-00106-ge65a6dd compiled with OCaml version 4.05.0
	Flags passed to the configure script: --prefix=/usr/local/coccinelle-git/
	OCaml scripting support: yes
	Python scripting support: yes
	Syntax of regular expressions: PCRE

Please see my question at the bottom.  Here are the relevant bits of code:

-- t.c ------------------------------------------------------------------------------
#include <stdio.h>

struct rotor {
	struct motor {
		char *name;
	} motor;

	struct cal {
		float deg, v;
	} cal[90];

} rotors[4] =
	{
		{ .motor = { .name = "foo1" }, .cal = {{ .deg = 0, .v = 1 }, { .deg = 360, .v = 2 }} },
		{ .motor = { .name = "foo2" }, .cal = {{ .deg = 0, .v = 2 }, { .deg = 360, .v = 5 }} },
		{ .motor = { .name = "foo3" }, .cal = {{ .deg = 0, .v = 4 }, { .deg = 360, .v = 9 }} },
		{ .motor = { .name = "foo4" }, .cal = {{ .deg = 0, .v = 6 }, { .deg = 360, .v = 12 }} },
	};

int main()
{
	int i;
	for (i = 0; i < 4; i++)
	{
		printf("%s cal: [%.2f, %.2f] deg = [%.2f, %.2f] volts, %.4f mV/deg\r\n", 
			rotors[i].motor.name,
			rotors[i].cal[0].deg, rotors[i].cal[1].deg,
			rotors[i].cal[0].v, rotors[i].cal[1].v,
			(rotors[i].cal[1].v - rotors[i].cal[0].v) / (rotors[i].cal[1].deg - rotors[i].cal[0].deg) * 1000
			);
	}
}
-------------------------------------------------------------------------------------

-- cal.spatch -----------------------------------------------------------------------
@@
identifier R, X;
@@

-R->cal[0].X
+rotor_cal_min(R)->X
-------------------------------------------------------------------------------------

-- output ---------------------------------------------------------------------------
]$ spatch --sp-file cal.spatch t.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: t.c
diff = 
--- t.c
+++ /tmp/cocci-output-452476-33c7f6-t.c
@@ -24,9 +24,9 @@ int main()
 	{
 		printf("%s cal: [%.2f, %.2f] deg = [%.2f, %.2f] volts, %.4f mV/deg\r\n", 
 			rotors[i].motor.name,
-			rotors[i].cal[0].deg, rotors[i].cal[1].deg,
-			rotors[i].cal[0].v, rotors[i].cal[1].v,
-			(rotors[i].cal[1].v - rotors[i].cal[0].v) / (rotors[i].cal[1].deg - rotors[i].cal[0].deg) * 1000
+			rotor_cal_min(rotors)->deg, rotors[i].cal[1].deg,
+			rotor_cal_min(rotors)->v, rotors[i].cal[1].v,
+			(rotors[i].cal[1].v - rotor_cal_min(rotors)->v) / (rotors[i].cal[1].deg - rotor_cal_min(rotors)->deg) * 1000
 			);
 	}
 }
-------------------------------------------------------------------------------------


Question:

Why did spatch match R in "R->cal[0].X" as "rotors" and drop the array 
index "[i]" all together to replace as follows?

	-rotors[i].cal[0].deg
	+rotor_cal_min(rotors)->deg

Note that the spatch specifies "R->" , not "R." nor even "R[n]." ; it is 
as though spatch interpreted it as follows:
	-R[n].cal[0].X
	+rotor_cal_min(R)->X

...so for some reason it picked up "rotors[i]" as "R" and replaced it with 
just "rotors"...which, is indeed a pointer, but looses the meaning as 
being a pointer to the beginning of the array indexed by "[i]".

I am confused as to why it matched "rotors[i].cal" at all. It should not 
have matched "rotors[i]" at all, right?

Is this a bug, or an error in my understanding of SML?

References: 

[1] https://github.com/KJ7NLL/space-ham/blob/master/main.c
[2] "Track the Space Station and OreSat Satellites with a LEGO Rotor..."
	https://www.youtube.com/watch?v=vrlw4QPKMRY

--
Eric Wheeler
