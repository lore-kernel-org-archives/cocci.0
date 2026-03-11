Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0E21049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BipbvJcvwX/pjXsy3HWRU3NhgZBFRdigEE7P7xncOg0=;
  b=Bw7H7xB7hf5d2auq9PCwvhaPzrOrf1gU/lXPLyUTcB+O8kY9LpqDOCYG
   /MiTX4P95MdvlazxLieqD3hZC7BHYaBQiDH59hgFzwSQqcxI6PMFhmHqp
   4mzQh5aOIVlFv6h8CgKZhx/QXgZ59sJY7mgYzYtW2Bg4CUdSK6eL2UlRU
   k=;
X-CSE-ConnectionGUID: YPNu5yh/RCa9+K//Ky7D6w==
X-CSE-MsgGUID: ocsk2dO6T7WIBxa0BRgANw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267246089"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:25 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id AFC15818D6; Wed, 11 Mar 2026 10:46:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 491FF800CB
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 09:29:57 +0100 (CET)
X-CSE-ConnectionGUID: nVwP02a1QvWpxEt+6OkFEw==
X-CSE-MsgGUID: P2mRFIhCRDC8PlE8wTDo0w==
IronPort-SDR: 69b12804_ycjCI/8GAveVU1C/wilTqJyhz+qpwl73qkMQGDwYOa0lb2l
 ZfzdofYbNfmpJ2mVGAK/XaQ4cVxWlDje1gP8/1g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E7CgC1JrFp/1TW0j5aHgEBCxIMQIFFC4JBB4FeNAQLS?=
 =?us-ascii?q?YRYiHuGWFgCAQEBBoE+hDGHRpImgX0CDwEDAQ1RBAEBBIUDAo0jAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECgQoThhUHMw2CY?=
 =?us-ascii?q?gGCSSyBCwIBAyMdAQE3AQ8LDgwCJgICEEYGE4UlB0oHAa5YgTKBAYIMAQEG3?=
 =?us-ascii?q?hEJFAGBCi6IVAGFWhqEAHonG32BEIEVgyo+hAqEFIJpgiaBDokKg0OGVlJ4H?=
 =?us-ascii?q?ANZLAFVExcLBwVeRUMDgQYjSwUtHYEjIR0XFB9YGwcFEiEqB4FBeIIBD4Zoe?=
 =?us-ascii?q?QMuXhoOIgI6XIEGC1oFgiwCHAMLbT03FBsEjyg9gi0GAQGBDYFxbaVroRGEJ?=
 =?us-ascii?q?qIlhASNE4ZHkw0uh2WQc6lBgW8CNIFZTTAIgyJPAxkPiTaEawwWiHHELjcyP?=
 =?us-ascii?q?AIHCwEBAwmRajSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0NgKYf5f3BYAl5
IronPort-HdrOrdr: A9a23:m7NQ+aCrQX3DGmrlHelz55DYdb4zR+YMi2TDiHocdfUFSKGlfp
 6V9sjzGyWE8wr5OUtQ4+xoXZPufZqyz+8Q3WB8B8bGYOCEghrLEGgB1/qF/9SIIUSXndK1vp
 0QCpSWZueAdWRSvILV5E2WH9483MKK6smT9IDj5kYoYwUvRa8I1WdE48Wgc3GehjMpOXPxLu
 v+2vZ6
X-Talos-CUID: =?us-ascii?q?9a23=3A838VxmmXC0kVDKVQ941xTbTJlA7XOXvj00+IeUb?=
 =?us-ascii?q?hMHhWUK24VRzO36BKvtU7zg=3D=3D?=
X-Talos-MUID: 9a23:vDWmuAvcXhV9zCDFl82nvGtnDulJ44+UJGtdqZEr69a4GSsoJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="140999229"
X-MGA-submission: =?us-ascii?q?MDHoa9BL0IH+qPnXKG83G3PfCdU6YCfqXCozum?=
 =?us-ascii?q?VlZyK9sZkA8fztE4qB/H1nMzq7A4UlQx4122PMosdzJUPy6SkoJhaxgn?=
 =?us-ascii?q?0cI54H5jn64ZtCB3nyrIUVev3TPcySnfds/MRgWpCwQE8rdbz61Rk9gZ?=
 =?us-ascii?q?AXT3zx+Ypch4LN1o288Cd1KQ=3D=3D?=
Received: from submarine.notk.org ([62.210.214.84])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 09:29:56 +0100
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2AC2C14C2D6;
	Wed, 11 Mar 2026 09:29:52 +0100 (CET)
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0e77f259;
	Wed, 11 Mar 2026 08:29:51 +0000 (UTC)
Date: Wed, 11 Mar 2026 17:29:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: cocci@inria.fr, linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <abEn8GjSxsVD3D7j@codewreck.org>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Dominique Martinet <asmadeus@codewreck.org>
X-Loop: cocci@inria.fr
X-Sequence: 3399
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/J_fGAtFr6FnhGlf4LlvNfA>

-most lists...
Hopefully anyone who might care about 9p is on fsdevel.

I second whoever it was who said this should be split and not send all
the patches to everyone...

Philipp Hahn wrote on Tue, Mar 10, 2026 at 12:48:32PM +0100:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Eric Van Hensbergen <ericvh@kernel.org>
> To: Latchesar Ionkov <lucho@ionkov.net>
> To: Dominique Martinet <asmadeus@codewreck.org>
> To: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5bfe2eea7 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>  	struct p9_fid *fid, *nfid;
>  
>  	fid = v9fs_fid_lookup(dentry);
> -	if (!fid || IS_ERR(fid))
> +	if (IS_ERR_OR_NULL(fid))

FWIW v9fs_fid_lookup cannot return NULL -- and all its other callers
only check for IS_ERR() so if there is a corner case that does return
NULL then we have another problem -- so please drop the !fid check
instead.

(not that it matters much... But might as well do it right)

-- 
Dominique Martinet | Asmadeus
