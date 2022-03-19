Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DD4C433EF
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=alQyDv357xkUL8pwstSrrWyV+vRpH4wVoNXXWmN7HUs=;
  b=HPdG0NJPAT0ootF0vXMv3prdX20V2zWQMSr5Q2qTCBYAgXPz18vs7Qt2
   uvD9WPEAJFKSU2FC4SOrpr4Da7SQIJTV/t83Osj13iua9iB0oNF8kEbSe
   ui8DGcjnVlpVGSjIaRZdpw2b92y7t/79Y8CtgBDiQYLXsR1vjvZblDv/9
   4=;
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
   d="scan'208";a="26965125"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 02:26:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 56057E020F; Sat, 19 Mar 2022 02:26:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 49F49E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 02:26:39 +0100 (CET)
IronPort-SDR: MHcYHx566ceTJIGHfWXixYc9Uq4ivClLfBWeDoCsmQptVfgrBMTtimntIhARnA472HHWW2RZXU
 s32+IGPGPmEX/4uy5XyPDFlXZ10w0CO7w/HUKA98k8xZJd30WQVldIQpsCOb9HguniK6KiSmol
 nCc4EtOrGEtE5eRyIFIedZhwwT/mbrwySec4lPVaXBfmsHZmytsAEiCMadp/Cc29yOO7ExcFH6
 lcvm6oErmGfzjZQ/BbRxRoLBytHe2lFcy3nbz79lafqNPk3h8SFcxwMZu+CZIzqzhVMZdJfSUG
 tAWwtIBW/qHD3/hWkkGk5Msi
X-IPAS-Result: =?us-ascii?q?A0BRBQAcMDVi/0Xcza1aHgENLwwOCwmBWoIoB4FNAQEBK?=
 =?us-ascii?q?QQLmVmZPYF8CwEDAQ1BBAEBhVoFg10CHQYGMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBgQgsAWMBZwGBTgGBeQYEPYI1IoQshRSDF61+gTOBA?=
 =?us-ascii?q?Yl7gTyGFBRCiAYcQIFNig+FMgSZBBOCKSKSb498nhaDUwWJbZVsGi6WSZF0l?=
 =?us-ascii?q?luhSoU4gT8kAjiBWR8UGggmCoMlTQECAQIBDAECAgECAQIBAgEIAQECAY10A?=
 =?us-ascii?q?TMWjk4hAQEBaQIGCwEBAwmPTgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:Nr0M2aIromYt63SpFE+R8pMlxSXFcZb7ZxGr2PjKsXjdYENS32MOm
 GseC2nTM6zcNzP3ed12aIS//U0EucXcn9JkSlMd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFrc4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhrfAs7
 uoXrLGJQiwzffbl3/stEF5VOnQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G1u154TRKyCD
 yYfQQNhSUTjfl50AHgOUbYjsfWygEHxYwQN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt92Lqi/DPkC7/VZhUErCknhJ3vLGN7l4zVTspD0KWmPKSkA3lcpVAG
 w9T9wN7+MDe63eXZtX6WhS5pluNsRgdR8dcHoUG1e2d9kbHy13GWTVcH1atfPRj5ZBmH2V7v
 rOct4qxXWQHjVGDdZ6KGl6pQd6aPDhTIHACaCIAQBFD5dT/yG3Ssv4tZo0zeEJWpoepcd0V/
 9xshHJm71n0pZdVv5hXBXid31qRSmHhF2bYJmz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 CdZxZDPvbteVsDleMmxrAMlR+3BCxGta2K0vLKSN8N8qVxBBVb8FWyv3N2ODBw1bJ1VJm+Bj
 L77tBxR6ZJXMWGra6QyO9vZNijZ5fOIKDkkP9iKBudzjm9ZL1bWonsxORbOgwgAUiEEyMkCB
 HtSSu70ZV5yNEit5GPeqz413eB5yyYg63nUQJynnR2r3aDHNCyRSKwZKx2DceA04aeJukPT/
 soGb5mGzBBWUevfZCjL8NdJcQtQdSViWcn7+55Na+qOAgt6A2V/WfXf9rMWZNA3lapikOqVr
 Gq2XVVVyQehiCSfexmKcH1qdJjmQY178SAgJSUpMFvxgyojbI+j4b0xbZwyebV7puVvweQtH
 6sBet6cGbJCVTTK9jAQd9/7oZA7LEanggeHPiyEZjkjfsc6G1eTooK9IlLirXBcADC2uM0yp
 6yb+jnaGZdTFR5/CMv2ae60yw3jt3YqmNVtAxnCLO5VdRi+64NtMSHw06E6epleNRXZyzKG/
 A+KGhNE9/LVqoo4/dSV16CJq4ClT7l3EkZARjSJ6KbwODba82enzJUGVuuUJGiPWGTx8aSkR
 ONU0/ClaqFcxg4X6tYlHuY517866vvuu6RekFZuEkLLWEv3WLluFX+LgJtUvapXy74E5wbvA
 hCT+sNXMKmiMd/+FAJDPxIsa+mOiaMOlj/J4ahnKUn2/nYqrr+XF0hNPxSBjCFHar14LNp9k
 +smvccX7S25iwYra4za1XoMqj3Qd3FQAb86spw6AZPwjlR5wF91YavDVn387qaJZogeKUItO
 DKV2fTP3uwO2krYfnMvPnHRxu4B148WsRVHwVJqy45lQTYZaivbHSG98AjbiixQ3lNKzOJ+N
 2xmLQtzKLnmE/KEQiRcdzjEJu2DLETxFo/NJ58hkGzCU1LuW3PNIWA5NPzL+k0Fm46Zkv634
 5nAoFsIkl/WkAXZ2iopRVUjpuPjQNF1+xeEns27dyhA81/WfhK96pKTiaE0R9cLzC//aIArZ
 QWnwQqoVZDGCA==
