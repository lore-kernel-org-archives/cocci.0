Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BC9C021A1
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 05:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M9jDqz6z9/FQtQkaPFqPQJedPGgr6ZZ+JkD5gQgDg9k=;
  b=AaTYigZuXMRRYM8302ULe6ELT/VqdR02WbH1A1NNQ/k6tLCxkqykCheC
   Owlb7I9IUh+h1q6LnatJAE6N/5LYKjx8N/jRFe4YjK/Y35iohvNwsrwTe
   9+z5qXUoh8zP18b+1Ub7EqlyNAoIhAxlXvI3kn+KgaLCzUC+w+wARChw5
   0=;
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
   d="scan'208";a="207382516"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 06:22:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 099FEE0D27; Mon, 10 Feb 2025 06:22:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B5712E0261
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 06:21:55 +0100 (CET)
IronPort-SDR: 67a98cd5_Q6boxeD6vYMvw6PrDXDMr2dQzy/Y6oMVX/VfY91Fm899UMV
 wTO+sez77ov4ZpnJ5Qa2d4zGXYmluG/XBgHnYBA==
X-IPAS-Result: =?us-ascii?q?A0EhAABVjKlnj5qsqGdaHAEBAQEBAQcBARIBAQQEAQGCA?=
 =?us-ascii?q?QUBAQsBAYJCgVY0BwhIjVKIdIEWnQGBfg8BAwENRAQBAQMBA4UAAosEAh8GA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFS?=
 =?us-ascii?q?YV7DUkBDAGCCwEzcYElAQEBAQEBAQEBAQEBAR0CCGMBAR4CAQMnCwENAQE3A?=
 =?us-ascii?q?Q9RVgYBEoMCgmUCsRAzgQGCDAEBBt4FCYFIAY1KcESEMycbPwGBTYEVgTuBN?=
 =?us-ascii?q?3aIN4JQgjODRF6BDIZdhCeBNoEvgQ+CAIRagV2EDohGSIEhA1ksAVUTDQoLB?=
 =?us-ascii?q?wWBcQMqCwwLFBwVgUZDN4JHaUk6Ag0CNYIeJFiCK4RbhEOES4VYghJ0gRqJI?=
 =?us-ascii?q?EADCxgNSBEsNxQbRG4HngU8g2g0Di8NRAGBJgoLAQ86IxIuCwIwkmyQAYIgn?=
 =?us-ascii?q?0aBPoQloUZNhAOTPkiSSS6YTiKjOG6EZoFuDiWBXDMaCBsVO4JnTwMZD4RQi?=
 =?us-ascii?q?VEMDQmDWMVEJTI8AgcLAQEDCY1Agw+BSwEB?=
IronPort-PHdr: A9a23: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
 BUxj1knCdk=
IronPort-Data: A9a23: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
 wRAKETSyKhIxI69FVFWJcg0F0pNb08x
IronPort-HdrOrdr: A9a23:BKhRfa43sO3e5HQk+wPXwDvXdLJyesId70hD6qm+c20zTiX+rb
 HQoB1/73KZtN9/YgBYpTn+AtjifZqxz+8R3WBVB8bZYOCEghrVEGgB1/qb/9SIIUSXnYQtt5
 uIMZIOdeEYZmIK6/oSjjPId+oI8Z2i3OSQnuHO3x5WLT1CWuVFw0NBEQCLAgldTBVdCfMCda
 a0145ii36adX4abtu2CxA+MdTrlpnuuNbdbRkKCwVP0mazZEuTmcXHLyQ=
