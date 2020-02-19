Return-Path: <SRS0=7Jgl=4H=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E704BC761A1
	for <cocci@archiver.kernel.org>; Wed, 19 Feb 2020 22:34:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E92624672
	for <cocci@archiver.kernel.org>; Wed, 19 Feb 2020 22:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E92624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01JMYLfe017013;
	Wed, 19 Feb 2020 23:34:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7889777F6;
	Wed, 19 Feb 2020 23:34:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5BBD577EE
 for <cocci@systeme.lip6.fr>; Wed, 19 Feb 2020 18:36:07 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01JHa4a1008472
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 19 Feb 2020 18:36:05 +0100 (CET)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2020 09:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; d="scan'208";a="239753241"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
 by orsmga006.jf.intel.com with SMTP; 19 Feb 2020 09:28:50 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 19 Feb 2020 19:28:49 +0200
Date: Wed, 19 Feb 2020 19:28:49 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: cocci@systeme.lip6.fr
Message-ID: <20200219172849.GU13686@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 19 Feb 2020 23:34:22 +0100 (CET)
X-Greylist: Delayed for 00:07:09 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 19 Feb 2020 18:36:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 19 Feb 2020 23:34:19 +0100
Subject: [Cocci] Inserting code after specific set of declarations?
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi all,

I was trying to do the following transformation:
@@
identifier M;
expression E;
@@
- struct foo M =3D E;
+ struct foo M;
+ copy_struct(&M, &E);

but without inserting the function call in the middle of the
declarations and instead pushing it past them.

This is one attempt:
@decl@
identifier M;
expression E;
@@
- struct foo M =3D E;
+ struct foo M;

@copy@
identifier decl.M;
expression decl.E;
declaration D;
statement S;
@@
struct foo M;
...
D
+ copy_struct(&M, &E);
S

The copy rule fails to match anything when I have !=3D 1
declarations after the struct. So the ... doesn't seem
to eat the extra declarations for some reason.

Also tried some other tricks with <... ...> but that just resulted
in the code being inserted into every if block in the function.
Not what I wanted.

I guess what I might need is something along the lines of:
@copy@
...
declaration list[N] D;
@@
struct foo M;
D
+ copy_struct(&M, &E);
S

but that's not supported it seems.

Is there any way to achieve this atm?

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
