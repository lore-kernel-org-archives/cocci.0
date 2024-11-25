Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F261DD58D6D
	for <cocci@archiver.kernel.org>; Mon, 25 Nov 2024 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   reply-to:mime-version:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=z8toJKTqYgiOm8yX0/nayZUss8l7ma5sqSjl7KCBpF0=;
  b=p6RwqhwkXikTplWue3U5IOzjTd4+rU2Ur0EnCY7j/0wXKZKsjGXOdHcM
   X3x3QemQbQrTuvowIhqGRGrb6YMKahj8Yvd6/SPjR26947pd7hPXV6A9y
   oavUtB7cwoMPbqvChKEBuOU8CQPTCEeher34zRyGzYN05qEFh9CB7cvdD
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@seltendoof.de
X-IronPort-AV: E=Sophos;i="6.12,183,1728943200"; 
   d="scan'208";a="195724172"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Nov 2024 17:57:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED26CE0D69; Mon, 25 Nov 2024 17:57:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6EB82E0133
	for <cocci@sympa.inria.fr>; Mon, 25 Nov 2024 11:40:35 +0100 (CET)
IronPort-SDR: 67445422_KM3tW3G9ng0H6/Udw9R4vQDoZp2faUYy3lMkmpTR7unFB0Y
 QQUdVF2ozZ5G+G76lX92jOsyDie+iwYDsk8nyOQ==
X-IPAS-Result: =?us-ascii?q?A0EhAADMUkRn/6Mwd6haHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDB2lmNAQLSIRWiB2HMIIhA5FKjE0ggV4PAQMBDUQEAQEDAQOFA?=
 =?us-ascii?q?AKKWQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAoEKE?=
 =?us-ascii?q?4V7DYJiAXSBJAEBAQEBAQEBAScrAoELAgEDIwQLAQ0BATcBDyAFAhgOAgI9A?=
 =?us-ascii?q?RgZgwGCMQEBATEDr3J/M4EBggwBAQaCUNguBAoaDYEwgSAJgRouAYhLAYVQG?=
 =?us-ascii?q?YN9eicbgg2EfYIfgXt2gw6CaYJEgTGDXiWFN4NJmzMHB2FeHANZIREBVRMXC?=
 =?us-ascii?q?wcFgXYDg0aBNiiBKYMRSoUMRj2CSmlNNwINAjaCJH2CTYUZg0aBI2UvAwMDA?=
 =?us-ascii?q?4ITgSuGBh03CQMLbT03CAwbBj0IQh0SoBtGg0EHAYENMB0uYHCTF4NPAa9sC?=
 =?us-ascii?q?4I/gWWKdpZNTZdRkwCIL5BMo3IBhTVggQc9gVlxggEagRtPAxkPjiGELccQR?=
 =?us-ascii?q?TI7AgcBCgEBAwmCOY5NNIFLAQE?=
IronPort-PHdr: A9a23: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
 JdcEtdm
