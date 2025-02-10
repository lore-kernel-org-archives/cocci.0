Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E12C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JzKPtw2fgUvh5taA0kG4OvjEYLfehOFh/dM3hqPQhW8=;
  b=QCTrYRNzzOTuu7VwXAXdslNJTL/ZqgEL+aRqwlLGSj82JJ2MrPQrOlr1
   +MRi8Qq15z3jOpbXISJxP8wcSCPxcKAao+smXpz8zdzhUkT5LlO1h2Or6
   pWDZm0hpFBmIWiMBfv8aDvoxWuVMpCYAivSF+HAY1S3rbLGcvGkF9vveC
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207533762"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 17:08:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A28A6E0D20; Mon, 10 Feb 2025 17:08:33 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7537CE0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 17:08:32 +0100 (CET)
IronPort-SDR: 67aa247f_iMiPvjDIkHK4m5D2mN0mYyU3LEf71nq4Ev09K9duyiszNWf
 bKQcmlUxe9qkGIUWRgwx4ylE0tcTESbIqarQyCw==
X-IPAS-Result: =?us-ascii?q?A0EDAgAeJKpnj5B8DMpagQmBVYJCgVY0BwhIhFaIfIh0A?=
 =?us-ascii?q?4ETnRWBag8BAwENRAQBAQMBA4UAAosEAh8GAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNSQEQAYIHAYEkgSUBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQIIYwEfAQEBAgEjHQEBNwEECwsaAgUhAgIPAUYGExaCbIJCI?=
 =?us-ascii?q?wKwcoEygQGCDAEBBt4FCYEaLohPAYVrG4RcJxs/AYFNgRWCKEoHMT6EKRqDW?=
 =?us-ascii?q?xmCUIIzSoJ6gWqLBJh/UnscA1ksAVUTFwsHBYEpSAOBESMPgRQFNAo3OoINa?=
 =?us-ascii?q?Uk6Ag0CNYIefIIrgiCCO4RDhEuFWIISgWADAxYSAYMheByETR1AAwttPTcUG?=
 =?us-ascii?q?58+PIM6UBF8DgUUgSk0HxkBFTeTEoMtjn6hBIQlohOXQZMRmHypLoF+I4FcM?=
 =?us-ascii?q?xoIGxU7gmdPAxkPji0NCRaDQsRdJTI8AgcBCgEBAwmLbYRALAiBSwEB?=
IronPort-PHdr: A9a23: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
 HUmRrZFVVAvG/oEB14jF9sHcs4fYw==
IronPort-Data: A9a23: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
 uGQ3kUD
IronPort-HdrOrdr: A9a23:VeRqiaFsNMczwGX/pLqEAceALOsnbusQ8zAXPo5KOHtom6uj5r
 6TdZUgpGDJYVMqNR0dcL+7SdO9qAznhP1ICOUqTNKftUzdyRKVxeJZnPffKl/balDDH4dmvM
 8KGdkdNDSzNykDsS+Q2njfLz9P+qjizEnlv5ak815dCSVHL5h66RZoYzz6LmRGAC1rQaMjEo
 uNouBOuyCtEE53Uu2LQl0oG9POrdHKi57qCCRpOzcXrC2jyQml77P3CHGjsSsjbw==
