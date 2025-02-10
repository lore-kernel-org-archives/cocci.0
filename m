Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1DBC021A1
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GXDpGKMgcY+JAEBNv/Xlu0NnEc1xzI1Njjd5bVIHNog=;
  b=ApPomacjJ7PfOozdgT98cJkPdhgyb/6xbpVPSHrmCbcW7f1auuFZh9+y
   n1CZta9odwj78kCGgT/5Q98HnXO22mCZjoFLSIcCS24NelZ66GaZmSOhv
   yXhSZ3ePEmM0qQwnsu8uRnNHbRcCQDz3JFx44ZmsFQVf9ACubP5B7VsbG
   M=;
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
   d="scan'208";a="207382446"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 06:21:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D934E0D1E; Mon, 10 Feb 2025 06:21:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 94C6AE0D27
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 06:21:20 +0100 (CET)
IronPort-SDR: 67a98ccf_4bvnusCiox4f4QUJtiws3MbVJaqBEKNyd4PMclX4b5HlbDM
 wGiLQrFDeRnimy6lIe3HorX2WTAVCUarb5BdJIQ==
X-IPAS-Result: =?us-ascii?q?A0HIAQBVjKlnj5esqGdaHgEBCxIMgggLAoJCgVY0BwhIj?=
 =?us-ascii?q?VKpCQ8BAwENRAQBAQMBA4UAAosEAh8GAQQzBg4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DUkBDAGCCwGBJIElAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CCGMBHwIBAycLAQ0BATcBD1FWBgESgwKCZQKxEDOBAYIMAQEG3?=
 =?us-ascii?q?gUJgUiNS3CEdycbPwGBTYJQgi2IN4JQh2GOeIg3jFRIgSEDWSwBVRMNCgsHB?=
 =?us-ascii?q?YFxAyoLDAsUHBWBRkM3gkdpSToCDQI1gh4kWIIrhFuEQ4RLhViCEnSBGokgQ?=
 =?us-ascii?q?AMLGA1IESw3FBtEbgeeBTyEHIEPgRunF6EEhCWhRk2XQZMRLodskGIipCaEZ?=
 =?us-ascii?q?oF9JIFcMxoIGxWDIk8DGQ+OIQwNCYNYxUQlMjwCBwsBAQMJjUCCWywIgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:jyUBf6MKkWdNWMBcTjKjsMiBIKoaSvp037Dk7TEXdfUzSL3mqy
 nKppl26faaskdpZJheo6HiBEDtewK4yXcx2/hqAV7AZnibhILLFvAb0WKK+VSJcEeOlNK1l5
 0QDpSWY+eAa2SS4/yKhDWQIpIF7J2/66a4lY7lr0tFfEVPR+VY9AFpGkKwGlFtSGB9ZKYRJd
 65yo59qzCteWsaY62AaEUtbqzmi5nwmJXqbQVuPXEaAXG1/EiV1II=
X-Talos-CUID: =?us-ascii?q?9a23=3AvyLzDmpOPXSybxtV0ZB81bPmUd83cybWl0nJGUq?=
 =?us-ascii?q?xKlxib+3SFkG95qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AyKipHwzzfUpaufDweQVO7NAVDSaaqK2PGWERmro?=
 =?us-ascii?q?Mh8SJDgAuawqaqxm0G6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,273,1732575600"; 
   d="scan'208";a="207382413"