X-Talos-CUID: 9a23:PIrLs2Hyffhvvs/EqmJ+t0RNPs40Ukb3zVnhCHScWENwU5CKHAo=
X-Talos-MUID: 9a23:QGKZ9QkVB6iCE1tz+SF/dnpQHclI04DyB3koiIhXmfTaFAlxYT202WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="108618000"
X-MGA-submission: =?us-ascii?q?MDG9oiMugeVEI7qyOO9hCzJ9LnMN+9XNbB7UxJ?=
 =?us-ascii?q?Wb6t7CHSacc2HNYLsl1zSUd4M0oLEWo99PTiqBJ7pStjmL/Rlzr6QgAa?=
 =?us-ascii?q?b/JkuLbtkKg2OkcEZKtcLFBMnbpjo0O2qV2MaNZBYuOOQavRoez905vo?=
 =?us-ascii?q?pj/7KW7qKUmoh0zoKMvp0QXg=3D=3D?=
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:21:25 +0100
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38B791140198;
	Mon, 10 Feb 2025 00:21:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 10 Feb 2025 00:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164883; x=
	1739251283; bh=M9jDqz6z9/FQtQkaPFqPQJedPGgr6ZZ+JkD5gQgDg9k=; b=U
	+CGlf3DrQiXlVkwcs8VvzPdgXg2TCA3uIvCdKBduT+bVwvsQvyxeHdOG7kxIRVYz
	QpHc0ayhXkleUTt6mlUVnyxCn8IqmI9+SYtWirwJgIteYcVXbD28/HptTudcIKat
	7BHOiutjVOz6mNFgjtARlzq4zkE3mUO2/cpoFld5g1bsNZzOSnIjtLnXOCeO4gNy
	uiSnBFcV92dVWUzVTR3DHrCJlwnkf06hif+9n+EPTvNRlX14ZxoKMDW9jvLVlPv0
	IoN74x0waI6pd6H5f2dyB61yKEGFyo7eV4fM3ZAe1nA1VN3nQybWa7bkrwVBGRAu
	zHAAvcuBX4vivNC9gv8Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164883; x=1739251283; bh=M
	9jDqz6z9/FQtQkaPFqPQJedPGgr6ZZ+JkD5gQgDg9k=; b=jrA1PSGC37JLIT4hA
	Us5SZjIqtVtb13EYHqZLta5bDkcXzo4pMhYYG4Mu0XXCWey7hp782XS5qNJ44FgQ
	Xd5nnuNeASIu5jWybDhiuICCs2qTpBlZHR8G00d7xA/KaY9cVcxf9WqDA2bjWIg3
	Iayoi/l/0pry96vqUlxpSaR3VK8j9RejV19tVcVm7Ug+embAxvgNRHcUXOvep0As
	AOKIR8zyqY/OPmXn3RPzDc9VL2+m9Y667xvRSoCJOn/5HoAV5yVOVJ5nPPW25h3p
	ZIhbpMW15lN5TIwVIQSRWb54owGW/IrAMKAUmSynFNUKJ0XTGfVo4RuirYrDPaKy
	sCCCA==
X-ME-Sender: <xms:0oypZ5IECP_uTViwdOM_lTQF_3iijBP7khAL4AOK9qAiKeTMz2QW-w>
    <xme:0oypZ1I6E-XYxDGyG1ynxahurxU5e19MDvbPWxxza1xeDEQW0ftr2x7Bw0AFFV4Mv
    s1Dxu1eJAgEM17sOg0>
X-ME-Received: <xmr:0oypZxvZjab_t69tvOeswYcnKdlCJWrQlMEIsugt-F-NdoJm82fqg3g8jwmulG4YvXcCx_Ykp1jcPgYmUNy0TgBhgp4X46zWszAFplWhE90-FMA>
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
X-ME-Proxy: <xmx:0oypZ6YeOy_VdbQho6Vkt94n6c6OFozdWY_3bY7VmLk1b-bAKa6CdA>
    <xmx:0oypZwb1AKt2hVWxpnSy0AVpCyNS5UCPgMANnaWtLsZZl2yZb_45hQ>
    <xmx:0oypZ-BT-kFqq_g3qoO4T6_8WXlQTFzigGB1Fu82du38KzarPVXGcQ>
    <xmx:0oypZ-aHDgSE2XaHFGByzhQVsVk-h0ndld-hxnN7lpzw86V4ENvtWg>
    <xmx:04ypZ9TURkREWgJIurjCWgcfGNWUTGaKtrgiP-Pd-c0Eb9nXgcLQ7RGN>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:21 -0500 (EST)
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
Date: Sun,  9 Feb 2025 21:20:23 -0800
Message-ID: <20250210052039.144513-4-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [RFC PATCH 3/6] relay: Replace dentry with debugfs_node
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2380
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210052039.144513-4-me%40davidreaver.com>

