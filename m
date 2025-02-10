Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1DC02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk1hMohsY8=;
  b=T+X44G+jFk/PzombeFc6a6UOetbuxWcr6ZlW2FUcyZmSFi10D5GqEL1Q
   LL5MPulc9oQyLIsCyneP8ZRBi8tZbgWLf6WRHqGkbZ9fFAkXWuY4LxBdS
   3nI1Vl+vrRUaxWkyeHYP+LTeRp8m/gOZ6w1Su4hRWwjbnB2HWO14CmNch
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@messagingengine.com
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207557403"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 18:59:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 93F54E0261; Mon, 10 Feb 2025 18:59:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 608ACE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 18:59:29 +0100 (CET)
IronPort-SDR: 67aa3e81_cRGc0NvoNm99kViRM7afG4Vc70OUyXEpzMtDrGfhmnH2zMR
 5VqcSYG10M/0ARavSaPZqbXVSTOkrAV2ymuPS7Q==
X-IPAS-Result: =?us-ascii?q?A0FyAQD1Papnj5F8DMpaHgEBCxIMhFeBVjQHCEiNUoh0A?=
 =?us-ascii?q?6ASDwEDAQ1EBAEBAwEDhQACiwQCHwYBBDQTAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgEzcYElAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?R0CCGMBHwEBAQIBQAEBNwEPCyElDwFGBhODAoJCIwKyUIEBggwBAQbeBQmBS?=
 =?us-ascii?q?IhPAYVrG4RcJxs/AYFNhA4xPog3glCCM0qCeoFqpARSexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SlIA4ERIw+BFAU0Cjc6gg1pSToCDQI1gh58giuCIII7hEOES4VYghKBYAMDF?=
 =?us-ascii?q?hIBgyF4HIRPHUADC209NxQbnz88gzpQEYIrgRMCRZMSgy2Ofp9GgT6EJaITl?=
 =?us-ascii?q?0GTEZh8qS6BfiOBXDMaCBsVgyJPAxkPjiEZH4NCxQElMjwCBwsBAQMJkGGBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 59cE9dm
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:J5hO1K9GlDUHf5nwwehuk+DvI+orL9Y04lQ7vn2ZESYlFvBw5P
 re+8jztCWE8wr5N0tBpTntAsS9qDbnhPtICOoqTM2ftWvdyQiVxehZhOOIqQEIWReOlNK1vp
 0OT0EKMrzN5C9B4/oSjjPVLz9q+qjgzEnhv5am855Cd3ATV51d
X-Talos-CUID: 9a23:Ew2hxG7hujijBMJRftssr1JJPc4Cbnrh80zWBBKcLm9LYbCfRgrF
X-Talos-MUID: 9a23:qBbybgqlXyRBt2cqG6Uezx84PuM236ChM18cyJBYu9iJOSNzCijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207557397"
X-MGA-submission: =?us-ascii?q?MDGQcDuBHjLoA7kzeYiRZqPuxwLoCBesB0CzlW?=
 =?us-ascii?q?l7d06oNg1WZoRZxzrYhscfl0Hob1izq+Zw1bGwZCEgjWUgNvJyEO5yHA?=
 =?us-ascii?q?y3Ndn2gKYbrelF1HOJjLn/K12c7LTXynrZtd++eJZOSG2/7l/XDzuCX+?=
 =?us-ascii?q?cIpvm3FdO930QMRvZrACgltA=3D=3D?=
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:59:29 +0100
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F43F1140181;
	Mon, 10 Feb 2025 12:59:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 10 Feb 2025 12:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739210367; x=
	1739296767; bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk1hMohsY8=; b=E
	MoPI71JsKi0L0suLHYCwmMPyfFF5vT+tA+zdNDm1DI1MgXtqjYzNsFZfbcbXRmys
	Xh4QD9SKGWgXuGpZJsZY5IsEowIq5UDw8PYrdPT6aWBV6jajvmesfZ6ApM0ugq9H
	a7shKWw1+L0qCjsolEb+1LcKX+AuGbHgfSjUB/b9yngdScR8qp+SGmlrQOASvcWL
	WqvJTuHRF2xx1VcgnZ33yFcnY2a7f8fy3SMtB5zTu+gzXu8owAi++z02vSECF+rw
	bde32Juk6RWYDlZZGqynkpuZD7OG18tuaaqnJa503elLqtTS/+H3xm6sC9umSL/Q
	QdI/oDyjOKUK7060BP/6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739210367; x=1739296767; bh=4P6/1dURFqAqbcScPagqy0vCCJUhFevL4Gk
	1hMohsY8=; b=mjlzsF6uF9om03EU2kE3gtAG20uUa2vHnl+XbFOHmGjQi7XgV3r
	KFIj7QbWeIIGVlT6lpuZtxfzcgkIe6AI19lgGNBmKNcqfW7w7JTMZrLj9Bg+7FAc
	000Qmcen6FGwE891/Uz/gLR/YBivQzicGZbeX41Brmpx+Uk0ER/z3Yr6SuU6r0ti
	TbKdGtDeV5lz7SdiLZmqyjjl3CaFGmSJV038SeOwMGx8qA36KegvXT18zzKox9R1
	I8YVE/XMtGOlgKukuPi8ipEIEXrVOHCnzC2JqMy4m0QLPrNT6lDBLee3UxS5W+ae
	CvnLfITbMF2FVyzX6nI8EYiJjrT95Th5XSQ==