IronPort-Data: A9a23:PNFrCazKqRf4fBCXAyl6t+eTzSrEfRIJ4+MujC+fZmUNrF6WrkUPz
 GobCGCFOviLMDf8f90nOtmw900B7ZCEzYUyGQpr+1hgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmQc3l48sfrZ9Eo25qiq4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFP2nc5AXHk3OrYU+8V0KjAT0
 scBCxESO0Xra+KemNpXS8F3i949IdOzZsUEt3V8wDfVCvEoB5zOK0nIzYYGjHFp35EIQaaYP
 pRCAdZsREyojxlnMVgQBY4ih+yoi1HkfjlEpVSZoq05pWTepOB0+OG1aoeJJIHRH625mG6Fl
 3zMzUrLHig1E8Sw0wC77HuChMTAyHaTtIU6TePmqqACbEeo7mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhaM1/0eqZsLsWgWx5n+CpB8VHdRKe9DW8ymWx7DK7hzBXC4fQzpdZdoqs8g4AzAnv
 rOUoz/3LSYxi5PFcXOazbuVjjCZaHUyFnYhRDBRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai/HRWa1I73ZRj6kmrwW0rlQ5AsbDlY2YICuj/RW+/8A5jPNTjfIGs9VXd4fFHIsCVQzFtX
 UToeeDCsYji7rnUykRhpdnh+5nzt5643MX02wIHInXY323FFr7KVdk4DMtCDEloKN0YXjTif
 VXevwhcjLcKYyDwMfAsO9LqVpp1pUQFKTgDfqCJBjapSsgqHDJrAAk3ORHJhAgBbWB3yPtlZ
 czBGSpSJSxDUfg6lVJauNvxIZdymH5imws/tLj7wgi117eELHmTTbYDPROHYYgEAFCs8G3oH
 hc2H5Xi9iizp8WnOHiNq9dMdwBRRZX5bLivw/Fqmie4ClIOMAkc5zX5m9vNoqQ8xfUFxNTbt
 GqwQFFZw1fZjHjKY1fCIHN6Zb+lGd41oXsnNGZ+dRylyloyU7aJta0/TpoQeaV41epByfUvc
 eIJVf/dCdtySxPG2Q8nU7/DkKJYei+Gvzm+ZxieXGBnfrpLZRD4xdv/Tw6+qAgMFnWWsOU9k
 Z2B1yTaY4gxeBQ6PvmLa/j1nlaVuEIZueNtXnnnJstYV1Xs/bNLdQ3wrK4TCOMdJSrTwgC10
 16tPi4Zgu3WsqkJ8NXtroKVnbeDSudRMBJTIDjG0OyQKyLfwFuG/aZBd+S5JRbmS2L+/fSZV
 9V/lv3THqUOowdXjtBaDb1u8KMZ4unvrZ98yiBPPi3CT3avO4NaDki25+t9nYwT+eYBoiqzY
 FyFxfdCM7bQOM/FLk8YFDB4Usu9j8MrihvgxtVrBn7l5R1H3quNCmRTGBiutBZzDpVINKEd/
 ONwn/JOtiKejEIxP8eknxJk0T2GDkY9XpUNsrAYB47WiTQX9GxSXKyENAjI5MCgVtYdFGgrP
 T6eu4TajZt+2EfpUiQ+BFrN78VnlLUMvxFBlmEZK3u3h+jq1+EF3UBSww8WVSVQ9A1MiMhoC
 1hoNmp0BKSAxChpj859RFKRGxlNKRma207pwX4LqTHpdFapXWnzM2ENA+aB00QH+WZ6fDIA3
 rWn5Ev6cDTtJufd4zATXBN7lvndUtBBzA3Ot8S5FcCjHZNhQz7EgLerVFUYuSncHsI9q03Wl
 9ZEpN8qR/XAChcRhKknB62x97caEkmELVMfZ8BRxvoCGGWEdQyi3TSLFVuKRfpMAP736m69N
 d1lI5Nedha51RvWlAshO4w3H+ZWksIqtf04QZG6AU4dsrCakChlj4KIyAj6m10QYotPleQTF
 9rvUgysQ02quGtsum7SrcN7FHKyTvsaaSbdgu2k0uU7OKgSkeNrcEpo7Kq4ukuEFSdG4hnOg
 hjPSJHL/cMz17ZtwojeKYRYJgCOMdiofv+5wAOylNVvbN30LsbFsT0OmGTnJwh7ObgwWcx9s
 Law7O7Mw0LOuYgpX1Djm5WuE7dD4eOwVrF1Nv3bAWZ7nyzYfuPR+DoGpn6FLKJWnONn5sWIQ
 xWybO2yf4U3X/Zf3HhkVDhMIS0CCqjYbrbSmg3llq6iUiMi6A3gKM+r0VTLbmsBLy8BBMDYO
 z/O4v2r4ohVkZRICBo6HMpZOp5fImL4eK4YZtb05Ci5DG6pvwu4gYHctyEcsBPFNnrVN/zBw
 8PhZgP/fxGMqq333Ilnk4htjCY2Uld5o8cNJ3w4xfAnqgqULmA7LtokDbsCN61FszfT0cj4b
 Q7dbWF5BiTaWy9FQCrG49/if1m+A+AQMI31PQ4WpkOdVDirNdnRHJpg6SZSzHNkcRTzzOycC
 I8/+1+hGjOT051WVeIoyfjjuthex9Te3WMuxU/mtfDLEzIyIOkvxWM7OhhgTgnFItHpuGSQA
 lZtXkFCYkWwaXCpIPZaY3QPRS0o5mL+/QsnfQKk4Yj6qY6E6MZi1femGeX48oNbXfQwPLRUG
 E/GHTqc0Vu3hE4Wl7Ai4e8yoKlODvmOIMi2AYnjSSAWnICy8m4XBNwDrwVeUPAd/BNjLH2Fm
 gmO+3QeAGG3GHJV0pCSyiQL/MtVeVAIBDfrkgX+hGHnlToU8tvnQCWpnTnLcczIl6vevktmG
 WZYKA7bplCNrzLrqAVvrvlR9BTNHcgVEmKCSSwyCI/7lhC3UmJGCbR9yAcA2slM9GFfjJBhH
 EpLPw7RJKr8Ns9O4+zloDvdSqNqtakMAFxZzaTk+A5mENe30429f9vRxnNWiOoNqUkeZLjD+
 pS7h5/j5cb+qgRVQjFjt8rWRdpw59xUEpomvU4nA5kyVqC0i/Aidl3R3eVqUB9bUbmMU4qEa
 0uX7fvT/dPb573yQpA4v2vUObg0NQ6jGoYNS6ck2JKqO3C7xlxV