X-Talos-CUID: 9a23:draou26PlfQGYWW1ONss0XcvAOEKIlnkx1j8IXGhVUpAeJuvYArF
X-Talos-MUID: 9a23:pJ3d1Av4Stzs/I2sgs2nqiFnGN95/ImSKGdKtrAequuBBwdMNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207533746"
X-MGA-submission: =?us-ascii?q?MDGk740J89TSTAaVQoiOrjFFZSWWz8r9nRvlEh?=
 =?us-ascii?q?7GkhD4Rh23eZndaNYbGBYDkRGUWy9oceWiDZjBZBtimVBjyNm4VsNAQm?=
 =?us-ascii?q?t2vGhwnTqQvw8Ok6f12ZvV3b7IbeDepJCb1S20JvcsQgcjrB71PG4IDZ?=
 =?us-ascii?q?RnkY34thQWrwgA5xBGWK99HQ=3D=3D?=
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 17:08:30 +0100
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E91D114015E;
	Mon, 10 Feb 2025 11:08:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Feb 2025 11:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739203708; x=1739290108; bh=JzKPtw2fgUvh5taA0kG4OvjEYLfehOFh
	/dM3hqPQhW8=; b=FleujqizzGq3xiM3FDALPqu7RLYrqqprmFq3kvG0MyNSEGS4
	aXKXG8WbGp0by+/rObKbvC6YJIqQleFWF/wKIVwL4jVy1KRqBK6j7xcsyuKpB8lb
	cUGNmG665qEwbyokq9eyimoZWEffz1XuIPbkZw65Ac+3cuha5ARUzlngSgTIyue7
	rpNKtK843kltIthxZLu6Pkp5Y1SYLatgDH2wY1VhMftZv/XYrVI0NZBvRLWmxkXK
	p1pDBFNhv76EutHkBZc5xfH9f0Y9ilKz07HVIqUvXGQBDmHgcakBU5SVPHVCZpD+
	i/q+0ACoXaKMCytIbOtr9d7T0V/wRZEOnQ4syw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739203708; x=
	1739290108; bh=JzKPtw2fgUvh5taA0kG4OvjEYLfehOFh/dM3hqPQhW8=; b=h
	wDyZJzEFSRtf1e0WYOkqpal/CDgTRnaMekkBD8UhUyBVR6gcqGLS2wM+jushD1jX
	gj5dk+88yJK13ud+AedryKqd17CHN7EKohd3+YGLdxeba5nCa7ehtoPrdbnZBH5P
	q3lOQSSC8Nr6fR6+7OPl8kZmK7ZJ2S/c0tJ0oPJyrVRIA1ejYBHDJHbNl/Ozpvw4
	znDTnoKT62UNLHwY8NafokBVXUTWuaY7lRu/6ScsrFe/ID6kDGKf9sVe3JOUlASm
	868lXZAKDfxI+eVhq2nyW8DBt97msUIsKoonWRrfit1qXqq19kCZGVAW8jEdy7bW
	QXlXTP/4jYF8+7yT4EdRg==
X-ME-Sender: <xms:eySqZ-zXD93FW3EfUwcLdaaphi8OFfK4H-Olil0Dpnl0BJ54KfGd5Q>
    <xme:eySqZ6QTQ1mj5sY6NFsZeEe3yloe4hFd7y5uDZtzF8DjFt3w9Ze1Wof1uQSpBEICz
    3oz_cCRnd5qE6_RIjw>
X-ME-Received: <xmr:eySqZwUNxY_sAWeNi-vTFSBK_OGi-qq6BYkMbA1wJj665mI464tLAHFmR6tfctMGCDhl3ku3glD2gCpLrsGxXafRcQ5Cuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttder
    jeenucfhrhhomhepffgrvhhiugcutfgvrghvvghruceomhgvsegurghvihgurhgvrghvvg
    hrrdgtohhmqeenucggtffrrghtthgvrhhnpedvvdeifeegieeiffdtgeduiedtuefhieeu
    jeefkeegueehieetgfejtddtgfehffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghotggtihes
    ihhnrhhirgdrfhhrpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegurghk
    rheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhr
    gh
X-ME-Proxy: <xmx:eySqZ0h1GNzkSHisLb1d6E5Bq5aR_CbatiGWRQyKcFz7Lk2mTNrBOg>
    <xmx:eySqZwBkbHoBjTTT9pcx046ZKa6NfRtnsxqUu8uM17PEGPcEwgbUVQ>
    <xmx:eySqZ1Iw5TINisdD-AN1nUxhUqdFgjh-yR8RQojwPXzi5pmIntwLfw>
    <xmx:eySqZ3DQNK8vChr9rsV5tXVRciJ8029uHqq_lqR1dwihuIGZ7IsFPA>
    <xmx:fCSqZwt41VSNqNUPgmhAuLdZBK0gra4vvyWcSKr9pgw2itB87AjPKWN2>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:08:26 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,  Danilo Krummrich
 <dakr@kernel.org>,  Steven Rostedt <rostedt@goodmis.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
In-Reply-To: <2025021048-thieving-failing-7831@gregkh> (Greg Kroah-Hartman's
	message of "Mon, 10 Feb 2025 08:08:19 +0100")
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 08:08:25 -0800
Message-ID: <86ldud3hqe.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cocci] [RFC PATCH 0/6] debugfs: Replace dentry with an opaque
 handle in debugfs API
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2398
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/86ldud3hqe.fsf%40davidreaver.com>

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>
> First off, many thanks for attempting this, I didn't think it was ready
> to even be attempted, so it's very nice to see this.
>

