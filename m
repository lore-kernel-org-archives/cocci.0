Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAC5C433EF
	for <cocci@archiver.kernel.org>; Tue,  8 Mar 2022 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ts1KJf3EoYG+WDTKGWeG8NpXRGKOjT0Q+7+DUkqjbnE=;
  b=QidmrYoEeA0ppMix83HDUHQp+9HqMzmrHbcPxBH0nB68+ba4okRPfmrk
   6R9zuMF3CzuEm0w4YlsgdKEDKMt+avpju4j4O1MLnuDfnhNpmk4in/wYs
   +loKbV0rfJavSX5tRelezfhqA5VHjoou57xDoMD5OHQAa676D+w/HhxT8
   w=;
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
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="25118733"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2022 00:15:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5B5DE0362; Wed,  9 Mar 2022 00:15:21 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 741F6E004D
	for <cocci@sympa.inria.fr>; Wed,  9 Mar 2022 00:15:19 +0100 (CET)
IronPort-SDR: m/LE5D4dD0yAf4toOY5UorBrGkDTAEZkJ4RO07pOAb13xDRRSaT8SkHULV+K7sMFwNUlngCCvT
 NQloq9qVfJ7B2US4xq7LpYCV8PJ0uuRn/VHMuP2Birw1WHz8F1cIYuadbDe8wPfopwm05RIyZK
 /wbAUH8WEUsgQrCOVAbi+yEQCawWWIA04H3cR5/Ktl+UqHtj1ynbyCd6QqT55VPSUk5Oo3o42+
 ltwhapit0MXdLA9dE8iCFbQybeWqcH2zGDWgaJKYyAXClVp0Nk7eA+nkYEjd8Tcgtbo9Pvz23p
 n0XwuxxeZo8PSOA6pCnIfc+a
X-IPAS-Result: =?us-ascii?q?A0DaBQDV4idi/0Xcza1aHgEBCxIMQIFPC4IoB4FNAQEBK?=
 =?us-ascii?q?QQLlAuCJYMpmTmBfAsBAwENQQQBAYkpAh0GBjIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgMEAYEILAFjAWcBgU4BgXkGBD2CNSKELIUUgxeuYoEzg?=
 =?us-ascii?q?QGJe4E8jm8cQIFNgRUziEeFMgSXZDESeg+BHTqiD54Sg1OYb4ZnGi6EOoMSj?=
 =?us-ascii?q?niLGoZMllWhSA+FIoE/KQE0gVkfFBoIJgo7gmpNAQIBAgEMAQICAQIBAgECA?=
 =?us-ascii?q?QgBAQIBjigWjk8gAQEBaQIGCwEBAwmRbwEB?=
IronPort-PHdr: A9a23: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
 fAniBIrtZFRHtSflioPRiETmjiLacOH9k/Uxw==
IronPort-Data: A9a23:n6vG9aL3Gcg0T8UVFE+R8pMlxSXFcZb7ZxGr2PjKsXjdYENS02QDx
 2IYD27UM/2JMTb9KNklbtuy9UMDusOEytFrGQUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFvd4
 YmaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhvO4qz
 dhxjZOLVx4FBbTRis06VQFJHHQrVUFG0OevzXmXtNzVwlLGfnbozu8oCkwqVWEa0r8oWicUr
 aFecmpVKE7S7w616OrTpu1EjcMoJ8jDOIIEpmomwC7ZAPsiTIqFRajWjTNd9G1t35keQqyPD
 yYfQTN2dT/SMj5WAE00J71hrcuS3T7iayIN/Tp5ooJsvzaInVMhuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt92Lqi/DPkC7/VZhUErCknhJ3vLGN7k8tUxgbaWO0muegpnWnRsB2D
 EoM6yV7+MDe63eXZtX6WhS5pluNsRgdR8dcHoUG1e2d9kbHy13GWTVcH1atfPRj5ZBmH2V7v
 rOct4qxXWQHjVGDdZ6KGl6pQd6aPDhTIHACaCIAQBFD5dT/yG3Ssv4tZo09eEJWpoepcd0V/
 9xshHFv71n0pZdQv5hXBXid31qRSmHhF2bYJmz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 CZbxZTBvL1QU87leMmxrAMlR+vBCxGta2K0vLKSN8N8qVxBBVb8FWyv3N2ODBw1bJ1VJm+Bj
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
IronPort-HdrOrdr: A9a23:POgX8q++FAACEDesGDNuk+DII+orL9Y04lQ7vn2ZKCYlFvBx9a
 iV88jzuiWbtN98YhAdcLO7Scy9qBHnhPxICOAqVN/IMWXbUQCTXeJfBOXZowEIxBeVytJg
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,165,1643670000"; 
   d="scan'208";a="25118729"