Although the relay documentation suggests support for multiple filesystems,
in practice all existing users rely on debugfs. This commit updates the
relay API and documentation to use debugfs_node instead of dentry, making
the subsequent migration of relay users to debugfs_node smoother.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 Documentation/filesystems/relay.rst | 32 +++++------
 include/linux/relay.h               | 19 ++++---
 kernel/relay.c                      | 88 ++++++++++++++---------------
 3 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/Documentation/filesystems/relay.rst b/Documentation/filesystems/relay.rst
index 04ad083cfe62..b0ee7dcab8e7 100644
--- a/Documentation/filesystems/relay.rst
+++ b/Documentation/filesystems/relay.rst
@@ -15,8 +15,8 @@ clients write into the channel buffers using efficient write
 functions; these automatically log into the current cpu's channel
 buffer.  User space applications mmap() or read() from the relay files
 and retrieve the data as it becomes available.  The relay files
-themselves are files created in a host filesystem, e.g. debugfs, and
-are associated with the channel buffers using the API described below.
+themselves are files created in debugfs and are associated with the
+channel buffers using the API described below.
 
 The format of the data logged into the channel buffers is completely
 up to the kernel client; the relay interface does however provide
@@ -185,7 +185,7 @@ TBD(curr. line MT:/API/)
     buf_mapped(buf, filp)
     buf_unmapped(buf, filp)
     create_buf_file(filename, parent, mode, buf, is_global)
-    remove_buf_file(dentry)
+    remove_buf_file(node)
 
   helper functions::
 
@@ -203,12 +203,10 @@ read from in user space.  The files are named basename0...basenameN-1
 where N is the number of online cpus, and by default will be created
 in the root of the filesystem (if the parent param is NULL).  If you
 want a directory structure to contain your relay files, you should
-create it using the host filesystem's directory creation function,
-e.g. debugfs_create_dir(), and pass the parent directory to
+create it using debugfs_create_dir(), and pass the parent directory to
 relay_open().  Users are responsible for cleaning up any directory
-structure they create, when the channel is closed - again the host
-filesystem's directory removal functions should be used for that,
-e.g. debugfs_remove().
+structure they create, when the channel is closed with
+debugfs_remove().
 
 In order for a channel to be created and the host filesystem's files
 associated with its channel buffers, the user must provide definitions
@@ -216,7 +214,7 @@ for two callback functions, create_buf_file() and remove_buf_file().
 create_buf_file() is called once for each per-cpu buffer from
 relay_open() and allows the user to create the file which will be used
 to represent the corresponding channel buffer.  The callback should
-return the dentry of the file created to represent the channel buffer.
+return the node of the file created to represent the channel buffer.
 remove_buf_file() must also be defined; it's responsible for deleting
 the file(s) created in create_buf_file() and is called during
 relay_close().
@@ -227,22 +225,22 @@ using debugfs::
     /*
     * create_buf_file() callback.  Creates relay file in debugfs.
     */