X-ME-Sender: <xms:fj6qZ7WhUp9AMc2RQkPVa6I8IF-BvPyIf4mjoqGAqXta6wabyJyvnQ>
    <xme:fj6qZzmUSWROoyF_LEEIUIJ4lHWmJoKqtw87p8_I_Q-5vrOoGAXG6qRDS-qFIdQXp
    6LpFAWrOtJgqDTNXwQ>
X-ME-Received: <xmr:fj6qZ3aqa9i1ASu55emdnHRiybA6hy99e8PdShDphZ9uJj_4sLS5KGxd6XD7KOPFfG3pBPOu9r_tOmAAay2xrrzy63AJ_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehi
    nhhrihgrrdhfrhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:fj6qZ2UEqZ5MJ3eutGBKyJ2riIHJsf_mjtkNJS6raicpGP5VV6Bncg>
    <xmx:fj6qZ1lhSUevRqU24X2knacWjm4hQgVWUf8ikeuR9bsPiSnUf6LGYw>
    <xmx:fj6qZzcFp7Rx5PuFeKYtuWa1xdjjZR7JH54aYNC_gPkPNAP1GuHUvw>
    <xmx:fj6qZ_EzHu3RoeHgoHOC9h3V0-TZdiB3sFuD5BWqfbC9LYFBn8Cs2Q>
    <xmx:fz6qZ2gIzJWL_zVP73DvZEBMBzzGhWmS1JmHRIt5VHJBib0gZMOb6QFD>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 12:59:25 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
In-Reply-To: <20250210115313.69299472@gandalf.local.home> (Steven Rostedt's
	message of "Mon, 10 Feb 2025 11:53:13 -0500")
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 09:59:24 -0800
Message-ID: <867c5x3clf.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2405
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/867c5x3clf.fsf%40davidreaver.com>

Steven Rostedt <rostedt@goodmis.org> writes:

>
> No it will not be fine. You should not be using dentry at all. I thought
> this was going to convert debugfs over to kernfs. The debugfs_node should
> be using kernfs and completely eliminate the use of dentry.
>
> <snip>
>
> What caller should ever touch a dentry? What I got from my "conversation"
> with Linus, is that dentry is an internal caching descriptor of the VFS
> layer, and should only be used by the VFS layer. Nothing outside of VFS
> should ever need a dentry.
>
> -- Steve

I agree that just wrapping a dentry shouldn't be the final state for
debugfs_node, but this patch series is _only_ trying to introduce
debugfs_node as an opaque wrapper/handle.

It isn't clear to me that there is consensus on even using kernfs for
debugfs. Even if there was consensus, a full conversion to kernfs would
take 10x as much code and be extremely difficult to automate. For
example, using kernfs would require migrating all of the debugfs users'
file_operations to use the kernfs equivalent.

I figure any change away from persistent dentry handles for debugfs
requires introducing something akin to debugfs_node, so we could get
that out of the way first.

Thanks,
David Reaver
