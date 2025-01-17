Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909C7C02182
	for <cocci@archiver.kernel.org>; Thu, 23 Jan 2025 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=r55rELN2JFvNLw2LU2D0E09rnmuYX9Tm2DYedAN6Ysc=;
  b=mAiHILsM6f22/HeJHiWFlXgdkpDoCtw6pNZl621V+bmlRegTGHiNRxQp
   VN0CGe23LjBdb2JljJ2qw9C+lQH9DmKwK6x+yxtSIZlWTW+90ruO8DxIn
   Wb/ah3XhXRXp5nKb6abPmYskrkuv7FMcG9VGnQDKa8a8MRxKN7i+VS3HO
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204631948"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 12:18:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 906ECE0D1D; Thu, 23 Jan 2025 12:18:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6E174E0077
	for <cocci@sympa.inria.fr>; Fri, 17 Jan 2025 23:51:29 +0100 (CET)
IronPort-SDR: 678adef0_f7dQGIJmrNsJrk4iJ2AOGUoQ/duwDM62LxooF6+CiSbDBa1
 VDi4lQv9mj4214oKaekIQeQZYQqWs8VZe+B4OSw==
X-IPAS-Result: =?us-ascii?q?A0GzDQCj3opn/+cOCtlaHQEBPAEFBQECAQkBFYFVgkIHg?=
 =?us-ascii?q?U8SIgQLlGyiOg8BAwEhEx0EAQGPfQIeBwEENBMBAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECgQoThUw8gluESIEwG4YqB7U4gRoagQHgIIFIAYhNA?=
 =?us-ascii?q?YsJFQaCDYFKgkUBL4VOhXcEgRCBIoUzl1GHcoFNeCwBVRMXCwcFgXEDgRSBS?=
 =?us-ascii?q?nuCRmlJNwINAjWCHnyCK4RehEWEUYVighSER4IwHUADC209NxQbolfJMwcDg?=
 =?us-ascii?q?jWBZgWiDpdSkwGYfKQQhxsmK4EucRSDI04DGQ+NdgEBAcF2RW4CBwsBAQMJh?=
 =?us-ascii?q?kiJTIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FAqBz6xfLQAEfJ22IorZKrPwSb1zdoMgy1knxilNoDhuA6+lfq
 GV/MjzuiWftN98YhwdcLO7WZVoI0mzyXcd2+B4VotKNzOIhILHFu1f0bc=
X-Talos-CUID: 9a23:mlcpPG3sRev19XJUiDsb0LxfJ5p6ayb41EzqCEqSImxPFrO7dnKK0fYx
X-Talos-MUID: 9a23:m1RD/gQl8yfu7sIWRXTglXJTZZkv0pjxFRAEzc4ImNG5az5ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,213,1732575600"; 
   d="scan'208";a="106679569"
X-MGA-submission: =?us-ascii?q?MDE4HDQtudW+452mPqUXRE5nW4BMpfXzAbeKe/?=
 =?us-ascii?q?2hcyPGr8VLtGcwVstRNKkmeD/jMyqP4SRBYM2sSpTsjiBNVK/xNYsUgM?=
 =?us-ascii?q?8T91ILUHKmp+IwMvVuusqJQsYPh1Z3TM+Hnw0J/QlpfFDnMT+pemS9PE?=
 =?us-ascii?q?dasy2RLbCU1awvzHJlKd7XQg=3D=3D?=
Received: from cae.in-ulm.de ([217.10.14.231])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 17 Jan 2025 23:51:28 +0100
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 5B5BE14034F; Fri, 17 Jan 2025 23:51:27 +0100 (CET)
Date: Fri, 17 Jan 2025 23:51:27 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: cocci@inria.fr
Message-ID: <Z4re766p6mujr7h4@cae.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Replacing cast in nested initializers
Reply-To: "Christian A. Ehrhardt" <lk@c--e.de>
X-Loop: cocci@inria.fr
X-Sequence: 2218
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/Z4re766p6mujr7h4%40cae.in-ulm.de>


Hi,

I am trying to replace casts in nested struct initialisers.
My patch attempt looks like this:

@@
identifier __type;
identifier __name;
expression __data;
@@

| struct __type __name[...] = {
| 	...,
| 	{
| 		...,
| -		(del_t)
| +		(add_t)
| 		&__data
| 		,...
| 	}
| 	,...
| };

Running this on this .c file

| struct foo foos[] = {
| 	{ (del_t)&x1 },
| 	{ (del_t)0 },
| 	{ (del_t)&x2 }
| };

I would expect the first and the third cast (in front of "&x1" and "&x2)
to be replaced.

However, only the first cast (in front of "&x1") is replaced and
I get a warning the del_t might have to be meta variable. If I add

| typedef del_t;

to the patch only the last cast (in front of "&x2") is replaced.

What am I doing wrong?

Best regards,
Christian