-    static struct dentry *create_buf_file_handler(const char *filename,
-						struct dentry *parent,
-						umode_t mode,
-						struct rchan_buf *buf,
-						int *is_global)
+    static struct debugfs_node *create_buf_file_handler(const char *filename,
+							struct debugfs_node *parent,
+							umode_t mode,
+							struct rchan_buf *buf,
+							int *is_global)
     {
 	    return debugfs_create_file(filename, mode, parent, buf,
-				    &relay_file_operations);
+				       &relay_file_operations);
     }
 
     /*
     * remove_buf_file() callback.  Removes relay file from debugfs.
     */
-    static int remove_buf_file_handler(struct dentry *dentry)
+    static int remove_buf_file_handler(struct debugfs_node *node)
     {
-	    debugfs_remove(dentry);
+	    debugfs_remove(node);
 
 	    return 0;
     }
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..75d5a147ea9e 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -22,6 +22,7 @@
 #include <linux/poll.h>
 #include <linux/kref.h>
 #include <linux/percpu.h>
+#include <linux/debugfs.h>
 
 /*
  * Tracks changes to rchan/rchan_buf structs
@@ -41,7 +42,7 @@ struct rchan_buf
 	struct rchan *chan;		/* associated channel */
 	wait_queue_head_t read_wait;	/* reader wait queue */
 	struct irq_work wakeup_work;	/* reader wakeup */
-	struct dentry *dentry;		/* channel file dentry */
+	struct debugfs_node *node;	/* channel file node */
 	struct kref kref;		/* channel buffer refcount */
 	struct page **page_array;	/* array of current buffer pages */
 	unsigned int page_count;	/* number of current buffer pages */
@@ -69,7 +70,7 @@ struct rchan
 	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
-	struct dentry *parent;		/* parent dentry passed to open */
+	struct debugfs_node *parent;	/* parent node passed to open */
 	int has_base_filename;		/* has a filename associated? */
 	char base_filename[NAME_MAX];	/* saved base filename */
 };
@@ -117,7 +118,7 @@ struct rchan_callbacks
 	 * created outside of relay, the parent must also exist in
 	 * that filesystem.
 	 *
-	 * The callback should return the dentry of the file created
+	 * The callback should return the debugfs_node of the file created
 	 * to represent the relay buffer.
 	 *
 	 * Setting the is_global outparam to a non-zero value will
@@ -128,15 +129,15 @@ struct rchan_callbacks
 	 *
 	 * See Documentation/filesystems/relay.rst for more info.
 	 */
