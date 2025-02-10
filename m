Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26DBC02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 05:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+T5uj758NieMk8bBUK5X8Wsdb6Nz4WNL4skk6Wb/mi4=;
  b=kN2AqzPuygLQx8qxf2sG4D2T6z2FM/Na+FKg8HCL188ufvL6mgES9oCN
   bF1eXMkq026uS4O9xRgj7SxnaST/c++1M8noEIY+K5KIPugsqYENT1w4h
   C38Y1atKxGGz3HfwECfOwDP4g5NQEKtllo2LFxx4eYmSOSDmLoYk1SaPO
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.org.uk
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207384081"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 06:59:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D73AE0D1E; Mon, 10 Feb 2025 06:59:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 655D5E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 06:59:01 +0100 (CET)
IronPort-SDR: 67a995a4_HVElAicQ1+8Lgs5iRBgLMGWzEdf6rTMlIgCyfqcBiIOTiQl
 3dZ/K1i4RLODoEV++8wjnJr1pbPI/jsVDOk+8wQ==
X-IPAS-Result: =?us-ascii?q?A0GKAAA7lKlncq2NWT5aHQEBAQEJARIBBQUBQIFBBgELA?=
 =?us-ascii?q?YJDgVY0BAtIlCWCJJ4Ugg0BAwENQQECBAEBAwEDkAYCHgYGMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABgQyFew2CYgEzghYsDX4GOgYBA?=
 =?us-ascii?q?TcBDwEKDiYSVgYThWcHsAyBNIEBggwBAQbeBQmBSAGITgGFa4R3JxuCDYQ/P?=
 =?us-ascii?q?ohYgi+CM4Fug0CkA1J7HANZLAFLChMXCwcFOXBIA4ERI4EjBTQKNzqCDWlJO?=
 =?us-ascii?q?gINAjWCCxNdH4IrgiCCO4RDgzWBFoFng3GCEoFgAwMWE4IxcHgchE0dQAMLb?=
 =?us-ascii?q?T03FBsGnzg8hTWZKrAChCWEb5xXTRODXaZiLodskGKpLoFuCimBXE00BIMiT?=
 =?us-ascii?q?wMZD44hOIs7vSlGMjwCBwsBAQMJhUYBAYpTLAiBSwEB?=