No problem, and thank you for taking a look!

> That being said, I agree with Al, we can't embed a dentry in a structure
> like that as the lifecycles are going to get messy fast.
>

Ack, I'll do something different in v2.

For my own education: what goes wrong with lifecycles with this embed?
Feel free to point me at a doc or something.

Also, Al and Greg, would wrapping a pointer be fine?

	struct debugfs_node {
		struct dentry *dentry;
	};

I was trying to do the simplest thing possible so the bulk of the change
was mechanical. Wrapping a pointer is slightly more complicated because
we have to deal with memory allocation, but it is still totally doable.

> Also, your replacement of many of the dentry functions with wrappers
> seems at bit odd, ideally you would just return a dentry from a call
> like "debugfs_node_to_dentry()" and then let the caller do with it what
> it wants to, that way you don't need to wrap everything.
>

Understood. I considered exposing the underlying dentry as a "dirty
backdoor" around the opaque wrapper, so I was trying to minimize it :)
I'm happy to undo some of these wrappers though, it will make the change
simpler.

> And finally, I think that many of the places where you did have to
> convert the code to save off a debugfs node instead of a dentry can be
> removed entirely as a "lookup this file" can be used instead.  I was
> waiting for more conversions of that logic, removing the need to store
> anything in a driver/subsystem first, before attempting to get rid of
> the returned dentry pointer.
>

Yeah this is a great idea, and could even be done in a few patches
outside of this large migration patch series if necessary. I'll
investigate.

> As an example of this, why not look at removing almost all of those
> pointers in the relay code?  Why is all of that being stored at all?
>

I'll take another look at the relay code as well and see if I can remove
the pointers.

> Oh, also, all of those forward declarations look really odd, something
> feels wrong with needing that type of patch if we are doing things
> right.  Are you sure it was needed?
>

I agree with this sentiment, and I discussed this in the cover letter a
bit under the section "#includes and #defines". The need for peppering
temporary #defines (for intermediate commits) and forward declarations
around is my least favorite part of this patch series.

I am indeed sure they are needed in most cases. I'll give a few examples
for both the temporary #defines Coccinelle adds and the forward
declarations that replace the #defines in the last commit:

1. If you remove the forward declaration (or the corresponding temporary
   #define in the Coccincelle commit) in
   drivers/gpu/drm/xe/xe_gsc_debugfs.h, you get this compilation error:

   drivers/gpu/drm/xe/xe_gsc_debugfs.h:12:57: error: =E2=80=98struct debugf=
s_node=E2=80=99 declared inside parameter list will not be visible outside =
of this definition or declaration [-Werror]
      12 | void xe_gsc_debugfs_register(struct xe_gsc *gsc, struct debugfs_=
node *parent);

   gcc does not like implicitly-defined types inside of function
   arguments. As far as I can tell, we only get this error for function
   arguments; this is apparently okay for a top-level declaration, like:

   struct debugfs_node *my_root_node;


2. In the Coccinelle commit, if you remove the #define debugfs_node from
   include/linux/fault-inject.h, you get errors of this sort:

   mm/fail_page_alloc.c:55:13: error: assignment to =E2=80=98struct dentry =
*=E2=80=99 from incompatible pointer type =E2=80=98struct debugfs_node *=E2=
=80=99 [-Werror=3Dincompatible-pointer-types]
      55 |         dir =3D fault_create_debugfs_attr("fail_page_alloc", NUL=
L,
         |             ^

   Because the #define is not in scope, the compiler is assuming we are
   implicitly defining a new type.


The Coccinelle script adds a forward declaration of struct debugfs_node
wherever there was one for struct dentry. This is just a heuristic I
found that seemed to do the job and was easy to automate.

I originally did this whole patch series in reverse, where we
immediately make struct debugfs_node, migrate debugfs internals, and
migrate all users of the API, but that leads to one very large commit
and appeared harder to review to me. I went with this intermediate
#define idea so the commits could be split up and each commit would
compile, but I don't like the little bit of extra complexity it adds.

I'm open to any other migration ideas folks have! I'm not tied to these
two plans at all.

Thanks,
David Reaver