-	struct dentry *(*create_buf_file)(const char *filename,
-					  struct dentry *parent,
+	struct debugfs_node *(*create_buf_file)(const char *filename,
+					  struct debugfs_node *parent,
 					  umode_t mode,
 					  struct rchan_buf *buf,
 					  int *is_global);
 
 	/*
 	 * remove_buf_file - remove file representing a relay channel buffer
-	 * @dentry: the dentry of the file to remove
+	 * @node: the debugfs_node of the file to remove
 	 *
 	 * Called during relay_close(), once for each per-cpu buffer,
 	 * to allow the client to remove a file used to represent a
@@ -146,7 +147,7 @@ struct rchan_callbacks
 	 *
 	 * This callback is mandatory.
 	 */
-	int (*remove_buf_file)(struct dentry *dentry);
+	int (*remove_buf_file)(struct debugfs_node *node);
 };
 
 /*
@@ -154,14 +155,14 @@ struct rchan_callbacks
  */
 
 struct rchan *relay_open(const char *base_filename,
-			 struct dentry *parent,
+			 struct debugfs_node *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
 			 const struct rchan_callbacks *cb,
 			 void *private_data);
 extern int relay_late_setup_files(struct rchan *chan,
 				  const char *base_filename,
-				  struct dentry *parent);
+				  struct debugfs_node *parent);
 extern void relay_close(struct rchan *chan);
 extern void relay_flush(struct rchan *chan);
 extern void relay_subbufs_consumed(struct rchan *chan,
diff --git a/kernel/relay.c b/kernel/relay.c
index a8ae436dc77e..16cf9098d697 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -337,18 +337,18 @@ void relay_reset(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_reset);
 
-static inline void relay_set_buf_dentry(struct rchan_buf *buf,
-					struct dentry *dentry)
+static inline void relay_set_buf_node(struct rchan_buf *buf,
+				      struct debugfs_node *node)
 {
-	buf->dentry = dentry;
-	d_inode(buf->dentry)->i_size = buf->early_bytes;
+	buf->node = node;
+	debugfs_node_inode(buf->node)->i_size = buf->early_bytes;
 }
 
-static struct dentry *relay_create_buf_file(struct rchan *chan,
-					    struct rchan_buf *buf,
-					    unsigned int cpu)
+static struct debugfs_node *relay_create_buf_file(struct rchan *chan,
+						  struct rchan_buf *buf,
+						  unsigned int cpu)
 {
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	char *tmpname;
 
 	tmpname = kzalloc(NAME_MAX + 1, GFP_KERNEL);
@@ -357,15 +357,15 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
 
 	/* Create file in fs */
-	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
-					   S_IRUSR, buf,
-					   &chan->is_global);
-	if (IS_ERR(dentry))
-		dentry = NULL;
+	node = chan->cb->create_buf_file(tmpname, chan->parent,
+					 S_IRUSR, buf,
+					 &chan->is_global);
+	if (IS_ERR(node))
+		node = NULL;
 
 	kfree(tmpname);
 
-	return dentry;
+	return node;
 }
 
 /*
@@ -376,7 +376,7 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
 	struct rchan_buf *buf;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 
  	if (chan->is_global)
 		return *per_cpu_ptr(chan->buf, 0);
@@ -386,16 +386,16 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		return NULL;
 
 	if (chan->has_base_filename) {
-		dentry = relay_create_buf_file(chan, buf, cpu);
-		if (!dentry)
+		node = relay_create_buf_file(chan, buf, cpu);
+		if (!node)
 			goto free_buf;
-		relay_set_buf_dentry(buf, dentry);
+		relay_set_buf_node(buf, node);
 	} else {
 		/* Only retrieve global info, nothing more, nothing less */
-		dentry = chan->cb->create_buf_file(NULL, NULL,
-						   S_IRUSR, buf,
-						   &chan->is_global);
-		if (IS_ERR_OR_NULL(dentry))
+		node = chan->cb->create_buf_file(NULL, NULL,
+						 S_IRUSR, buf,
+						 &chan->is_global);
+		if (IS_ERR_OR_NULL(node))
 			goto free_buf;
 	}
 
@@ -426,7 +426,7 @@ static void relay_close_buf(struct rchan_buf *buf)
 {
 	buf->finalized = 1;
 	irq_work_sync(&buf->wakeup_work);
-	buf->chan->cb->remove_buf_file(buf->dentry);
+	buf->chan->cb->remove_buf_file(buf->node);
 	kref_put(&buf->kref, relay_remove_buf);
 }
 