X-MGA-submission: =?us-ascii?q?MDEVFiM/STi1P6bEfsyaWf6rRXElEmof47J8Pv?=
 =?us-ascii?q?MIHswKpKa4AqKCsj1CQq4wqrPOiYk+APUFpPFPtJ3+emlIhcvd2iPHih?=
 =?us-ascii?q?pyw3KC0tZsnEi2SDW3oiQAI6/+DWrMSvIotwlf7NqbDvEDMZFJQB9xWg?=
 =?us-ascii?q?wY7fgkuxyHYrFQMu1Xq07tOA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:15:18 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 255364A
	for <cocci@inria.fr>; Tue,  8 Mar 2022 15:15:16 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yi8Y9DD16Bbq for <cocci@inria.fr>;
	Tue,  8 Mar 2022 15:15:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id B7AB139
	for <cocci@inria.fr>; Tue,  8 Mar 2022 15:15:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net B7AB139
Date: Tue, 8 Mar 2022 15:15:11 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 190
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/4fc9237-ca2-518a-3221-9770f6112c6%40ewheeler.net>

Hi all,

I would like to replace this:

	void on_struct_save_as_gnuplot_activate(
	    GtkMenuItem     *menuitem,
	    gpointer         user_data)
	{
	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
	      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
	}

And extract the extension ".gplot" as an identifier and pass it to the 
function get_nec_filename_stem, like so:

	void on_struct_save_as_gnuplot_activate(
	    GtkMenuItem     *menuitem,
	    gpointer         user_data)
	{
	  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
	      "*.gplot", NULL, get_nec_filename_stem(newfn, ".gplot", PATH_MAX), rc_config.working_dir );
	}

The SmPL patch below works for what I want statically, but notice the 
commented `expression E`:

Is there a way to regex-group `expression E =~` with a parenthesis and then specify
something like E[0] to pick up the grouped regex match?

	@ replace_untitled @
	identifier F;
	parameter list PL;
	expression list EL1, EL2;
	//expression E =~ "\"untitled\.(.*)\"";
	@@

	F(PL)
	{
	+   char newfn[PATH_MAX];
	    ...
	    file_chooser = Open_Filechooser(EL1,
	-       "untitled.gplot",
	+       get_nec_filename_stem(newfn, ".gplot", PATH_MAX), 
		EL2);
	    ...
	}


This doesn't work, but it explains what I'm trying to do:

	@ replace_untitled @
	identifier F;
	parameter list PL;
	expression list EL1, EL2;
	expression E =~ "untitled.(.*)";
	@@

	F(PL)
	{   
	+   char newfn[PATH_MAX];
	    ...
	    file_chooser = Open_Filechooser(EL1,
	-       E,
	+       get_nec_filename_stem(newfn, E[0], PATH_MAX),
		EL2);
	    ...
	}

It replaces as follows and does match "untitled.(.*)", but of course [0] is incorrect SmPL grammar:

	@@ -250,10 +253,13 @@ on_struct_save_as_gnuplot_activate(
	     GtkMenuItem     *menuitem,
	     gpointer         user_data)
	 {
	+  char newfn[PATH_MAX];
	   /* Open file chooser to save structure image */
	   SetFlag( STRUCT_GNUPLOT_SAVE );
	   file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
	-      "*.gplot", NULL, "untitled.gplot", rc_config.working_dir );
	+      "*.gplot", NULL,
	+      get_nec_filename_stem(newfn, "untitled.gplot"[0], PATH_MAX),
	+      rc_config.working_dir );
	 }

I tried something like this:
	expression F =~ "\..*";
	expression E =~ "untitled" ##F;
but that is invalid too.

Ideas?


--
Eric Wheeler
