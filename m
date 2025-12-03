Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBBDD1CDA0
	for <cocci@archiver.kernel.org>; Wed,  3 Dec 2025 21:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:message-id:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=yx+FOwMNcsYKo3Y5PuYnxDOaq6+fC5/uU0VF5U5giRE=;
  b=f5jZB+X5EklE6j3iMnQlKehhvt5j8ssFS5Zn+/DaRhHhyJVuDQcd4gDD
   zJEfU+f1roJiv8/pek0qUKCkbPOX6UVWvyqp/5WJGlfgNKlhhda1LjqCB
   UlYIs9KLhBipRZvp4elPy+nPhICNKTPftZwAL8qWoyQMdfjO1sZgWgstt
   Y=;
X-CSE-ConnectionGUID: 0n527cKpSTGPM0FM0o15+Q==
X-CSE-MsgGUID: XRvgHdQNTGS9E3KWEp3oMQ==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,247,1758578400"; 
   d="scan'208";a="252632312"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Dec 2025 22:47:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CF633E02E4; Wed,  3 Dec 2025 22:47:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80E0FE00A5
	for <cocci@sympa.inria.fr>; Wed,  3 Dec 2025 22:47:27 +0100 (CET)
X-CSE-ConnectionGUID: VlrZaTNXTHu1sPCzw0ASvA==
X-CSE-MsgGUID: H/8Od6SZS1ej5sMN29zv2g==
IronPort-SDR: 6930afef_A7wC2CsMsmRnkBhVG6llL70Yx4szSJH1cK9QMCSCbixmxVh
 doXRCCu2E/9kIxgCMnAy+vWSJWEHyHJ2rJFhlQw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0G2AgBTrzBpg0IkQ7lagQmEEIFhMwcISY1QiQ2cNINUD?=
 =?us-ascii?q?wEDAQ1PAgQBAQMEgUyDNIxpAh8GAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBATkHDjuGTw2CW4EsgSYBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?iw/XgIGAQE4gVeCeoIjAk8HAbMCgTSBAYIMAQEGgmjZP4FkCYFLhW6CShsBc?=
 =?us-ascii?q?4oaD4FVRIQOhUc4hXeCJoEOmWEsgR4cA1ksAQ9GExcLBwWBYwOBC24yHYEjP?=
 =?us-ascii?q?hdzPVeDSR5nDwaBEYNRiRgPij0lAwsHZj03FBsGAgGBNZQcT4F+ggWCCFijC?=
 =?us-ascii?q?IE2oUU0B4I4gWcFgVkGDJ9vEhwXl2CTC5kGo2iFWIF/I4FcTSSDNk8DGQ+OO?=
 =?us-ascii?q?iWDdb0KQzU8AgcLAQEDCYVpE4wigUsBAQ?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 Owj
IronPort-HdrOrdr: A9a23:1bgnwa+2TwOPxVxwjHFuk+DFI+orL9Y04lQ7vn2ZLiYlF/Bw9v
 re/sjzsCWftN9/Yh4dcLy7VpVoIkmxyXcW2/hzAV7KZmCP0waVxepZjbcKrQeAJxHD
X-Talos-CUID: =?us-ascii?q?9a23=3AMTcdBGh4haW4yrh/HwfWRJHQtzJuTHnH/n7sBX+?=
 =?us-ascii?q?EKXswU4W+W0DI0Zh6up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARTJb9gxlqD7PPPL6xN6tlE4GKJWaqITpWGcBz64?=
 =?us-ascii?q?0gJCJN3FrHhHH3SapGIByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,247,1758578400"; 
   d="scan'208";a="252632308"
X-MGA-submission: =?us-ascii?q?MDF3114/KAiIGwnCS6DZ/NMqb/19CSBQVdRrVU?=
 =?us-ascii?q?svweEv1tURg8DjmJ1Jzp1DaFfseFeT9TLgzW/d4D4TmTTCOKCrzTmp7l?=
 =?us-ascii?q?gAks4rnxHDWsn0OKXuZ7ZbTEvaike1cBBhAXbUO7rwkJX6qq0A62vuVl?=
 =?us-ascii?q?gA/SInswxjHe6a1ZxxGiShbw=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 22:47:27 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CE12E240101
	for <cocci@inria.fr>; Wed,  3 Dec 2025 22:47:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764798445; bh=yx+FOwMNcsYKo3Y5PuYnxDOaq6+fC5/uU0VF5U5giRE=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=a1dfhRHuBVLQ4U4sPLC7bca1t/C0eL9JO1g2WPZ6+BOVW1JsyHHSOYVTK0R13Ljmo
	 pqiNvrudd+rLDKVgEJdyUK4CLZHfPN37D4gUm2hrJZPDPA9247+w4voYR1DBiC0/Wp
	 w6VqdLmHBiHbMw5zlN5r5BQu4D6uDO5Sdb7C2DANyNQJR85OD195jivu5e6wBv8HRJ
	 2rSh3vCqxy2LroKdoAdC61g2+qCOXzOAyLpCfS7QKtpK6nSiw+IDZ21ubRbgbdntJD
	 YkVcUnXVa3gf76dAqYHdowc558DGOxRFUbTynKKsZHf7aOeN6jHmRw5Xse9hMltvf2
	 oH/i4ByC3IU1A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dMB7c0JnJz9rxd
	for <cocci@inria.fr>; Wed,  3 Dec 2025 22:47:23 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 03 Dec 2025 21:47:24 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
Message-ID: <1b8dad8151ef1409adc8cb24c728907a@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] Search for the concatenation of meta variable + fixed
 string (similar fresh identifier)
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3236
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/1b8dad8151ef1409adc8cb24c728907a%40posteo.de>

Hello again :)

In Linux, the DEVICE_ATTR_RO macro works like this:

static ssize_t led_status_show(struct device *dev, struct 
device_attribute *attr, char *buf) { /* ... */ }

// The macro automatically concatenates led_status + _show for struct 
initialization.
static DEVICE_ATTR_RO(led_status);


I'd like to find the position of all functions assigned by 
DEVICE_ATTR_RO. So I thought to use a 1st rule to search for the 
identifier inside DEVICE_ATTR_RO, then use a 2nd rule to search for the 
inherited meta variable, concatenated with the fixed string "_show". 
Like:

@device_attr_ro@
declarer name DEVICE_ATTR_RO;
identifier attr_name;
@@
   DEVICE_ATTR_RO(attr_name);

@device_attr_ro_show_fn@
identifier device_attr_ro.attr_name;
position p_fn;
@@
   attr_name ## "_show" @ p_fn (...) {...}     // invalid syntax, but you 
get the point


This doesn't work and I couldn't figure how to do it correctly. There's 
"fresh identifier" which looks close, but it only works for +, not for 
search context. Is such a search possible? How?

Tobias