IronPort-HdrOrdr: A9a23:p+DNiqtis/2CBsG2iT//yqfV7skDd9V00zEX/kB9WHVpmwKj+/
 xG+85rsiMc6QxhPE3I/OrrBEDuex3hHPJOirX5eI3DYOCEghrMEGgB1+rfKlTbckXDH6xmpM
 Rdms5Feb/N5DNB4voSjjPUL+od
X-Talos-CUID: =?us-ascii?q?9a23=3AIHS7fmmCptDO9Ecc5ZkKgCa11K/XOWeD91mAG06?=
 =?us-ascii?q?/Mmpoa76+GAK3w7pHstU7zg=3D=3D?=
X-Talos-MUID: 9a23:iWuhXASXI8XQJhu8RXTxtS9oBula/52BL1gii684pcCqNwd/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,182,1728943200"; 
   d="scan'208";a="102546532"
X-MGA-submission: =?us-ascii?q?MDGyyQUJbKrEXAtLnVJ6pjN3N4p9wdh6NdQ7Xp?=
 =?us-ascii?q?DMBBAHHYbX04B/FEdvgA+vmbrZNJ/MAbUUauCnpyj8twi0fLhExEJX+N?=
 =?us-ascii?q?2MSYUct/GUXkNUkOoh0EJqkXBGTDcAImrLXgsqBSnzzwt3LZ2m5RABqI?=
 =?us-ascii?q?Wlkolm0g1fN9V4Q9l2/+deLQ=3D=3D?=
Received: from server02.seltendoof.de ([168.119.48.163])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:40:34 +0100
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732531234;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8toJKTqYgiOm8yX0/nayZUss8l7ma5sqSjl7KCBpF0=;
	b=hlpyVRYUw1z9xdZYuJDetCTFRs3+Z1lxqLniLK0tn8ZkmcWiAL0wZ78aQGq5CBamzi3BHV
	9ieNcRpM7AGfB0BdD6l6XEGEzBKC9k8riy5y0h8JJXkaR+hA4W0RSz2SHOGCNm/utmsRAu
	6scALFYJ6L6f4jz72hqrt5zCGRec5vFh8cJ8r+g/FidQPHC401sojwGuGwasJDZtsSuTG+
	MFk4OzmeTYuB9D47W/amQTcxAHVR44Kd0A40nLT+O6oXPtDHrzLhNB9/rGRLHRQDFjf6nC
	uDUoXOqRx5fDWxJ10epkJwqkfBoBKMtSxMC4LcDFdEjqZI1nPZhmdSi/iwslTA==
To: linux-security-module@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	cocci@inria.fr
Date: Mon, 25 Nov 2024 11:40:01 +0100
Message-ID: <20241125104011.36552-8-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-1-cgoettsche@seltendoof.de>
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 09/11] fs: reorder capability check last
X-Loop: cocci@inria.fr
X-Sequence: 2107
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241125104011.36552-8-cgoettsche%40seltendoof.de>

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/fhandle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 5f801139358e..01b3e14e07de 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -265,9 +265,9 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
+		 !has_locked_children(real_mount(root->mnt), root->dentry) &&
 		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
-		 !has_locked_children(real_mount(root->mnt), root->dentry))
+			    CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
 		return false;
-- 
2.45.2