IronPort-HdrOrdr: A9a23:u4Si365U80XflbhD6gPXwNjXdLJyesId70hD6qkRc20wTiT7//
 rAoB1173HJYVoqOU3I+urwXZVoI0msl6KdiLN5VdzOMDUO01HYT72Kg7GD/9Q+IUfDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="26965124"
X-MGA-submission: =?us-ascii?q?MDEdpaqbowBNIDJjec11SDhvQajlwoWtA+Y9Ub?=
 =?us-ascii?q?5EROqYAx+q1NHiqz3zP3PPcAyVCr47X8FJhPYLLmoggwJr8zZGEvwJeS?=
 =?us-ascii?q?R661hlVICrqmQZ6TJaAPChOljZbfIH6XvZwcnmni9XLidI/ZVQwTEeTB?=
 =?us-ascii?q?UPbPPh91DuCuiCGsyDoz2ypg=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 02:26:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 4017B81
	for <cocci@inria.fr>; Fri, 18 Mar 2022 18:26:28 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IJOrTydA0u5I for <cocci@inria.fr>;
	Fri, 18 Mar 2022 18:26:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 04AEC40
	for <cocci@inria.fr>; Fri, 18 Mar 2022 18:26:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 04AEC40
Date: Fri, 18 Mar 2022 18:26:25 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Bug with '*' to display a match on the subsequent rule.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 232
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/30124bde-34e-65ca-d5bc-fc3255ccda3%40ewheeler.net>

Hello,

I may have found a bug:

	@ r1 @
	type T;
	identifier I;
	@@
	*T I;

	@ r2 @
	@@
	f()
	{
	}
	+void a(){}

which prints this error:

	init_defs_builtins: /usr/local/coccinelle-git/bin/lib/coccinelle/standard.h
	File "cocci/broken.cocci", line 12, column 0, charpos = 57
	  around = '+',
	  whole content = +void a(){}

but if I remove the '*' or turn it to a '-' then it works:

	@ r1 @
	type T;
	identifier I;
	@@
	-T I;

	@ r2 @
	@@
	f()
	{
	}
	+void a(){}

with the diff:

	--- t.c
	+++ /tmp/cocci-output-6974-08cd95-t.c
	@@ -5,11 +5,13 @@ typedef struct
		int w;
	 } A;
	 
	-A a, b;
	-
	 #define NOMATCH(s1, s2, member) printf(#s1  "." #member "!=" #s2 "." #member);
	 f()
	 {
	 }
	 
	+void a()
	+{
	+}
	+
	 // functions here


Here is the t.c file:

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

	// functions here

--
Eric Wheeler
