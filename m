Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E691C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/M2Nru2NZro488gTVTzJhmdDjcvACD8WWOsTwksoVh4=;
  b=Iip6kkrzYGrs1aDh4hl9Pv289SUQmd+iIZkkcP26TVSgXzsAoHFx9Jku
   V0XNedASWyyMiMUfFdS3RHGcGsz3vbjUD6vQLFo0swy7expLjF6X7Xfym
   UBswL0uy3orZKZ2CEVtRj4vMMZYs3uPx5TGw3J4pieG62JsShg/+jUfOe
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
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207382496"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 06:22:00 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50D63E0D1E; Mon, 10 Feb 2025 06:22:00 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 32765E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 06:21:55 +0100 (CET)
IronPort-SDR: 67a98cd4_iJbT71rFoEad9FS/Dn9zOwR7Y5j1ufL4E94vpHgGj//HRS7
 lIO7Dh830F+L4bPs4oF2sn9yvHLmenjpCjwiWHg==
X-IPAS-Result: =?us-ascii?q?A0FEAABVjKlnj5esqGdaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?gQBAQsBAYJCgVY0BwhIjVKpCQ8BAwENRAQBAQMBA4UAAosEAh8GAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DUkBD?=
 =?us-ascii?q?AGCCwEzcYElAQEBAQEBAQEBAQEBAR0CCGMBAR4CAQMnCwENAQE3AQ9RVgYBE?=
 =?us-ascii?q?oMCgmUCsRAzgQGCDAEBBt4FCYFIAY1KcIR3Jxs/AYFNgRWDaIg3glCFd4Fqp?=
 =?us-ascii?q?ANIgSEDWSwBVRMNCgsHBYFxAyoLDAsUHBUygRRDN4JHaUk6Ag0CNYIeJFiCK?=
 =?us-ascii?q?4RbhEOES4VYghJ0gRqJIEADCxgNSBEsNxQbRG4HngU8g2c1WDeCdaMdgiChB?=
 =?us-ascii?q?IQloUZNl0GTES6YTiKjCoEchGaBfSSBXDMaCBsVgyJPAxkPjiEMDQmDWMVEJ?=
 =?us-ascii?q?TI8AgcLAQEDCY1Agw+BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:slUtuq/9wciw0Jrh8sZuk+ArI+orL9Y04lQ7vn2ZhyYlFfBw8P
 re48jzsCWY5Ar5N0tQ4OxoR5PwIk80maQFhLX5eI3SJjUO21HYUL2Kj7GSuwEIcheWnoU2pM
 VdmupFeaDN5DNB/KDHCWeDYrId6ejC1IztvPzZ3mcFd2FXQpAlyys8Mx2cA10zbgFbH5ZRLv
 uhz/sCgxblQngcYsSlCnRtZYb+juyOsL6jWxIAChI9gTPgsdrR0s+ALySl
X-Talos-CUID: 9a23:Z/8H921F/SLqTV8lDbrFDLxfHcU3f3aHlk7qPFahDmJvQrOvQ1+y9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A31oouw73bLx7UHzbEqGB+pmOxoxts6S1T2U0nq4?=
 =?us-ascii?q?4lPKlMR5uBymm3Qq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="108617999"
X-MGA-submission: =?us-ascii?q?MDGtVHHwgro9lAGazCSIwea4WXPDKCtNukUUZF?=
 =?us-ascii?q?DLXv3Y5MJkie4/HYdk1/Po1NAbve5WyL1VEK92XKJhidyLMS34AfZH1W?=
 =?us-ascii?q?Qx2aHdQQdB1RoFqv0ViM3WzlYFUCPun2zj0MRXvb0nAZC9uIaYsJ5JPN?=
 =?us-ascii?q?RGKlFktguusq2FKlIz1KNESg=3D=3D?=
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:21:24 +0100
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 00D6F138010C;
	Mon, 10 Feb 2025 00:21:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 00:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164880; x=
	1739251280; bh=/M2Nru2NZro488gTVTzJhmdDjcvACD8WWOsTwksoVh4=; b=e
	N+YVGFHiY3Y/gF/cpS0Mh+bC4gVAgX8HwHHQonFV/uxvYtGd+2aVSrSfK8w7raCb
	ZdQlJknLRyndLWN7N8zabhZ/I6i1grQEWBe1UsJ0+oAmbA5XUgmzgAH1+4Oti9me
	QK6eIYpYqyKoJvX99CsIMXWAUkISM3G9mguW6+1GN5WiI03SnUIy/jTuGozvkYjB
	kHkGh2RtOHoEzwgyd/jgf3WS9qq3VMr4NSLzMMAaszNyna1tIjGmT1rvlGK0WV2L
	ZTn9/Xn7sRTgHePIRciGNUXwzcnVcIXy10mx9UomSHernqT4BTSmp+7nsKbdCP+W
	ce/7g+PUgAw6YXZ7FCGXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164880; x=1739251280; bh=/
	M2Nru2NZro488gTVTzJhmdDjcvACD8WWOsTwksoVh4=; b=y7XXu+U2Z0pF9JM2I
	YGsbX662Nw6O8Ef2ZPF3G3KfC/cBGymONrxgZrIR/mL01L4d45tNbBFnRJrRVYYL
	66/LBbbqejibI3VPjo8lBLjXTA9WQFOuI858pznRMhJQ53B/uXj6Vw/JIMr7/bOc
	N9zYv6xv98dlynRlMMha95G5YZTtSOOY9b/BqYi3YiftnIWKgNy6VShbpqHaVtBx
	DKf+MkFtV8G71Zsj8wGj8mlzzflN6MLjzXGfzw4h24JiK3gy2UJHYNjUMVKw4euE
	ebc2liN9UEPHfcFOXV8/h0nsXe6mqTZFXPr1vq7KDXtxGAf918Hi7YMU4LiAOlAQ
	D4a0Q==