IronPort-PHdr: A9a23:bYkdIBNBY3uj3HT4saAl6nbABhdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvq8r1AeCBtqBtboE07OQ7/u5HzRYoN6oizMrTt9lb1w/tY0uhQsuAcqIWwXQDcXBSGgEJ
 vlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+I
 A+5oAjfqMUam5duJro+xhbHoHZEZeVbzn5sKV6Pghrw/Mi98ZB+/yhKp/4t68tMWrjmcqolS
 rBVEDspP2cp6cPxshXNURWB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw7Viis4
 KltSB/zlScILCU5/33Nisxxl61UvhSsrAFizoHOYYGVMP1+fr7Bfd4fWGFMUNpdWzBHD4ihd
 IYEEfYPMvhEoIn8v1sOrAWxBQ+wBOP01zREgmb60bAm3+g9FA3L2hErEdATv3TOtNj7OqccX
 /6rwafVzjvDYfxZ1ivg54fKaRAsuu2MUa5qfMbN1UUjCx3Jg1ONooLlJTOV0eENvnCH4upkS
 OmghG8nqxt2ojOywcoslIjJhpgSyl3f9CR23oA1JdymSEJhZd6kEZ1QtzyVNodsRcMiWW5ot
 Dwnyr0FoJO2ejUBx5s7yRDFcfOHb5SI7Qz5VOaXOTp1mmxodK+9ihu8/0auyuPyW82p3FpWr
 idJjMfAuHAP2hDN5cWKROdw80mv1DuN0w3d5OBJLFw1mKfbKJMs3789m5wOukrABi/7gET7g
 LGMekgn/uWk8fnrb7r7qpOGKoN5iA/zP6IzkcGhBeQ4LxMOX3SF9uSmybPj/Ez4T6tSg/Eql
 KTSrYrUKt4BpqGjBg9YyoYj5Ai7DzehyNkZnGcILFREeBKZlYTpP1DOIPblDfawmVisly1rx
 //cMr38AZXBNnnDkLH/crZh80NRyRQ/wcpc6p9QEL0NPf3+VlLruNDFDBI0PRS4w+P9B9V80
 oMeV3iPAqicMK7Kr1+I5/gvI+6XaY8bpDb9M+Ip5/rvjX8/hF8ccrOl3ZwNaHC3BPhmPkaZb
 WLqgtgaCWgKpBYxTPT2iF2eVj5ef2u+U7om5j4nEIKmEZvDRoe1jbOd2ye0AoFZZmFdB1CXE
 Xbocp2EVO0WZCKTJM9hiD0EWqK7R48vzxH9/DP9npZuMOvYshcVvIzuzpAh4uD7mRgs9DBuA
 s2D3nvLRGZxyDAmXTgziYl76XJ80FDLhbZ5mftwB9FV5u0PVgY8KI6ayPZ1Tc3xDFGSNuyVQ
 UqrF431SQo6Scg8lppXOx4V87SKixnC23DvGLoJj/mRA5dy9KvA3n/3LsI7ynDc1aBngUN1C
 tBXOziAgahyvxPWG5aPi1+Qwrirb6M00jLVsmOCy3ee+kZCX0htUvaNRmgRM23Rq9mx/UbeV
 /mrALUjPBFGzJucK7FNQtP1lRNCRfH+KJLZeW33hmTjTQ2QyOaqa4znM34YwD2bCEUAlFUL+
 m2aMAElGiq7i3DTCj1wU1buZV78t+5kpzWmTSfY1imsaEtsn/qw8x8R37mHTu8Lm6gDs2Eno
 il1G1C025TXDcCBrkxvZvcUZ9R1+1pB2W/D0m41dpW9M6BvgEIfeAVrrgvv0RtwEIBJjcktq
 jsj0gNzLauS1F4JeSmf2Nj8PbjeK2+6+x7KCeaexFDE1/6Y5r9J7PU+tkWluxumUFchsj1m3
 9RTz3qA98DSFgNBGZn1U0sx6117v+SEOG9ttsWNiSQqaPbv4Vqgk5ozCeAoywitZYJaOaKAT
 krpFtECQtKpI6oskkSoaRQNOKZT8rQ1NoWobajjuubjMeB+kTahlWkC7pp61xfG6StmTcbGw
 45Dx/CewxvBUC3zykqi+JOS+8gMdXQJE2yzxDKxTpBQfKpac5oTT2OvJdCngNJkiNjwWDQLk
 TzrT0ND08ivdx2IalX71gAFzkUbr0usni6gxiB1mTUkxkaG9ArJxemqNB8OO2oRAXJnkU+pO
 4+/ydYTQEmvaQEt0hqj/0fzgaZB9ux5KCHITEFEcjKTTSkqW7astreEf89E6Y85+SRRXuOmZ
 FmGS7n76xIE2iLnFmFayXg1bTav8pn+mhV7jiqaIhMR5DLHeNt37RnD/JrYRPhMznwBXiY+l
 DqWTlmwMt+1/MmFwpLKs+SwTWWkBfgxOWHgyYKNsjf+5HU/X0f5z6H1w4G+V1FlinyetZEiT
 yjDoRfib5O+0q27NbgiZUx0HBrm7ME8HIhik4w2jZVW2H4Ah5zT82BU9AW7edhdx6/6a2IAA
 DARxNuAqhbkwkpLIG6RgYb4UGiNhMx7aJ+nYSlFv0B1p9APE6qS4LFeyGFro0C/hQzNeb55n
 zEA2b0p8nFcnuJD629Phm2NR7sVG0dfJynlkR+Fusu/oKtgb2GqabGs1UB6kLhNFZmkpQdRE
 Db8c5YmR2pr69lndUjL2zv1453lf9/ZaZQSsAeVmlHOlbodLpV5jfcMiSd9XAC19XQ41+42i
 wBv1pCmrcCGLWtq5qewHh9fMHX8ecoS/jjniasWkNyR2sijGZBoGzNDW5WNL7rgCDUJqfHuL
 BqDChUup3GaB/zbHAmC+AFhtX2JDpPqf3CbKX8FzMlzERmQIEsM5WJcFD4+n5M/CkWr3Jm/K
 gEpt3ZIuge+80QXmYcKf1HlX2zSpRmlcGIxQZmbdl9N6x1aol3SOoqY5/5yGCdR+tugqhaMI
 yqVfVctbylBV0qaClTkJrTr68PH9r3SGOukKNPAfa3Ire1YSufOwoiglJZltWXpVI3HLjx5A
 vs311AWF2h+ANjcki4TRjY/hS/LbtDdoBa65z0xqdqwtunoElGKh8PHG/5ZNtNh/AqziKGIO
 ruLhSp3Hj1f04sF2X7CzLV3NL86mSxodifrFbUGqD6LS7jf3LJUXUZzg8ZbOtdQqaY92BRdf
 8nBhZXo1ewg5hbaI1lZTRrlm8e0dYoNOW77KVCVXC62
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ksBzLKEG3CV5jpGHpLqE68eALOsnbusQ8zAXPo5KJyC9Vvbo8/
 xG/c5rsCMc7Qx7ZJhOo7290cW7LU80sKQFhrX5Xo3SPjUO2lHJEGgK1+KLqQEIWReOldK1+p
 0QFZSWY+eQMbEVt6nH3DU=