X-MGA-submission: =?us-ascii?q?MDEJdCint3rFhSFkGKsq7ek+NT+U2hj3y9OeNv?=
 =?us-ascii?q?nvbB7yCXZ501tDoEOho3a7bojdkihkcesjNx35IQ+lR5+zcuEtsS6r/8?=
 =?us-ascii?q?oabAnO04f3xGlVLimp8tbxOVfp7dUbXG3AzwIK/vh5nS7t+JW41bTKW3?=
 =?us-ascii?q?E9dQivpc/Es07rAkuZPqDQ1A=3D=3D?=
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:21:19 +0100
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 56F94138014C;
	Mon, 10 Feb 2025 00:21:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Feb 2025 00:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739164878; x=
	1739251278; bh=GXDpGKMgcY+JAEBNv/Xlu0NnEc1xzI1Njjd5bVIHNog=; b=k
	6uHerG0uAjXSLWOUKvYLIp15nyfW55xmLcgDs4VenhADqANihgDDofcaAxs2/An+
	sybw63Ohs7W3j08QSOtzHonkFwXrtO6kMX9hI3D0Ishn+CRKW/VKso3T1c7O50WA
	c5+UHq2X0f57qjfd8oYImQuofrSE9PgLDIWQydDwV5aRcTM1ZGzTdgYOAvxmjQCh
	1YJKOgPjn8pDT6Ug//I3eXFzpBqM5QWmaUFfJbsC/boDjW3Co9KscoQHqD4gwkLO
	IDW7cwpIzAhJdHLVwlu3VkkWlYai6l4MiwEMYPA9HiaOuf8YbQ0TkZgFZMsijuKc
	9qypXnja74uMRwVaUAdsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739164878; x=1739251278; bh=G
	XDpGKMgcY+JAEBNv/Xlu0NnEc1xzI1Njjd5bVIHNog=; b=ujMgz1H9c9dR6nVwm
	S/ULZTFRdroJX9QnzHpZ4GfMFwqhLbAI2ln8N6g4YhFb6Hp7EP5ZOlWeJYiEHbHR
	BDh4DbK8zOftSORlXZR2HOc4c+7EQRD0YonkGBIpI7FPP2Fi1jv70gbJOrBFX9Q8
	W4X0VPUSNoukzV1OW/5z04qhWpOnNyFFfs2vB9elNi0JPJhAeZIDEOBZKxPo+AQM
	pjW+7e8qVqIbseDOoA0+BW/7daM4fcWCX3cWlnD9WwV9wyOYd8zAVI4hKr83CKFK
	LDtugryCYfrbXp9V7KV1W2zqUUSQBNDnGV6PrB4VJl7odb5thFxKZEVoJTkuxb3C
	RZ5Xg==
X-ME-Sender: <xms:zoypZ5eOHdGqreM_SQWIdCRpG9QQqMCWcMVaYJz9Qc1-dH-nAeHDxw>
    <xme:zoypZ3N820R1HpK-lXkfDYvWfrzXYwJ3EuRwBHwFGV91KBX-aQAHTaIiARVPMRJYv
    6ohlzx1j-nEmo-V8GY>
X-ME-Received: <xmr:zoypZyinp-79rcTu1V3qR8YUMIJKZfHWhVsQ1GcjrvZksDOFOFjR4kDjiq_1DTihvK2ySsvafhvfKKM6pwXsCJiReau3MlxETyzpQ7MYJlFY9Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjedulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:zoypZy-IU0u4T3DONKl-ZJYVzvb-9LzTzlXooDV6bm7ayDQ1SVixNw>
    <xmx:zoypZ1v6gqhSVOednqTFibVOLiiVSYYh9hlHyggFacpRWz-03IOsSA>
    <xmx:zoypZxH3fKNcsM2I7yAkaL-SKQNkorxUikpvCyvkc8FfuuVKTW9hIA>
    <xmx:zoypZ8MJeNb1m44uStnF-8FsyqkZAciLkYChp6Bn02dB4txuFLbyxA>
    <xmx:zoypZ2nZ2PD2GZlXKZJSiUCkFtc1uQaXitbeFcjDEowzomtw_JZ_iKnv>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 00:21:16 -0500 (EST)
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
Date: Sun,  9 Feb 2025 21:20:21 -0800
Message-ID: <20250210052039.144513-2-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>
References: <20250210052039.144513-1-me@davidreaver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [cocci] [RFC PATCH 1/6] debugfs: Add temporary "#define
 debugfs_node dentry" directives
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2378
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250210052039.144513-2-me%40davidreaver.com>

Add some temporary "#define debugfs_node dentry" directives to facilitate
migrating debugfs APIs from dentry to a new opaque descriptor,
debugfs_node. Subsequent commits that replace dentry with debugfs_node rely
on these #defines until the final commit in this series removes them.

This is also added to dcache.h, right below struct dentry, so it is
available where dentry is transitively included.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 include/linux/dcache.h  | 2 ++
 include/linux/debugfs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4afb60365675..4b0c11cd3d50 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,6 +127,8 @@ struct dentry {
 	} d_u;
 };
 
+#define debugfs_node dentry
+
 /*
  * dentry->d_lock spinlock nesting subclasses:
  *
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index fa2568b4380d..e6ee571e8c36 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -21,6 +21,8 @@
 struct device;
 struct file_operations;
 
+#define debugfs_node dentry
+
 struct debugfs_blob_wrapper {
 	void *data;
 	unsigned long size;