X-ME-Sender: <xms:0IypZ5EQINYkMcUZJK17vmn5CrBuS0L1k1KcE2Zt4klW7F9NQoKRUw>
    <xme:0IypZ-VvK0YZAeYRmkQZoL3a_bJZ9n4Z-c5lNkuOqzJIK-mxt16bFq0na3mHyyI7b
    cCIdHwpXC8iiWGzhEA>
X-ME-Received: <xmr:0IypZ7K6gpvON7wYtxXDBvfS9AXWwXkS4fI1SJD68z_8I4LUumuULEKTzSw44V2nGI83TZmB74r5N8zs7CcE8fY_og68c6XO9gD4TchoIO03dqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudevteffveeuuddtkedtvedtteeutdefvdeg
    hffhjeeiveegvdetvdejteejleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvghgkhhhse
    hlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshht
    vgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdr
    uhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-ME-Proxy: <xmx:0IypZ_HVYGe_UJ_lfrg7oQ81Mvcx1xnWVu2M_G1DB4VvuudneeastA>
    <xmx:0IypZ_Vh4XhuoTFEune1QNdJJwF9EPE7udYUnJPqvnwf7ECuu6z_YA>
    <xmx:0IypZ6Nvuzrn71dUm7n6oN4yv9Mbc_tlKYnTF-ZhgHGc8bz7E7i8yg>
    <xmx:0IypZ-2L_B4aftB5ye4axSbl9dcGiGFm_C2EmljOaNN9UXZqreceVQ>
    <xmx:0IypZ4NbaEcdiw1vFe-px8kM2gDBIC3qNFsp3mNoWb07uggKuqnFiW5_>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:19 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Sun,  9 Feb 2025 21:20:22 -0800
Message-ID: <20250210052039.144513-3-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [RFC PATCH 2/6] debugfs: Add helper functions for
 debugfs_node encapsulation
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2379
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210052039.144513-3-me%40davidreaver.com>

Once debugfs_node becomes a struct, users will need helper functions since
direct access to the underlying dentry will no longer be possible. This
commit introduces these helpers, which will be used in the automated
Coccinelle conversion.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 fs/debugfs/inode.c      | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 75715d8877ee..6892538d9d49 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -353,6 +353,44 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
+char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen)
+{
+	return dentry_path_raw(node, buf, buflen);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_path_raw);
+
+struct debugfs_node *debugfs_node_get(struct debugfs_node *node)
+{
+	return dget(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_get);
+
+void debugfs_node_put(struct debugfs_node *node)
+{
+	dput(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_put);
+
+struct inode *debugfs_node_inode(struct debugfs_node *node)
+{
+	return d_inode(node);
+}
+EXPORT_SYMBOL_GPL(debugfs_node_inode);
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry)
+{
+	if (dentry->d_sb->s_op == &debugfs_super_operations)
+		return dentry;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(debugfs_node_from_dentry);
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node)
+{
+	return node;
+}
+EXPORT_SYMBOL_GPL(debugfs_node_dentry);
+
 static struct dentry *start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index e6ee571e8c36..738a990f99cd 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -79,6 +79,18 @@ struct debugfs_short_fops {
 
 struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
 
+char *debugfs_node_path_raw(struct debugfs_node *node, char *buf, size_t buflen);
+
+struct debugfs_node *debugfs_node_get(struct debugfs_node *node);
+
+void debugfs_node_put(struct debugfs_node *node);
+
+struct inode *debugfs_node_inode(struct debugfs_node *node);
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry);
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node);
+
 struct dentry *debugfs_create_file_full(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const void *aux,
@@ -271,6 +283,35 @@ static inline struct dentry *debugfs_lookup(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline char *debugfs_node_path_raw(struct debugfs_node *node, char *buf,
+					  size_t buflen)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct debugfs_node *debugfs_node_get(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+void debugfs_node_put(struct debugfs_node *node)
+{ }
+
+struct inode *debugfs_node_inode(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct debugfs_node *debugfs_node_from_dentry(struct dentry *dentry)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+struct dentry *debugfs_node_dentry(struct debugfs_node *node)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_file_aux(const char *name,
 					umode_t mode, struct dentry *parent,
 					void *data, void *aux,