@@ -454,7 +454,7 @@ int relay_prepare_cpu(unsigned int cpu)
 /**
  *	relay_open - create a new relay channel
  *	@base_filename: base name of files to create, %NULL for buffering only
- *	@parent: dentry of parent directory, %NULL for root directory or buffer
+ *	@parent: node of parent directory, %NULL for root directory or buffer
  *	@subbuf_size: size of sub-buffers
  *	@n_subbufs: number of sub-buffers
  *	@cb: client callback functions
@@ -468,11 +468,11 @@ int relay_prepare_cpu(unsigned int cpu)
  *	permissions will be %S_IRUSR.
  *
  *	If opening a buffer (@parent = NULL) that you later wish to register
- *	in a filesystem, call relay_late_setup_files() once the @parent dentry
+ *	in a filesystem, call relay_late_setup_files() once the @parent node
  *	is available.
  */
 struct rchan *relay_open(const char *base_filename,
-			 struct dentry *parent,
+			 struct debugfs_node *parent,
 			 size_t subbuf_size,
 			 size_t n_subbufs,
 			 const struct rchan_callbacks *cb,
@@ -538,40 +538,40 @@ EXPORT_SYMBOL_GPL(relay_open);
 
 struct rchan_percpu_buf_dispatcher {
 	struct rchan_buf *buf;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 };
 
 /* Called in atomic context. */
-static void __relay_set_buf_dentry(void *info)
+static void __relay_set_buf_node(void *info)
 {
 	struct rchan_percpu_buf_dispatcher *p = info;
 
-	relay_set_buf_dentry(p->buf, p->dentry);
+	relay_set_buf_node(p->buf, p->node);
 }
 
 /**
  *	relay_late_setup_files - triggers file creation
  *	@chan: channel to operate on
  *	@base_filename: base name of files to create
- *	@parent: dentry of parent directory, %NULL for root directory
+ *	@parent: node of parent directory, %NULL for root directory
  *
  *	Returns 0 if successful, non-zero otherwise.
  *
  *	Use to setup files for a previously buffer-only channel created
- *	by relay_open() with a NULL parent dentry.
+ *	by relay_open() with a NULL parent node.
  *
  *	For example, this is useful for perfomring early tracing in kernel,
- *	before VFS is up and then exposing the early results once the dentry
+ *	before VFS is up and then exposing the early results once the node
  *	is available.
  */
 int relay_late_setup_files(struct rchan *chan,
 			   const char *base_filename,
-			   struct dentry *parent)
+			   struct debugfs_node *parent)
 {
 	int err = 0;
 	unsigned int i, curr_cpu;
 	unsigned long flags;
-	struct dentry *dentry;
+	struct debugfs_node *node;
 	struct rchan_buf *buf;
 	struct rchan_percpu_buf_dispatcher disp;
 
@@ -593,9 +593,9 @@ int relay_late_setup_files(struct rchan *chan,
 		err = -EINVAL;
 		buf = *per_cpu_ptr(chan->buf, 0);
 		if (!WARN_ON_ONCE(!buf)) {
-			dentry = relay_create_buf_file(chan, buf, 0);
-			if (dentry && !WARN_ON_ONCE(!chan->is_global)) {
-				relay_set_buf_dentry(buf, dentry);
+			node = relay_create_buf_file(chan, buf, 0);
+			if (node && !WARN_ON_ONCE(!chan->is_global)) {
+				relay_set_buf_node(buf, node);
 				err = 0;
 			}
 		}
@@ -617,23 +617,23 @@ int relay_late_setup_files(struct rchan *chan,
 			break;
 		}
 
-		dentry = relay_create_buf_file(chan, buf, i);
-		if (unlikely(!dentry)) {
+		node = relay_create_buf_file(chan, buf, i);
+		if (unlikely(!node)) {
 			err = -EINVAL;
 			break;
 		}
 
 		if (curr_cpu == i) {
 			local_irq_save(flags);
-			relay_set_buf_dentry(buf, dentry);
+			relay_set_buf_node(buf, node);
 			local_irq_restore(flags);
 		} else {
 			disp.buf = buf;
-			disp.dentry = dentry;
+			disp.node = node;
 			smp_mb();
 			/* relay_channels_mutex must be held, so wait. */
 			err = smp_call_function_single(i,
-						       __relay_set_buf_dentry,
+						       __relay_set_buf_node,
 						       &disp, 1);
 		}
 		if (unlikely(err))
@@ -669,8 +669,8 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
 		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
 		buf->padding[old_subbuf] = buf->prev_padding;
 		buf->subbufs_produced++;
-		if (buf->dentry)
-			d_inode(buf->dentry)->i_size +=
+		if (buf->node)
+			debugfs_node_inode(buf->node)->i_size +=
 				buf->chan->subbuf_size -
 				buf->padding[old_subbuf];
 		else
