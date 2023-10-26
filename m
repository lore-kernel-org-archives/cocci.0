Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214CCC25B6B
	for <cocci@archiver.kernel.org>; Thu, 26 Oct 2023 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5D5ugM6+DfCKW0Koz63C7MzbQ5Ux+lVJw+y4N68Ekn4=;
  b=WM1QdP4tOau61vM/gW40hvIfQXVw3DfIqUSd5VuxEXUjqwdQ/zWtZi5+
   zMItd2+XZj+1K1WWQwQkvw321V7D4HPgdiP5bm8t4Mk6oaupRo2RfKvxL
   7j3W/s6LD0GNIbipNhxzuAFtMbZ9srEfJkCJTuo47vYbg8ZzhWTGn2nwL
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="133262190"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Oct 2023 09:58:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB84FE0CD5; Thu, 26 Oct 2023 09:58:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 11E5FE00B7
	for <cocci@sympa.inria.fr>; Thu, 26 Oct 2023 09:58:09 +0200 (CEST)
IronPort-SDR: 653a1c0f_mfGE1FKX+xSwEcq2xOQu7WqpBQ8EKQBDlo60/XseDHmyjnG
 WyaTa5/pRCbqF5sBkCE3jEbVEdCdu4NM3BJL5uQ==
X-IPAS-Result: =?us-ascii?q?A0EoAAA/Gzpl/3yBCqpaFgYBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE7BwEBCwGCOHqBBgQLSIxwX4hingCBQD4PAQMBCwEBOQsEAQEDBIFMik4CH?=
 =?us-ascii?q?gcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CN?=
 =?us-ascii?q?w4vgQxdCDkBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEwINXAEBNigGAQE4dDUBS?=
 =?us-ascii?q?IJcAYJeAxEGo2ABjHQBAQF2gTSBAYIJAQEGgVdBTbAQCYFIAYgJAYkMeicVB?=
 =?us-ascii?q?oFJRIQ/gSdpgQ8DARiCE4NHgi+DdYU8BQIygiKDWIwcgQEFQnAbAwcDgQMQK?=
 =?us-ascii?q?wcELSIGCRYtJQZRAgItJAkTEj4EgzgKgQM/Dw4RgkIiAgc2NhlLglsJFQw1T?=
 =?us-ascii?q?XYQKgQUF4ERbh8VHjcREgUSDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNEBkoLA?=
 =?us-ascii?q?wIaBQMDBIE2BQ0eAhAtJwMDGU0CEBQDOwMDBgMLMQMwV0cMWQNsHzYJPA8MH?=
 =?us-ascii?q?wIbHg0rPgMZKx1AAwttPTUUGwZAnXVtg1AaPQEBUIE4sGOUaQcDhAwFi3yVC?=
 =?us-ascii?q?AQWM4QBgVaRRgw5khiYPI1lh0KTAQIKBxaBYz2BWXAVgyIJRgMZD44gg3iFF?=
 =?us-ascii?q?IpmQDUCAQE3AgcLAQEDCYkigUpfAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:fJfuHalEZtRF4iF+FGziUIy4GdrpDfId3DAbv31ZSRFFG/Fws/
 re58jztCWE8Ar5PUtKpTnuAse9qB/nlKKdgrNhWItKPjOW2ldARbsKheGPrAEIcBeOldK1u5
 0BT0EzMqyVMbDW5vyW3OE+eOxQueVuJMuT9IHjJxsBd3AMV51d
X-Talos-CUID: 9a23:zdXVkWxEyGz1azmW8iFfBgUqSuUFd2/k4UzKCFKAC1tAaqOfUwaprfY=
X-Talos-MUID: 9a23:24QABAlD16Z5IU9V3oSfdnpIN90y8/i3V3ldgL44koqtHwVLIyWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="133262170"
X-MGA-submission: =?us-ascii?q?MDFcPjugpl1ixrzgkF0qEsK+YlY5cwmH67y+DD?=
 =?us-ascii?q?4mhBJ1PnL2CJm3hzo6LeSSn47JNsbwk2Gjqo/4AGYU4Psv41LrE2ufOp?=
 =?us-ascii?q?fGxx7llEQVtLO4Yeb41+3rQCSxUxB1hV+2j1Lwl9mfApgYv+LRD3BiHj?=
 =?us-ascii?q?+BLEdoRTyU/jM43FHC8hUxAA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 09:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698307078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=5D5ugM6+DfCKW0Koz63C7MzbQ5Ux+lVJw+y4N68Ekn4=;
	b=G5rxTJBWl5g19KnYDe0qfVrgDJAXgdlp9nTwz79YqwwP9suY1GSDqUfOf1R71oWkxbfgza
	jh/5anyn/iPStYLr2Ma/vq/bKL2cE8M1ToSpYN7EA0d+Yg/sDkenzIozgS3EO+/qKghvEF
	Rgm8apR3trSKf8vXnjgYtoRseiqWn5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-Fyb_FKyxO_CKY5asRTh7xA-1; Thu,
 26 Oct 2023 03:57:56 -0400
X-MC-Unique: Fyb_FKyxO_CKY5asRTh7xA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 582643C23645
	for <cocci@inria.fr>; Thu, 26 Oct 2023 07:57:56 +0000 (UTC)
Received: from localhost (unknown [10.42.28.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2394240C6F79
	for <cocci@inria.fr>; Thu, 26 Oct 2023 07:57:55 +0000 (UTC)
Date: Thu, 26 Oct 2023 08:57:55 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: cocci@inria.fr
Message-ID: <20231026075755.GA19414@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [cocci] Report that Coccinelle doesn't compile with Python 3.13.0a1
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1277
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/20231026075755.GA19414%40redhat.com>

https://bugzilla.redhat.com/show_bug.cgi?id=2246276

Longer error message is in the link above, but the guts of it seems to be:

Py.find_library: unable to find the Python library [/lib64/libpython3.13.so.1.0 returned Cannot resolve _PyObject_NextNotImplemented.

I don't see anything about this in the release notes:

https://docs.python.org/3.13/whatsnew/3.13.html

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