X-Talos-CUID: 9a23:fQR7iW+Dp0h0Ff/M6N6Vv2cLJ+1mNWD+8Fv3egz/DXhNYr6Yd0DFrQ==
X-Talos-MUID: 9a23:pO7TywZGsjODw+BTnXzvtA08EOBT36GtAWkWgYc5ivGUOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207384075"
X-MGA-submission: =?us-ascii?q?MDFSRcVj3cg3moTodpGJiyoaaIybuN5YNEFNvE?=
 =?us-ascii?q?lckKZo2UyxXKOw6iXCfCjjPfxEbX4e1zP0Oqkbg2w7GFfo2STCRgUnD2?=
 =?us-ascii?q?Hi6/k6+SOGo5U35lriAbRMAcURGJ5W1pO+UmLR7npcdvg4I4NkrsMDSv?=
 =?us-ascii?q?J6W6hj0vWx0ZuG+jUtPm7SYg=3D=3D?=
Received: from zeniv.linux.org.uk ([62.89.141.173])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:59:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+T5uj758NieMk8bBUK5X8Wsdb6Nz4WNL4skk6Wb/mi4=; b=nALuQFsynagrv6fdtkvbOEi4wa
	xFxu2dPfwpgnwwMcQNlyukAW6+Xmm2edOvse2IkiZrEh+skoNl5E6ITA7JwK1AdUIO0IvPHxJu3U0
	k/t6IwZ8nlaY1b83Ed9LmmwU6ca8u12pyAXAzJSbn/i53MRbl8pmqn5pG03auGLywnowpaYHJP4n/
	Qz/MPwT1qfoPrYfk0loWgztK8k8BAyNcCAb3Vr3nolBU4cJ0PMUDo/jYh4qYb8VbnBh9ISg87/YZg
	tKO9rRSOg+PJTGUX5RHFoEU9hqNYM20BBd9vV9eVeawcq+Aa8mA9KnnIXJW2IJxFKDX7DxRmEc5Kp
	9/42VFuw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thMos-000000094nn-0SYO;
	Mon, 10 Feb 2025 05:58:58 +0000
Date: Mon, 10 Feb 2025 05:58:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Reaver <me@davidreaver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Message-ID: <20250210055858.GA1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
 <20250210052039.144513-7-me@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-7-me@davidreaver.com>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] [RFC PATCH 6/6] debugfs: Replace debugfs_node #define
 with struct wrapping dentry
Reply-To: Al Viro <viro@zeniv.linux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 2385
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210055858.GA1977892%40ZenIV>

On Sun, Feb 09, 2025 at 09:20:26PM -0800, David Reaver wrote:

> +static inline struct debugfs_node *dentry_to_node(struct dentry *dentry)
> +{
> +	return container_of(dentry, struct debugfs_node, dentry);
> +}

No.  And you don't have any fields left in struct dentry to replace
that with following a pointer.

Again, do not embed struct dentry into any other object; you are not just
doing that on temporary basis, it's left in that form by the end of the
series.  No go.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
